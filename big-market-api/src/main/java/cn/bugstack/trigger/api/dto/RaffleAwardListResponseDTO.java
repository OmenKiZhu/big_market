package cn.bugstack.trigger.api.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/22
 * @Description: 抽奖列表应答对象
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RaffleAwardListResponseDTO {

    // 奖品ID
    private Integer awardId;
    // 奖品标题
    private String awardTitle;
    // 奖品副标题【抽奖1次后解锁】
    private String awardSubtitle;
    // 排序编号
    private Integer sort;

    // 奖品的次数规则 - 抽奖n次后解锁 未配置则为空
    private Integer awardRuleLockCount;

    private Boolean isAwardUnlock;

    private Integer waitUnLockCount;
}

