package cn.bugstack.domain.rebate.model.valobj;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/20
 * @Description: 返利类型枚举（sku 活动库存充值商品， integral 用户活动积分）
 */
@Getter
@AllArgsConstructor
public enum RebateTypeVO {

    SKU("sku","活动库存充值商品"),
    INTEGRAL("integral", "用户活动积分"),
    ;



    private final String code;
    private final String info;
}
