package cn.bugstack.test.infrastructure;


import cn.bugstack.infrastructure.persistent.dao.IRaffleActivitySkuDao;
import cn.bugstack.infrastructure.persistent.po.RaffleActivitySku;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;

import javax.annotation.Resource;
import javax.swing.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/29
 * @Description:
 */
@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class RaffleActivitySkuDaoTest {
    @Resource
    private IRaffleActivitySkuDao raffleActivitySku;

    @Test
    public void test_queryRaffleActivitySku() {
        RaffleActivitySku raffleActivitySku01 = raffleActivitySku.queryActivitySku(9011L);
        log.info("测试结果：{}", JSON.toJSONString(raffleActivitySku01));
    }
}
