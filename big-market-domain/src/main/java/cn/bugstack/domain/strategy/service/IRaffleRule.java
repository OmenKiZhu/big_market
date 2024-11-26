package cn.bugstack.domain.strategy.service;

import cn.bugstack.domain.strategy.model.valobj.RuleWeightVO;

import java.util.List;
import java.util.Map;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/6
 * @Description: 抽奖规则接口
 */
public interface IRaffleRule {
    /**
     * 根据规则树id集合 查询奖品中加锁数量的配置 【部分奖品需要抽奖N次解锁】
     * @param treeIds
     * @return
     */
    Map<String, Integer> queryAwardRuleLockCount(String[] treeIds);

    List<RuleWeightVO> queryAwardRuleWeight(Long strategyId);

    List<RuleWeightVO> queryAwardRuleWeightByActivityId(Long activityId);

}
