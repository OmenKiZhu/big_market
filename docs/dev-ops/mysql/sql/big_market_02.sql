-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2024-11-27 10:28:01
-- 服务器版本： 8.0.32
-- PHP 版本： 8.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `big_market_02`
--

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_account`
--

CREATE TABLE `raffle_activity_account` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `total_count` int NOT NULL COMMENT '总次数',
  `total_count_surplus` int NOT NULL COMMENT '总次数-剩余',
  `day_count` int NOT NULL COMMENT '日次数',
  `day_count_surplus` int NOT NULL COMMENT '日次数-剩余',
  `month_count` int NOT NULL COMMENT '月次数',
  `month_count_surplus` int NOT NULL COMMENT '月次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动账户表';

--
-- 转存表中的数据 `raffle_activity_account`
--

INSERT INTO `raffle_activity_account` (`id`, `user_id`, `activity_id`, `total_count`, `total_count_surplus`, `day_count`, `day_count_surplus`, `month_count`, `month_count_surplus`, `create_time`, `update_time`) VALUES
(2, 'xiaofuge2', 100301, 4, 3, 4, 3, 4, 3, '2024-03-23 12:40:56', '2024-03-23 13:16:40'),
(3, 'xiaofuge1', 100301, 10, 10, 10, 10, 10, 10, '2024-05-03 16:01:44', '2024-05-03 16:01:44');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_account_day`
--

CREATE TABLE `raffle_activity_account_day` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `day` varchar(10) NOT NULL COMMENT '日期（yyyy-mm-dd）',
  `day_count` int NOT NULL COMMENT '日次数',
  `day_count_surplus` int NOT NULL COMMENT '日次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动账户表-日次数';

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_account_month`
--

CREATE TABLE `raffle_activity_account_month` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `month` varchar(7) NOT NULL COMMENT '月（yyyy-mm）',
  `month_count` int NOT NULL COMMENT '月次数',
  `month_count_surplus` int NOT NULL COMMENT '月次数-剩余',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动账户表-月次数';

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_order_000`
--

CREATE TABLE `raffle_activity_order_000` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint NOT NULL COMMENT '商品sku',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int NOT NULL COMMENT '总次数',
  `day_count` int NOT NULL COMMENT '日次数',
  `month_count` int NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动单';

--
-- 转存表中的数据 `raffle_activity_order_000`
--

INSERT INTO `raffle_activity_order_000` (`id`, `user_id`, `sku`, `activity_id`, `activity_name`, `strategy_id`, `order_id`, `order_time`, `total_count`, `day_count`, `month_count`, `state`, `out_business_no`, `create_time`, `update_time`) VALUES
(1, 'xiaofuge1', 9011, 100301, '测试活动', 100006, '831917125310', '2024-05-03 08:01:44', 10, 10, 10, 'completed', 'xiaofuge1_sku_20240503', '2024-05-03 16:01:44', '2024-05-03 16:01:44');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_order_001`
--

CREATE TABLE `raffle_activity_order_001` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint NOT NULL COMMENT '商品sku',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int NOT NULL COMMENT '总次数',
  `day_count` int NOT NULL COMMENT '日次数',
  `month_count` int NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动单';

--
-- 转存表中的数据 `raffle_activity_order_001`
--

INSERT INTO `raffle_activity_order_001` (`id`, `user_id`, `sku`, `activity_id`, `activity_name`, `strategy_id`, `order_id`, `order_time`, `total_count`, `day_count`, `month_count`, `state`, `out_business_no`, `create_time`, `update_time`) VALUES
(3, 'xiaofuge', 9011, 100301, '测试活动', 100006, '383240888158', '2024-03-23 04:38:23', 1, 1, 1, 'completed', '700091009111', '2024-03-23 12:38:23', '2024-03-23 12:38:23');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_order_002`
--

CREATE TABLE `raffle_activity_order_002` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint NOT NULL COMMENT '商品sku',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int NOT NULL COMMENT '总次数',
  `day_count` int NOT NULL COMMENT '日次数',
  `month_count` int NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动单';

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_order_003`
--

CREATE TABLE `raffle_activity_order_003` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `sku` bigint NOT NULL COMMENT '商品sku',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `total_count` int NOT NULL COMMENT '总次数',
  `day_count` int NOT NULL COMMENT '日次数',
  `month_count` int NOT NULL COMMENT '月次数',
  `state` varchar(16) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传的，确保幂等',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动单';

-- --------------------------------------------------------

--
-- 表的结构 `task`
--

CREATE TABLE `task` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `topic` varchar(32) NOT NULL COMMENT '消息主题',
  `message_id` varchar(11) DEFAULT NULL COMMENT '消息编号',
  `message` varchar(512) NOT NULL COMMENT '消息主体',
  `state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '任务状态；create-创建、completed-完成、fail-失败',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务表，发送MQ';

--
-- 转存表中的数据 `task`
--

INSERT INTO `task` (`id`, `user_id`, `topic`, `message_id`, `message`, `state`, `create_time`, `update_time`) VALUES
(1, 'xiaofuge1', 'send_rebate', '54825531405', '{\"data\":{\"bizId\":\"xiaofuge1_sku_20240503\",\"rebateConfig\":\"9011\",\"rebateType\":\"sku\",\"userId\":\"xiaofuge1\"},\"id\":\"54825531405\",\"timestamp\":1714723302543}', 'completed', '2024-05-03 16:01:43', '2024-05-03 16:01:43'),
(2, 'xiaofuge1', 'send_rebate', '43189560552', '{\"data\":{\"bizId\":\"xiaofuge1_integral_20240503\",\"rebateConfig\":\"10\",\"rebateType\":\"integral\",\"userId\":\"xiaofuge1\"},\"id\":\"43189560552\",\"timestamp\":1714723302551}', 'completed', '2024-05-03 16:01:43', '2024-05-03 16:01:43');

-- --------------------------------------------------------

--
-- 表的结构 `user_award_record_000`
--

CREATE TABLE `user_award_record_000` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户中奖记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_award_record_001`
--

CREATE TABLE `user_award_record_001` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户中奖记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_award_record_002`
--

CREATE TABLE `user_award_record_002` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户中奖记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_award_record_003`
--

CREATE TABLE `user_award_record_003` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '抽奖订单ID【作为幂等使用】',
  `award_id` int NOT NULL COMMENT '奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '奖品标题（名称）',
  `award_time` datetime NOT NULL COMMENT '中奖时间',
  `award_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '奖品状态；create-创建、completed-发奖完成',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户中奖记录表';

-- --------------------------------------------------------

--
-- 表的结构 `user_behavior_rebate_order_000`
--

CREATE TABLE `user_behavior_rebate_order_000` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传，方便查询使用',
  `biz_id` varchar(128) NOT NULL COMMENT '业务ID - 拼接的唯一值。拼接 out_business_no + 自身枚举',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为返利流水订单表';

--
-- 转存表中的数据 `user_behavior_rebate_order_000`
--

INSERT INTO `user_behavior_rebate_order_000` (`id`, `user_id`, `order_id`, `behavior_type`, `rebate_desc`, `rebate_type`, `rebate_config`, `out_business_no`, `biz_id`, `create_time`, `update_time`) VALUES
(5, 'xiaofuge1', '883971522401', 'sign', '签到返利-sku额度', 'sku', '9011', '20240503', 'xiaofuge1_sku_20240503', '2024-05-03 16:01:42', '2024-05-03 16:01:42'),
(6, 'xiaofuge1', '995944930386', 'sign', '签到返利-积分', 'integral', '10', '20240503', 'xiaofuge1_integral_20240503', '2024-05-03 16:01:43', '2024-05-03 16:01:43');

-- --------------------------------------------------------

--
-- 表的结构 `user_behavior_rebate_order_001`
--

CREATE TABLE `user_behavior_rebate_order_001` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传，方便查询使用',
  `biz_id` varchar(128) NOT NULL COMMENT '业务ID - 拼接的唯一值。拼接 out_business_no + 自身枚举',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为返利流水订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_behavior_rebate_order_002`
--

CREATE TABLE `user_behavior_rebate_order_002` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传，方便查询使用',
  `biz_id` varchar(128) NOT NULL COMMENT '业务ID - 拼接的唯一值。拼接 out_business_no + 自身枚举',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为返利流水订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_behavior_rebate_order_003`
--

CREATE TABLE `user_behavior_rebate_order_003` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `out_business_no` varchar(64) NOT NULL COMMENT '业务仿重ID - 外部透传，方便查询使用',
  `biz_id` varchar(128) NOT NULL COMMENT '业务ID - 拼接的唯一值。拼接 out_business_no + 自身枚举',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为返利流水订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_behavior_rebate_order_004`
--

CREATE TABLE `user_behavior_rebate_order_004` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置【sku值，积分值】',
  `biz_id` varchar(64) NOT NULL COMMENT '业务ID - 拼接的唯一值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户行为返利流水订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_raffle_order_000`
--

CREATE TABLE `user_raffle_order_000` (
  `id` int UNSIGNED NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户抽奖订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_raffle_order_001`
--

CREATE TABLE `user_raffle_order_001` (
  `id` int UNSIGNED NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户抽奖订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_raffle_order_002`
--

CREATE TABLE `user_raffle_order_002` (
  `id` int UNSIGNED NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户抽奖订单表';

-- --------------------------------------------------------

--
-- 表的结构 `user_raffle_order_003`
--

CREATE TABLE `user_raffle_order_003` (
  `id` int UNSIGNED NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `order_id` varchar(12) NOT NULL COMMENT '订单ID',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_state` varchar(16) NOT NULL DEFAULT 'create' COMMENT '订单状态；create-创建、used-已使用、cancel-已作废',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户抽奖订单表';

--
-- 转储表的索引
--

--
-- 表的索引 `raffle_activity_account`
--
ALTER TABLE `raffle_activity_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_id_activity_id` (`user_id`,`activity_id`);

--
-- 表的索引 `raffle_activity_account_day`
--
ALTER TABLE `raffle_activity_account_day`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_id_activity_id_day` (`user_id`,`activity_id`,`day`);

--
-- 表的索引 `raffle_activity_account_month`
--
ALTER TABLE `raffle_activity_account_month`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_id_activity_id_month` (`user_id`,`activity_id`,`month`);

--
-- 表的索引 `raffle_activity_order_000`
--
ALTER TABLE `raffle_activity_order_000`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`);

--
-- 表的索引 `raffle_activity_order_001`
--
ALTER TABLE `raffle_activity_order_001`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`);

--
-- 表的索引 `raffle_activity_order_002`
--
ALTER TABLE `raffle_activity_order_002`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`);

--
-- 表的索引 `raffle_activity_order_003`
--
ALTER TABLE `raffle_activity_order_003`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_out_business_no` (`out_business_no`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`);

--
-- 表的索引 `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_message_id` (`message_id`),
  ADD KEY `idx_state` (`state`),
  ADD KEY `idx_create_time` (`update_time`);

--
-- 表的索引 `user_award_record_000`
--
ALTER TABLE `user_award_record_000`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_id` (`activity_id`),
  ADD KEY `idx_award_id` (`strategy_id`);

--
-- 表的索引 `user_award_record_001`
--
ALTER TABLE `user_award_record_001`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_id` (`activity_id`),
  ADD KEY `idx_award_id` (`strategy_id`);

--
-- 表的索引 `user_award_record_002`
--
ALTER TABLE `user_award_record_002`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_id` (`activity_id`),
  ADD KEY `idx_award_id` (`strategy_id`);

--
-- 表的索引 `user_award_record_003`
--
ALTER TABLE `user_award_record_003`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_activity_id` (`activity_id`),
  ADD KEY `idx_award_id` (`strategy_id`);

--
-- 表的索引 `user_behavior_rebate_order_000`
--
ALTER TABLE `user_behavior_rebate_order_000`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_biz_id` (`biz_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 表的索引 `user_behavior_rebate_order_001`
--
ALTER TABLE `user_behavior_rebate_order_001`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_biz_id` (`biz_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 表的索引 `user_behavior_rebate_order_002`
--
ALTER TABLE `user_behavior_rebate_order_002`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_biz_id` (`biz_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 表的索引 `user_behavior_rebate_order_003`
--
ALTER TABLE `user_behavior_rebate_order_003`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_biz_id` (`biz_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 表的索引 `user_behavior_rebate_order_004`
--
ALTER TABLE `user_behavior_rebate_order_004`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD UNIQUE KEY `uq_biz_id` (`biz_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- 表的索引 `user_raffle_order_000`
--
ALTER TABLE `user_raffle_order_000`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`);

--
-- 表的索引 `user_raffle_order_001`
--
ALTER TABLE `user_raffle_order_001`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`);

--
-- 表的索引 `user_raffle_order_002`
--
ALTER TABLE `user_raffle_order_002`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`);

--
-- 表的索引 `user_raffle_order_003`
--
ALTER TABLE `user_raffle_order_003`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_order_id` (`order_id`),
  ADD KEY `idx_user_id_activity_id` (`user_id`,`activity_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `raffle_activity_account`
--
ALTER TABLE `raffle_activity_account`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `raffle_activity_account_day`
--
ALTER TABLE `raffle_activity_account_day`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `raffle_activity_account_month`
--
ALTER TABLE `raffle_activity_account_month`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `raffle_activity_order_000`
--
ALTER TABLE `raffle_activity_order_000`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `raffle_activity_order_001`
--
ALTER TABLE `raffle_activity_order_001`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `raffle_activity_order_002`
--
ALTER TABLE `raffle_activity_order_002`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `raffle_activity_order_003`
--
ALTER TABLE `raffle_activity_order_003`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `task`
--
ALTER TABLE `task`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `user_award_record_000`
--
ALTER TABLE `user_award_record_000`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_award_record_001`
--
ALTER TABLE `user_award_record_001`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_award_record_002`
--
ALTER TABLE `user_award_record_002`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_award_record_003`
--
ALTER TABLE `user_award_record_003`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_behavior_rebate_order_000`
--
ALTER TABLE `user_behavior_rebate_order_000`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `user_behavior_rebate_order_001`
--
ALTER TABLE `user_behavior_rebate_order_001`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_behavior_rebate_order_002`
--
ALTER TABLE `user_behavior_rebate_order_002`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_behavior_rebate_order_003`
--
ALTER TABLE `user_behavior_rebate_order_003`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_behavior_rebate_order_004`
--
ALTER TABLE `user_behavior_rebate_order_004`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID';

--
-- 使用表AUTO_INCREMENT `user_raffle_order_000`
--
ALTER TABLE `user_raffle_order_000`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_raffle_order_001`
--
ALTER TABLE `user_raffle_order_001`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_raffle_order_002`
--
ALTER TABLE `user_raffle_order_002`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `user_raffle_order_003`
--
ALTER TABLE `user_raffle_order_003`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
