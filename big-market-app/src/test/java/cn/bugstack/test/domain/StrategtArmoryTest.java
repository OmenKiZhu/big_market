package cn.bugstack.test.domain;

import cn.bugstack.domain.strategy.service.armory.IStrategyArmory;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/10/9
 * @Description: 装配测试
 */
@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class StrategtArmoryTest {

    @Resource
    private IStrategyArmory strategyArmory;

    @Test
    public void testStrategyArmory()
    {
        strategyArmory.assembleLotteryStrategy(100001L);
    }

    @Test
    public void testGetAssemblerRandomVal() {
        log.info("测试结果:{}----奖品ID值", strategyArmory.getRandomAwardId(100001L));
        log.info("测试结果:{}----奖品ID值", strategyArmory.getRandomAwardId(100001L));
        log.info("测试结果:{}----奖品ID值", strategyArmory.getRandomAwardId(100001L));
        log.info("测试结果:{}----奖品ID值", strategyArmory.getRandomAwardId(100001L));
    }

}
