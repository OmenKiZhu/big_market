package cn.bugstack.domain.activity.service.armory;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/30
 * @Description: 活动装配预热
 */
public interface IActivityArmory {

    //通过sku装配
    boolean assembleActivitySku(Long sku);

    //通过活动id装配
    boolean assembleActivitySkuByActivityId(Long activityId);
}
