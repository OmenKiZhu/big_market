package cn.bugstack.domain.rebate.model.entity;

import cn.bugstack.domain.rebate.model.valobj.BehaviorTypeVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/19
 * @Description: 行为动作实体
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BehaviorEntity {
    private String userId;

    //行为动作
    private BehaviorTypeVO behaviorTypeVO;

    //唯一幂等值 保证唯一
    private String outBusinessNo;
}
