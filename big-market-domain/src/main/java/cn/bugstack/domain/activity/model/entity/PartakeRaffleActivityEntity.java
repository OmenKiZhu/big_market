package cn.bugstack.domain.activity.model.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/31
 * @Description: 参与抽奖活动的实体对象
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PartakeRaffleActivityEntity {
    /*
    用户id
     */
    private String userId;

    /**
     * 活动id
     */
    private Long activityId;
}
