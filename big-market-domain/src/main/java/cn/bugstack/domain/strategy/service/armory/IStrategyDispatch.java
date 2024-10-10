package cn.bugstack.domain.strategy.service.armory;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/10
 * @Description: 策略抽奖调度
 */
public interface IStrategyDispatch {
    /**
     * 获取抽奖策略装配的随机结果
     *
     * @param strategyId 策略ID
     * @return 抽奖结果
     */
    Integer getRandomAwardId(Long strategyId);

    Integer getRandomAwardId(Long strategyId, String ruleWeightValue);
}
