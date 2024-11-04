package cn.bugstack.infrastructure.persistent.repository;

import cn.bugstack.domain.task.model.entity.TaskEntity;
import cn.bugstack.domain.task.repository.ITaskRepository;
import cn.bugstack.infrastructure.event.EventPublisher;
import cn.bugstack.infrastructure.persistent.dao.ITaskDao;
import cn.bugstack.infrastructure.persistent.po.Task;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;

import java.util.List;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/4
 * @Description:
 */
@Repository
public class TaskRepository implements ITaskRepository {

    @Resource
    private ITaskDao taskDao;
    @Resource
    private EventPublisher eventPublisher;


    @Override
    public List<TaskEntity> queryNoSendMessageTaskList() {
        List<Task> tasks = taskDao.queryNoSendMessageTaskList(); //持久化对象
        List<TaskEntity> taskEntities = new ArrayList<>(tasks.size());
        for (Task task : tasks){
            TaskEntity taskEntity = TaskEntity.builder()
                        .userId(task.getUserId())
                        .topic(task.getTopic())
                        .messageId(task.getMessageId())
                        .message(task.getMessage())
                        .build();
            taskEntities.add(taskEntity);
        }
        return taskEntities;
    }

    @Override
    public void sendMessage(TaskEntity taskEntity) {
        eventPublisher.publish(taskEntity.getTopic(), taskEntity.getMessage());
    }

    @Override
    public void updateTaskSendMessageCompleted(String userId, String messageId) {
        Task task = new Task();
        task.setUserId(userId);
        task.setMessageId(messageId);
        taskDao.updateTaskSendMessageCompleted(task);
    }

    @Override
    public void updateTaskSendMessageFail(String userId, String messageId) {
        Task task = new Task();
        task.setUserId(userId);
        task.setMessageId(messageId);
        taskDao.updateTaskSendMessageFail(task);
    }
}
