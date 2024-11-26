package cn.bugstack.domain.rebate.service;

import cn.bugstack.domain.rebate.event.SendRebateMessageEvent;
import cn.bugstack.domain.rebate.model.aggregate.BehaviorRebateAggregate;
import cn.bugstack.domain.rebate.model.entity.BehaviorEntity;
import cn.bugstack.domain.rebate.model.entity.BehaviorRebateOrderEntity;
import cn.bugstack.domain.rebate.model.entity.TaskEntity;
import cn.bugstack.domain.rebate.model.valobj.DailyBehaviorRebateVO;
import cn.bugstack.domain.rebate.model.valobj.TaskStateVO;
import cn.bugstack.domain.rebate.repository.IBehaviorRebateRepository;
import cn.bugstack.types.common.Constants;
import cn.bugstack.types.event.BaseEvent;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/19
 * @Description: 行为返利服务接口实现
 */
@Service
public class BehaviorRebateService implements IBehaviorRebateService {

    @Resource
    private  IBehaviorRebateRepository behaviorRebateRepository;

    @Resource
    private SendRebateMessageEvent sendRebateMessageEvent;

    @Override
    public List<String> createOrder(BehaviorEntity behaviorEntity) {
        // 1. 查询返利配置信息
        List<DailyBehaviorRebateVO> dailyBehaviorRebateVOs = behaviorRebateRepository.queryDailyBehaviorRebateConfig(behaviorEntity.getBehaviorTypeVO());

        // 2. 判断是否为空
        if(null == dailyBehaviorRebateVOs || dailyBehaviorRebateVOs.isEmpty())
            return new ArrayList<>();

        // 3. 构建聚合对象
        List<String> orderIds = new ArrayList<>();
        List<BehaviorRebateAggregate> behaviorRebateAggregates = new ArrayList<>();
        for(DailyBehaviorRebateVO dailyBehaviorRebateVO : dailyBehaviorRebateVOs){
            // 拼接返利订单业务id - biz_id
            String bidId = behaviorEntity.getUserId() + Constants.UNDERLINE + dailyBehaviorRebateVO.getRebateType() + Constants.UNDERLINE + behaviorEntity.getOutBusinessNo();
             BehaviorRebateOrderEntity behaviorRebateOrderEntity = BehaviorRebateOrderEntity.builder()
                          .userId(behaviorEntity.getUserId())
                          .orderId(RandomStringUtils.randomNumeric(12))
                          .behaviorType(dailyBehaviorRebateVO.getBehaviorType())
                          .rebateDesc(dailyBehaviorRebateVO.getRebateDesc())
                          .rebateType(dailyBehaviorRebateVO.getRebateType())
                          .rebateConfig(dailyBehaviorRebateVO.getRebateConfig())
                          .outBusinessNo(behaviorEntity.getOutBusinessNo())
                          .bizId(bidId)
                          .build();
            orderIds.add(behaviorRebateOrderEntity.getOrderId());

            //MQ 消息对象
            SendRebateMessageEvent.RebateMessage rebateMessage = SendRebateMessageEvent.RebateMessage.builder()
                    .userId(behaviorEntity.getUserId())
                    .rebateType(dailyBehaviorRebateVO.getRebateType())
                    .rebateConfig(dailyBehaviorRebateVO.getRebateConfig())
                    .bizId(bidId)
                    .build();

            // 构建事件消息
            BaseEvent.EventMessage<SendRebateMessageEvent.RebateMessage> rebateMessageEventMessage = sendRebateMessageEvent.buildEventMessage(rebateMessage);

            // 组装任务对象
             TaskEntity taskEntity = TaskEntity.builder()
                          .userId(behaviorEntity.getUserId())
                          .topic(sendRebateMessageEvent.topic())
                          .messageId(rebateMessageEventMessage.getId())
                          .message(rebateMessageEventMessage)
                          .state(TaskStateVO.create)
                          .build();

             // 聚合对象组装
            BehaviorRebateAggregate behaviorRebateAggregate = BehaviorRebateAggregate.builder()
                    .userId(behaviorEntity.getUserId())
                    .behaviorRebateOrderEntity(behaviorRebateOrderEntity)
                    .taskEntity(taskEntity)
                    .build();

            behaviorRebateAggregates.add(behaviorRebateAggregate);
        }

        // 3. 存储聚合对象数据
        behaviorRebateRepository.saveUserRebateRecord(behaviorEntity.getUserId(), behaviorRebateAggregates);

        // 4，返回订单id集合
        return orderIds;
    }

    @Override
    public List<BehaviorRebateOrderEntity> queryOrderByOutBusinessNo(String userId, String outBusinessNo) {

        return behaviorRebateRepository.queryOrderByOutBusinessNo(userId, outBusinessNo);
    }
}
