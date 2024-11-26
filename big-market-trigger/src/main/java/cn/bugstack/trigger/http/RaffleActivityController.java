package cn.bugstack.trigger.http;

import cn.bugstack.domain.activity.model.entity.ActivityAccountEntity;
import cn.bugstack.domain.activity.model.entity.UserRaffleOrderEntity;
import cn.bugstack.domain.activity.service.IRaffleActivityPartakeService;
import cn.bugstack.domain.activity.service.armory.IActivityArmory;
import cn.bugstack.domain.activity.service.quota.RaffleActivityAccountQuotaService;
import cn.bugstack.domain.award.model.entity.UserAwardRecordEntity;
import cn.bugstack.domain.award.model.valobj.AwardStateVO;
import cn.bugstack.domain.award.service.IAwardService;
import cn.bugstack.domain.rebate.model.entity.BehaviorEntity;
import cn.bugstack.domain.rebate.model.entity.BehaviorRebateOrderEntity;
import cn.bugstack.domain.rebate.model.valobj.BehaviorTypeVO;
import cn.bugstack.domain.rebate.service.BehaviorRebateService;
import cn.bugstack.domain.rebate.service.IBehaviorRebateService;
import cn.bugstack.domain.strategy.model.entity.RaffleAwardEntity;
import cn.bugstack.domain.strategy.model.entity.RaffleFactorEntity;
import cn.bugstack.domain.strategy.service.IRaffleStrategy;
import cn.bugstack.domain.strategy.service.armory.IStrategyArmory;
import cn.bugstack.trigger.api.IRaffleActivityService;
import cn.bugstack.trigger.api.dto.ActivityDrawRequestDTO;
import cn.bugstack.trigger.api.dto.ActivityDrawResponseDTO;
import cn.bugstack.trigger.api.dto.UserActivityAccountRequestDTO;
import cn.bugstack.trigger.api.dto.UserActivityAccountResponseDTO;
import cn.bugstack.types.enums.ResponseCode;
import cn.bugstack.types.exception.AppException;
import cn.bugstack.types.model.Response;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @author Omenki
 * @description 抽奖活动服务 注意；在不引用 application/case 层的时候，就需要让接口实现层来做领域的串联。一些较大规模的系统，需要加入 case 层。
 * @create 2024-04-13 09:42
 */
@Slf4j
@RestController() //@Controller 和 @ResponseBody 的组合 当你希望返回 JSON 或 XML 格式的数据时，可以使用 @ResponseBody。
@CrossOrigin("${app.config.cross-origin}") //跨域 从application.yml读取配置 此时设置为 * 开发阶段不做限制
@RequestMapping("/api/${app.config.api-version}/raffle/activity/")
public class RaffleActivityController implements IRaffleActivityService {

    private final SimpleDateFormat dateFormatDay = new SimpleDateFormat("yyyyMMdd");

    @Resource
    private IRaffleActivityPartakeService raffleActivityPartakeService;
    @Resource
    private IRaffleStrategy raffleStrategy;
    @Resource
    private IAwardService awardService;
    @Resource
    private IActivityArmory activityArmory;
    @Resource
    private IStrategyArmory strategyArmory;
    @Resource
    private IBehaviorRebateService behaviorService;
    @Autowired
    private BehaviorRebateService behaviorRebateService;
    @Autowired
    private RaffleActivityAccountQuotaService raffleActivityAccountQuotaService;

    /**
     * 活动装配 - 数据预热 | 把活动配置的对应的 sku 一起装配
     *
     * @param activityId 活动ID
     * @return 装配结果  装配活动  以及   策略 装配策略id对应的范围值 以及此id的范围查找表Map到缓存，以及rule_weight的重装配
     * <p>
     * 接口：<a href="http://localhost:8091/api/v1/raffle/activity/armory">/api/v1/raffle/activity/armory</a>
     * 入参：{"activityId":100001,"userId":"xiaofuge"}
     *
     * curl --request GET \
     *   --url 'http://localhost:8091/api/v1/raffle/activity/armory?activityId=100301'
     */
    @RequestMapping(value = "armory", method = RequestMethod.GET)
    @Override
    public Response<Boolean> armory(@RequestParam Long activityId) {
        try {
            log.info("活动装配，数据预热，开始 activityId:{}", activityId);
            // 1. 活动装配
            activityArmory.assembleActivitySkuByActivityId(activityId); // 包括活动的装配和活动次数的装配
            // 2. 策略装配 （对应的策略）
            strategyArmory.assembleLotteryStrategyByActivityId(activityId);
            Response<Boolean> response = Response.<Boolean>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(true)
                    .build();
            log.info("活动装配，数据预热，完成 activityId:{}", activityId);
            return response;
        } catch (Exception e) {
            log.error("活动装配，数据预热，失败 activityId:{}", activityId, e);
            return Response.<Boolean>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }

    /**
     * 抽奖接口
     *
     * @param request 请求对象
     * @return 抽奖结果
     * <p>
     * 接口：<a href="http://localhost:8091/api/v1/raffle/activity/draw">/api/v1/raffle/activity/draw</a>
     * 入参：{"activityId":100001,"userId":"xiaofuge"}
     *
     * curl --request POST \
     *   --url http://localhost:8091/api/v1/raffle/activity/draw \
     *   --header 'content-type: application/json' \
     *   --data '{
     *     "userId":"xiaofuge",
     *     "activityId": 100301
     * }'
     */
    @RequestMapping(value = "draw", method = RequestMethod.POST)
    @Override
    public Response<ActivityDrawResponseDTO> draw(@RequestBody ActivityDrawRequestDTO request) {
        try {
            log.info("活动抽奖 userId:{} activityId:{}", request.getUserId(), request.getActivityId());
            // 1. 参数校验
            if (StringUtils.isBlank(request.getUserId()) || null == request.getActivityId()) {
                throw new AppException(ResponseCode.ILLEGAL_PARAMETER.getCode(), ResponseCode.ILLEGAL_PARAMETER.getInfo());
            }
            // 2. 参与活动 - 创建参与记录订单
            UserRaffleOrderEntity orderEntity = raffleActivityPartakeService.createOrder(request.getUserId(), request.getActivityId());
            log.info("活动抽奖，创建订单 userId:{} activityId:{} orderId:{}", request.getUserId(), request.getActivityId(), orderEntity.getOrderId());
            // 3. 抽奖策略 - 执行抽奖
            RaffleAwardEntity raffleAwardEntity = raffleStrategy.performRaffle(RaffleFactorEntity.builder()
                    .userId(orderEntity.getUserId())
                    .strategyId(orderEntity.getStrategyId())
                            .endDateTime(orderEntity.getEndDateTime())
                    .build());
            // 4. 存放结果 - 写入中奖记录
            UserAwardRecordEntity userAwardRecord = UserAwardRecordEntity.builder()
                    .userId(orderEntity.getUserId())
                    .activityId(orderEntity.getActivityId())
                    .strategyId(orderEntity.getStrategyId())
                    .orderId(orderEntity.getOrderId())
                    .awardId(raffleAwardEntity.getAwardId())
                    .awardTitle(raffleAwardEntity.getAwardTitle())
                    .awardTime(new Date())
                    .awardState(AwardStateVO.create)
                    .build();
            awardService.saveUserAwardRecord(userAwardRecord);
            // 5. 返回结果
            return Response.<ActivityDrawResponseDTO>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(ActivityDrawResponseDTO.builder()
                            .awardId(raffleAwardEntity.getAwardId())
                            .awardTitle(raffleAwardEntity.getAwardTitle())
                            .awardIndex(raffleAwardEntity.getSort())
                            .build())
                    .build();
        } catch (AppException e) {
            log.error("活动抽奖失败 userId:{} activityId:{}", request.getUserId(), request.getActivityId(), e);
            return Response.<ActivityDrawResponseDTO>builder()
                    .code(e.getCode())
                    .info(e.getInfo())
                    .build();
        } catch (Exception e) {
            log.error("活动抽奖失败 userId:{} activityId:{}", request.getUserId(), request.getActivityId(), e);
            return Response.<ActivityDrawResponseDTO>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }


    /**
     * 日历签到返利接口
     *
     * <p>
     * 接口：<a href="http://localhost:8091/api/v1/raffle/activity/calendar_sign_rebate">/api/v1/raffle/activity/calendar_sign_rebate</a>
     * 入参：xiaofuge
     * <p>
     *
     * curl -X POST http://localhost:8091/api/v1/raffle/activity/calendar_sign_rebate -d "userId=xiaofuge" -H "Content-Type: application/x-www-form-urlencoded"
     *
     * @param userId
     * @return
     */
    @RequestMapping(value = "calendar_sign_rebate", method = RequestMethod.POST)
    @Override
    public Response<Boolean> calendarSignRebate(String userId) {
        try{
            log.info("日历签到返利开始 userId:{}", userId);
            BehaviorEntity behaviorEntity = new BehaviorEntity();
            behaviorEntity.setUserId(userId);
            behaviorEntity.setBehaviorTypeVO(BehaviorTypeVO.SIGN);
            behaviorEntity.setOutBusinessNo(dateFormatDay.format(new Date()));

            List<String> orderIds = behaviorRebateService.createOrder(behaviorEntity);
            log.info("日历签到返利完成 userId:{} orderIds:{}", userId, JSON.toJSONString(orderIds));

            return Response.<Boolean>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(true)
                    .build();
        } catch(AppException e){
            log.info("日历签到返利异常 userId:{}", userId, e);

            return Response.<Boolean>builder()
                    .code(e.getCode())
                    .info(e.getInfo())
                    .build();
        }
        catch (Exception e){
            log.info("日历签到返利失败 userId:{}", userId, e);
            return Response.<Boolean>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .data(false)
                    .build();
        }

    }

    @RequestMapping(value = "is_calendar_sign_rebate", method =RequestMethod.POST)
    @Override
    public Response<Boolean> isCalendarSignRebate(String userId) {
        try {
            log.info("查询用户是否完成日历签到返利开始---userId:{}", userId);
            String outBusinessNo = dateFormatDay.format(new Date());
            List<BehaviorRebateOrderEntity> behaviorRebateOrderEntityList = behaviorService.queryOrderByOutBusinessNo(userId, outBusinessNo);
            log.info("查询用户是否完成日历签到返利完成---userId:{}， order.size:{}", userId, behaviorRebateOrderEntityList.size());
            return Response.<Boolean>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(!behaviorRebateOrderEntityList.isEmpty())
                    .build();
        }catch(Exception e){
            log.error("查询用户是否完成日历签到返利失败---userId:{}", userId, e);
            return Response.<Boolean>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .data(false)
                    .build();
        }
    }

    @RequestMapping(value = "query_user_activity_account", method =RequestMethod.POST)
    @Override
    public Response<UserActivityAccountResponseDTO> queryUserActivityAccount(UserActivityAccountRequestDTO request) {
        try {
            log.info("查询用户活动账户开始---userId:{}, activityId:{}", request.getUserId(), request.getActivityId());
            // 1. 参数校验
            if(StringUtils.isBlank(request.getUserId()) || null == request.getActivityId()){
                throw new AppException(ResponseCode.ILLEGAL_PARAMETER.getCode(), ResponseCode.ILLEGAL_PARAMETER.getInfo());
            }

            ActivityAccountEntity activityAccountEntity = raffleActivityAccountQuotaService.queryActivityAccountEntity(request.getActivityId(), request.getUserId());
             UserActivityAccountResponseDTO userActivityAccountResponseDTO = UserActivityAccountResponseDTO.builder()
                          .totalCount(activityAccountEntity.getTotalCount())
                          .totalCountSurplus(activityAccountEntity.getTotalCountSurplus())
                          .dayCount(activityAccountEntity.getDayCount())
                          .dayCountSurplus(activityAccountEntity.getDayCountSurplus())
                          .monthCount(activityAccountEntity.getMonthCount())
                          .monthCountSurplus(activityAccountEntity.getMonthCountSurplus())
                          .build();
            log.info("查询用户活动账户完成---userId:{}, activityId:{}， DTO:{}", request.getUserId(), request.getActivityId(), JSON.toJSONString(userActivityAccountResponseDTO));
            return Response.<UserActivityAccountResponseDTO>builder()
                    .code(ResponseCode.SUCCESS.getCode())
                    .info(ResponseCode.SUCCESS.getInfo())
                    .data(userActivityAccountResponseDTO)
                    .build();
        } catch (Exception e) {
            log.error("查询用户活动账户失败---userId:{} activityId:{}", request.getUserId(), request.getActivityId(), e);
            return Response.<UserActivityAccountResponseDTO>builder()
                    .code(ResponseCode.UN_ERROR.getCode())
                    .info(ResponseCode.UN_ERROR.getInfo())
                    .build();
        }
    }

}
