package cn.bugstack.trigger.api.dto;

import lombok.Data;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/22
 * @Description:
 */
@Data
public class RaffleAwardListRequestDTO {

    // 抽奖策略ID
    @Deprecated
    private Long strategyId;


    private Long activityId;

    private String userId;
}
