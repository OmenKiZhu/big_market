package cn.bugstack.infrastructure.persistent.po;

import lombok.Data;

import java.util.Date;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/31
 * @Description: 任务表 发送MQ
 */
@Data
public class Task {

    /** 自增ID */
    private String id;
    /** 活动ID */
    private String userId;
    /** 消息主题 */
    private String topic;
    /** 消息ID */
    private String messageId;
    /** 消息主体 */
    private String message;
    /** 任务状态；create-创建、completed-完成、fail-失败 */
    private String state;
    /** 创建时间 */
    private Date createTime;
    /** 更新时间 */
    private Date updateTime;

}
