package cn.bugstack.infrastructure.persistent.dao;

import cn.bugstack.infrastructure.persistent.po.UserAwardRecord;
import cn.bugstack.middleware.db.router.annotation.DBRouterStrategy;
import org.apache.ibatis.annotations.Mapper;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/31
 * @Description:
 */
@Mapper
@DBRouterStrategy(splitTable = true)  //为什么这里要加DBRouterStrategy?? 当时没加它报错了
public interface IUserAwardRecordDao {
    void insert(UserAwardRecord userAwardRecord);
}
