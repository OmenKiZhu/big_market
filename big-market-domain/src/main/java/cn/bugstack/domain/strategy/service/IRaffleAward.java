package cn.bugstack.domain.strategy.service;

import cn.bugstack.domain.strategy.model.entity.StrategyAwardEntity;

import java.util.List;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/22
 * @Description: 策略奖品接口
 */
public interface IRaffleAward {
    List<StrategyAwardEntity> queryRaffleStrategyAwardList(Long strategyId);

    List<StrategyAwardEntity> queryRaffleStrategyAwardListByActivityId(Long activityId);
}
