package cn.bugstack.infrastructure.persistent.repository;

import cn.bugstack.domain.rebate.model.aggregate.BehaviorRebateAggregate;
import cn.bugstack.domain.rebate.model.entity.BehaviorRebateOrderEntity;
import cn.bugstack.domain.rebate.model.entity.TaskEntity;
import cn.bugstack.domain.rebate.model.valobj.BehaviorTypeVO;
import cn.bugstack.domain.rebate.model.valobj.DailyBehaviorRebateVO;
import cn.bugstack.domain.rebate.repository.IBehaviorRebateRepository;
import cn.bugstack.infrastructure.event.EventPublisher;
import cn.bugstack.infrastructure.persistent.dao.IDailyBehaviorRebateDao;
import cn.bugstack.infrastructure.persistent.dao.ITaskDao;
import cn.bugstack.infrastructure.persistent.dao.IUserBehaviorRebateOrderDao;
import cn.bugstack.infrastructure.persistent.po.DailyBehaviorRebate;
import cn.bugstack.infrastructure.persistent.po.Task;
import cn.bugstack.infrastructure.persistent.po.UserBehaviorRebateOrder;
import cn.bugstack.middleware.db.router.strategy.IDBRouterStrategy;
import cn.bugstack.types.enums.ResponseCode;
import cn.bugstack.types.exception.AppException;
import com.alibaba.fastjson2.JSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.support.TransactionTemplate;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/20
 * @Description:
 */
@Repository
@Slf4j
public class BehaviorRebateRepository implements IBehaviorRebateRepository {

    @Resource
    private IDailyBehaviorRebateDao dailyBehaviorRebateDao;
    @Resource
    private IUserBehaviorRebateOrderDao userBehaviorRebateOrderDao;
    @Resource
    private ITaskDao taskDao;
    @Resource
    private IDBRouterStrategy dbRouter;
    @Resource
    private TransactionTemplate transactionTemplate;
    @Resource
    private EventPublisher eventPublisher;


    @Override
    public List<DailyBehaviorRebateVO> queryDailyBehaviorRebateConfig(BehaviorTypeVO behaviorTypeVO) {
        List<DailyBehaviorRebate> dailyBehaviorRebates = dailyBehaviorRebateDao.queryDailyBehaviorRebateByBehaviorType(behaviorTypeVO.getCode());
        List<DailyBehaviorRebateVO> dailyBehaviorRebateVOList = new ArrayList<>();
        for(DailyBehaviorRebate dailyBehaviorRebate : dailyBehaviorRebates)
        {
            DailyBehaviorRebateVO dailyBehaviorRebateVO = DailyBehaviorRebateVO.builder()
                            .behaviorType(dailyBehaviorRebate.getBehaviorType())
                            .rebateDesc(dailyBehaviorRebate.getRebateDesc())
                            .rebateType(dailyBehaviorRebate.getRebateType())
                            .rebateConfig(dailyBehaviorRebate.getRebateConfig())
                            .build();

            dailyBehaviorRebateVOList.add(dailyBehaviorRebateVO);
        }
        return dailyBehaviorRebateVOList;
    }




    @Override
    public void saveUserRebateRecord(String userId, List<BehaviorRebateAggregate> behaviorRebateAggregates) {
        try{
            dbRouter.doRouter(userId);
            transactionTemplate.execute(status -> {
                try{
                    for(BehaviorRebateAggregate behaviorRebateAggregate : behaviorRebateAggregates){
                        BehaviorRebateOrderEntity behaviorRebateOrderEntity = behaviorRebateAggregate.getBehaviorRebateOrderEntity();

                        // 用户返利订单对象
                         UserBehaviorRebateOrder userBehaviorRebateOrder = UserBehaviorRebateOrder.builder()
                                                  .userId(behaviorRebateOrderEntity.getUserId())
                                                  .orderId(behaviorRebateOrderEntity.getOrderId())
                                                  .behaviorType(behaviorRebateOrderEntity.getBehaviorType())
                                                  .rebateDesc(behaviorRebateOrderEntity.getRebateDesc())
                                                  .rebateType(behaviorRebateOrderEntity.getRebateType())
                                                  .rebateConfig(behaviorRebateOrderEntity.getRebateConfig())
                                                  .outBusinessNo(behaviorRebateOrderEntity.getOutBusinessNo())
                                                  .bizId(behaviorRebateOrderEntity.getBizId())
                                                  .build();
                         //保存订单到库表
                        userBehaviorRebateOrderDao.insert(userBehaviorRebateOrder);

                        // 任务对象
                        TaskEntity taskEntity = behaviorRebateAggregate.getTaskEntity();
                        Task task = new Task();
                        task.setUserId(taskEntity.getUserId());
                        task.setTopic(taskEntity.getTopic());
                        task.setMessageId(taskEntity.getMessageId());
                        task.setMessage(JSON.toJSONString(taskEntity.getMessage()));
                        task.setState(taskEntity.getState().getCode());
                        taskDao.insert(task);
                    }
                    return 1;
                } catch(DuplicateKeyException e){
                    status.setRollbackOnly();
                    log.error("写入返利记录，唯一索引冲突 userId:{}", userId, e);
                    throw new AppException(ResponseCode.INDEX_DUP.getCode(), e);
                }
            });
        } finally {
            dbRouter.clear();
        }

        // 同步发送MQ消息
        for(BehaviorRebateAggregate behaviorRebateAggregate : behaviorRebateAggregates)
        {
            TaskEntity taskEntity = behaviorRebateAggregate.getTaskEntity();
            Task task = new Task();
            task.setUserId(taskEntity.getUserId());
            task.setMessageId(taskEntity.getMessageId());
            try{
                // 发送消息【在事务外执行，如果失败还有任务补偿】
                eventPublisher.publish(taskEntity.getTopic(), taskEntity.getMessage());
                // 更细库表记录， task 任务表
                taskDao.updateTaskSendMessageCompleted(task);
            } catch(Exception e) {
                log.error("写入返利记录，发送MQ消息失败 userId:{} topic:{}", userId, task.getTopic());
                taskDao.updateTaskSendMessageFail(task);
            }
        }
    }

    @Override
    public List<BehaviorRebateOrderEntity> queryOrderByOutBusinessNo(String userId, String outBusinessNo) {
        // 1. 请求对象的构建
        UserBehaviorRebateOrder userBehaviorRebateOrderReq = new UserBehaviorRebateOrder();
        userBehaviorRebateOrderReq.setUserId(userId);
        userBehaviorRebateOrderReq.setOutBusinessNo(outBusinessNo);

        // 2. 查询结果
        List<UserBehaviorRebateOrder> userBehaviorRebateOrderResList =  userBehaviorRebateOrderDao.queryOrderByOutBusinessNo(userBehaviorRebateOrderReq);
        List<BehaviorRebateOrderEntity> behaviorRebateOrderEntityList = new ArrayList<>(userBehaviorRebateOrderResList.size());
        for(UserBehaviorRebateOrder userBehaviorRebateOrder : userBehaviorRebateOrderResList)
        {
            BehaviorRebateOrderEntity behaviorRebateOrderEntity = BehaviorRebateOrderEntity.builder()
                    .userId(userBehaviorRebateOrder.getUserId())
                    .orderId(userBehaviorRebateOrder.getOrderId())
                    .behaviorType(userBehaviorRebateOrder.getBehaviorType())
                    .rebateDesc(userBehaviorRebateOrder.getRebateDesc())
                    .rebateType(userBehaviorRebateOrder.getRebateType())
                    .rebateConfig(userBehaviorRebateOrder.getRebateConfig())
                    .outBusinessNo(userBehaviorRebateOrder.getOutBusinessNo())
                    .bizId(userBehaviorRebateOrder.getBizId())
                    .build();
            behaviorRebateOrderEntityList.add(behaviorRebateOrderEntity);
        }
        return behaviorRebateOrderEntityList;
    }

}
