package cn.bugstack.domain.activity.model.valobj;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/31
 * @Description: 用户抽奖单状态枚举
 */
@Getter
@AllArgsConstructor
public enum UserRaffleOrderStateVO {

    create("create", "创建"),
    used("user","已使用"),
    cancel("cancel","已作废")
    ;

    private final String code;
    private final String desc;
}
