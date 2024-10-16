package cn.bugstack.domain.strategy.service.rule.chain;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/15
 * @Description: 链的装配接口
 */
public interface ILogicChainArmory {
    ILogicChain appendNext(ILogicChain Next);

    ILogicChain next();
}
