package cn.bugstack.test.infrastructure;

import cn.bugstack.infrastructure.persistent.dao.IRaffleActivityDao;
import cn.bugstack.infrastructure.persistent.po.RaffleActivity;
import com.alibaba.fastjson2.JSON;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;


/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/29
 * @Description:
 */
@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class RaffleActivityDaoTest {
    @Resource
    private IRaffleActivityDao raffleActivityDao;

    @Test
    public void testQueryRaffleActivityByActivityId() {
        RaffleActivity raffleActivity = raffleActivityDao.queryRaffleActivityByActivityId(100301L);
        log.info("查询结果: {}", JSON.toJSONString(raffleActivity));
    }
}

