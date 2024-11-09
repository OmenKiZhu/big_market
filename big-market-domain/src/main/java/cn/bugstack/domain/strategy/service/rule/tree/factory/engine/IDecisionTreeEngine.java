package cn.bugstack.domain.strategy.service.rule.tree.factory.engine;

import cn.bugstack.domain.strategy.service.rule.tree.factory.DefaultTreeFactory;

import java.util.Date;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/16
 * @Description: 规则树的组合接口
 */
public interface IDecisionTreeEngine {
    DefaultTreeFactory.StrategyAwardVO process(String UseId, Long strategyId, Integer awardId, Date endDateTime);
}
