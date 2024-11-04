package cn.bugstack.trigger.job;

import cn.bugstack.domain.task.model.entity.TaskEntity;
import cn.bugstack.domain.task.service.ITaskService;
import cn.bugstack.middleware.db.router.strategy.IDBRouterStrategy;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/4
 * @Description: 发送MQ消息的队列任务
 */
@Slf4j
@Component
public class SendMessageTaskJob {

    @Resource
    private ITaskService taskService;
    @Resource
    private ThreadPoolExecutor executor;
    @Resource
    private IDBRouterStrategy dbRouter;

    @Scheduled(cron = "0/5 * * * * ?")
    public void exec(){
        try {
            // 获得分库数量
            int count = dbRouter.dbCount();

            for(int dbidx = 1; dbidx <= count; dbidx++)
            {
                int finalDbIdx = dbidx;
                executor.execute(new Runnable(){
                    @Override
                    public void run() {
                        try{
                            dbRouter.setDBKey(finalDbIdx);
                            dbRouter.setTBKey(0);
                            List<TaskEntity> taskEntities = taskService.queryNoSendMessageTaskList();

                            //发送MQ消息
                            for (TaskEntity taskEntity : taskEntities) {
                                //开启线程发送 提高发送效率 配置的线程池策略为 CollerRunPolicy ,在ThreadPoolConfig中有四个策略 面试容易对比提问
                                executor.execute(() ->{
                                    try {
                                        taskService.sendMessage(taskEntity);
                                        taskService.updateTaskSendMessageCompleted(taskEntity.getUserId(), taskEntity.getMessageId());
                                    } catch (Exception e) {
                                        log.error("定时任务 发送mq消息失败");
                                        taskService.updateTaskSendMessageFail(taskEntity.getUserId(), taskEntity.getMessageId());
                                    }
                                });
                            }
                        } finally {
                            dbRouter.clear();
                        }

                    }
                });
            }

            dbRouter.setDBKey(1);
            dbRouter.setTBKey(0);

            List<TaskEntity> taskEntities = taskService.queryNoSendMessageTaskList();
            log.info("测试结果 ：{}" , taskEntities.size());
        } catch (Exception e) {
            log.error("定时任务，扫描mq任务表发送消息失败。 ", e);
        } finally {
            dbRouter.clear();
        }
    }
}
