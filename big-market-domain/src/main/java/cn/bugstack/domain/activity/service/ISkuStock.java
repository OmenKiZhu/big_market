package cn.bugstack.domain.activity.service;

import cn.bugstack.domain.activity.model.valobj.ActivitySkuStockKeyVO;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/30
 * @Description: 活动sku库存处理接口
 */
public interface ISkuStock {

    /**
     * 获取活动sku库存消耗队列
     * @return
     * @throws InterruptedException
     */
    ActivitySkuStockKeyVO takeQueueValue() throws InterruptedException;

    /**
     * 清空队列
     */
    void clearQueueValue();

    /**
     * 延迟队列 + 任务趋势更新活动sku库存
     * @param sku
     */
    void updateActivitySkuStock(Long sku);

    /**
     * 缓存库存消耗完毕，清空数据库库存
     * @param sku
     */
    void clearActivitySkuStock(Long sku);
}
