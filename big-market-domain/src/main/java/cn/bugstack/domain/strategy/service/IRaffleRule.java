package cn.bugstack.domain.strategy.service;

import java.util.Map;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/6
 * @Description: 抽奖规则接口
 */
public interface IRaffleRule {
    Map<String, Integer> queryAwardRuleLockCount(String[] treeIds);
}
