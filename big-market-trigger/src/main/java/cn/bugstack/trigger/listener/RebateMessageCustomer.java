package cn.bugstack.trigger.listener;

import cn.bugstack.domain.activity.model.entity.SkuRechargeEntity;
import cn.bugstack.domain.activity.service.IRaffleActivityAccountQuotaService;
import cn.bugstack.domain.rebate.event.SendRebateMessageEvent;
import cn.bugstack.domain.rebate.model.valobj.RebateTypeVO;
import cn.bugstack.types.event.BaseEvent;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/20
 * @Description: 监听行为返利消息
 */
@Slf4j
@Component
public class RebateMessageCustomer {

    @Value("spring.rabbitmq.topic.send_rebate")
    private String topic;

    @Resource
    private IRaffleActivityAccountQuotaService raffleActivityAccountQuotaService;

    @RabbitListener(queuesToDeclare = @Queue(value = "${spring.rabbitmq.topic.send_rebate}"))
    public void listener(String message){
        try{
            log.info("监听用户行为返利消息 topic:{} message:{}", topic , message);

            // 1. 转换消息  使用JSON.parseObject转换 由于是泛型类型，需要使用TypeReference来指定复杂泛型类型
            BaseEvent.EventMessage<SendRebateMessageEvent.RebateMessage> eventMessage = JSON.parseObject(message, new TypeReference<BaseEvent.EventMessage<SendRebateMessageEvent.RebateMessage>>() {
            }.getType());

            SendRebateMessageEvent.RebateMessage rebateMessage = eventMessage.getData();
            if(!rebateMessage.getRebateType().equals(RebateTypeVO.SKU.getCode())){
                log.info("监听用户行为返利消息 - 非sku的行为消息，暂时不处理 topic:{} message:{}", topic, message);
                return;
            }

            // 2. 入账奖励
            SkuRechargeEntity skuRechargeEntity = new SkuRechargeEntity();
            skuRechargeEntity.setUserId(rebateMessage.getUserId());
            skuRechargeEntity.setSku(Long.valueOf(rebateMessage.getRebateConfig()));
            skuRechargeEntity.setOutBusinessNo(rebateMessage.getBizId());
            raffleActivityAccountQuotaService.createOrder(skuRechargeEntity);

        } catch(Exception e){
            log.error("监听用户行为返利消息，消费失败 topic:{} message:{}", topic , message, e);
        }
    }
}
