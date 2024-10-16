package cn.bugstack.domain.strategy.service.rule.chain;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/15
 * @Description:
 */
public abstract class AbstractLogicChain implements ILogicChain{

    private ILogicChain next;

    @Override
    public ILogicChain next() {
        return next;
    }

    @Override
    public ILogicChain appendNext(ILogicChain next) {
         this.next = next;
        return next;
    }



    protected abstract String ruleModel();

}
