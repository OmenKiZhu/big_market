package cn.bugstack.domain.award.service;

import cn.bugstack.domain.award.model.entity.UserAwardRecordEntity;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/4
 * @Description: 奖品服务接口
 */
public interface IAwardService {
    void saveUserAwardRecord(UserAwardRecordEntity userAwardRecordEntity);
}
