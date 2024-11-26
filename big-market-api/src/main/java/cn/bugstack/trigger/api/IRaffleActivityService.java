package cn.bugstack.trigger.api;

import cn.bugstack.trigger.api.dto.ActivityDrawRequestDTO;
import cn.bugstack.trigger.api.dto.ActivityDrawResponseDTO;
import cn.bugstack.trigger.api.dto.UserActivityAccountRequestDTO;
import cn.bugstack.trigger.api.dto.UserActivityAccountResponseDTO;
import cn.bugstack.types.model.Response;

/**
 * @Author: Masin_Zhu
 * @Date: 2024/11/5
 * @Description: 抽奖活动服务
 */
public interface IRaffleActivityService {

    /**
     * 活动装配 数据预热
     * @param activityId
     * @return
     */
    Response<Boolean> armory(Long activityId);

    /**
     * 活动抽奖接口
     * @param request
     * @return
     */

    Response<ActivityDrawResponseDTO> draw(ActivityDrawRequestDTO request);


    /**
     * 日历签到返利的接口
     * @param userId
     * @return
     */
    Response<Boolean> calendarSignRebate(String userId);


    /**
     * 判断是否已经完成日历签到返利的接口
     * @param userId
     * @return
     */
    Response<Boolean> isCalendarSignRebate(String userId);


    Response<UserActivityAccountResponseDTO> queryUserActivityAccount(UserActivityAccountRequestDTO request);
}
