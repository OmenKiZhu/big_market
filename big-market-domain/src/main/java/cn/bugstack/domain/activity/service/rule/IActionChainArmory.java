package cn.bugstack.domain.activity.service.rule;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/29
 * @Description: 下单规则链装配接口
 */
public interface IActionChainArmory {

    IActionChain next();

    IActionChain appendNext(IActionChain next);
}
