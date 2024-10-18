package cn.bugstack.domain.strategy.model.valobj;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/18
 * @Description: 策略奖品库存Key标识值对象
 */

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class StrategyAwardStockKeyVO {

    //策略Id
    private Long strategyId;

    //奖品ID
    private Integer awardId;
}
