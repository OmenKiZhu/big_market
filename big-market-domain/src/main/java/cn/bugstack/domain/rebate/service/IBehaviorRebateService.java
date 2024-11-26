package cn.bugstack.domain.rebate.service;

import cn.bugstack.domain.rebate.model.entity.BehaviorEntity;
import cn.bugstack.domain.rebate.model.entity.BehaviorRebateOrderEntity;

import java.util.List;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/19
 * @Description: 行为返利接口
 */
public interface IBehaviorRebateService {

    /**
     * 创建行为动作的入账订单
     * @param behaviorEntity
     * @return
     */
    List<String> createOrder(BehaviorEntity behaviorEntity);

    List<BehaviorRebateOrderEntity> queryOrderByOutBusinessNo(String userId, String outBusinessNo);
}
