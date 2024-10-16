package cn.bugstack.domain.strategy.service.rule.chain;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/15
 * @Description: 责任链接口
 */
public interface ILogicChain extends ILogicChainArmory{
    /**
     * 责任链接口
     * @param userId
     * @param strategyId
     * @return
     */
    Integer logic(String userId, Long strategyId);


}
