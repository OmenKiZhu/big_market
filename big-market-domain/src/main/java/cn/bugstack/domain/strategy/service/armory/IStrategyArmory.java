package cn.bugstack.domain.strategy.service.armory;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 策略装配库(兵工厂)，负责初始化策略计算
 * @create 2023-12-23 09:44
 */
public interface IStrategyArmory {

    /**
     * 装配抽奖策略配置「触发的时机可以为活动审核通过后进行调用」
     *
     * @param strategyId 策略ID
     * @return 装配结果
     */
    boolean assembleLotteryStrategy(Long strategyId);


    //实际是通过活动id查询到策略id再进行装配 终究使用的是策略id的装配方法
    boolean assembleLotteryStrategyByActivityId(Long activityId);

}
