package cn.bugstack.domain.activity.model.valobj;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/30
 * @Description: 活动sku 库存  key值对象
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ActivitySkuStockKeyVO {
    /** 商品sku */
    private Long sku;
    /** 活动id */
    private Long activityId;
}
