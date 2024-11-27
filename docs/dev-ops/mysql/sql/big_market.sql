-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2024-11-27 10:26:28
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
-- 数据库： `big_market`
--

-- --------------------------------------------------------

--
-- 表的结构 `award`
--

CREATE TABLE `award` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `award_id` int NOT NULL COMMENT '抽奖奖品ID - 内部流转使用',
  `award_key` varchar(32) NOT NULL COMMENT '奖品对接标识 - 每一个都是一个对应的发奖策略',
  `award_config` varchar(32) NOT NULL COMMENT '奖品配置信息',
  `award_desc` varchar(128) NOT NULL COMMENT '奖品内容描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='奖品表';

--
-- 转存表中的数据 `award`
--

INSERT INTO `award` (`id`, `award_id`, `award_key`, `award_config`, `award_desc`, `create_time`, `update_time`) VALUES
(1, 101, 'user_credit_random', '1,100', '用户积分【优先透彻规则范围，如果没有则走配置】', '2023-12-09 11:07:06', '2023-12-09 11:21:31'),
(2, 102, 'openai_use_count', '5', 'OpenAI 增加使用次数', '2023-12-09 11:07:06', '2023-12-09 11:12:59'),
(3, 103, 'openai_use_count', '10', 'OpenAI 增加使用次数', '2023-12-09 11:07:06', '2023-12-09 11:12:59'),
(4, 104, 'openai_use_count', '20', 'OpenAI 增加使用次数', '2023-12-09 11:07:06', '2023-12-09 11:12:58'),
(5, 105, 'openai_model', 'gpt-4', 'OpenAI 增加模型', '2023-12-09 11:07:06', '2023-12-09 11:12:01'),
(6, 106, 'openai_model', 'dall-e-2', 'OpenAI 增加模型', '2023-12-09 11:07:06', '2023-12-09 11:12:08'),
(7, 107, 'openai_model', 'dall-e-3', 'OpenAI 增加模型', '2023-12-09 11:07:06', '2023-12-09 11:12:10'),
(8, 108, 'openai_use_count', '100', 'OpenAI 增加使用次数', '2023-12-09 11:07:06', '2023-12-09 11:12:55'),
(9, 109, 'openai_model', 'gpt-4,dall-e-2,dall-e-3', 'OpenAI 增加模型', '2023-12-09 11:07:06', '2023-12-09 11:12:39'),
(10, 100, 'user_credit_blacklist', '1', '黑名单积分', '2024-01-06 12:30:40', '2024-01-06 12:30:46');

-- --------------------------------------------------------

--
-- 表的结构 `daily_behavior_rebate`
--

CREATE TABLE `daily_behavior_rebate` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `behavior_type` varchar(16) NOT NULL COMMENT '行为类型（sign 签到、openai_pay 支付）',
  `rebate_desc` varchar(128) NOT NULL COMMENT '返利描述',
  `rebate_type` varchar(16) NOT NULL COMMENT '返利类型（sku 活动库存充值商品、integral 用户活动积分）',
  `rebate_config` varchar(32) NOT NULL COMMENT '返利配置',
  `state` varchar(12) NOT NULL COMMENT '状态（open 开启、close 关闭）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日常行为返利活动配置';

--
-- 转存表中的数据 `daily_behavior_rebate`
--

INSERT INTO `daily_behavior_rebate` (`id`, `behavior_type`, `rebate_desc`, `rebate_type`, `rebate_config`, `state`, `create_time`, `update_time`) VALUES
(1, 'sign', '签到返利-sku额度', 'sku', '9011', 'open', '2024-04-30 09:32:46', '2024-04-30 18:05:23'),
(2, 'sign', '签到返利-积分', 'integral', '10', 'open', '2024-04-30 09:32:46', '2024-04-30 18:05:27');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity`
--

CREATE TABLE `raffle_activity` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
  `activity_desc` varchar(128) NOT NULL COMMENT '活动描述',
  `begin_date_time` datetime NOT NULL COMMENT '开始时间',
  `end_date_time` datetime NOT NULL COMMENT '结束时间',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `state` varchar(8) NOT NULL DEFAULT 'create' COMMENT '活动状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动表';

--
-- 转存表中的数据 `raffle_activity`
--

INSERT INTO `raffle_activity` (`id`, `activity_id`, `activity_name`, `activity_desc`, `begin_date_time`, `end_date_time`, `strategy_id`, `state`, `create_time`, `update_time`) VALUES
(1, 100301, '测试活动', '测试活动', '2024-03-09 10:15:10', '2034-03-09 10:15:10', 100006, 'open', '2024-03-09 10:15:10', '2024-03-30 12:07:36');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_count`
--

CREATE TABLE `raffle_activity_count` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `activity_count_id` bigint NOT NULL COMMENT '活动次数编号',
  `total_count` int NOT NULL COMMENT '总次数',
  `day_count` int NOT NULL COMMENT '日次数',
  `month_count` int NOT NULL COMMENT '月次数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖活动次数配置表';

--
-- 转存表中的数据 `raffle_activity_count`
--

INSERT INTO `raffle_activity_count` (`id`, `activity_count_id`, `total_count`, `day_count`, `month_count`, `create_time`, `update_time`) VALUES
(1, 11101, 10, 10, 10, '2024-03-09 10:15:42', '2024-05-01 14:34:16');

-- --------------------------------------------------------

--
-- 表的结构 `raffle_activity_sku`
--

CREATE TABLE `raffle_activity_sku` (
  `id` int UNSIGNED NOT NULL COMMENT '自增ID',
  `sku` bigint NOT NULL COMMENT '商品sku - 把每一个组合当做一个商品',
  `activity_id` bigint NOT NULL COMMENT '活动ID',
  `activity_count_id` bigint NOT NULL COMMENT '活动个人参与次数ID',
  `stock_count` int NOT NULL COMMENT '商品库存',
  `stock_count_surplus` int NOT NULL COMMENT '剩余库存',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `raffle_activity_sku`
--

INSERT INTO `raffle_activity_sku` (`id`, `sku`, `activity_id`, `activity_count_id`, `stock_count`, `stock_count_surplus`, `create_time`, `update_time`) VALUES
(1, 9011, 100301, 11101, 100000, 99927, '2024-03-16 11:41:09', '2024-05-03 13:28:50');

-- --------------------------------------------------------

--
-- 表的结构 `rule_tree`
--

CREATE TABLE `rule_tree` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
  `tree_name` varchar(64) NOT NULL COMMENT '规则树名称',
  `tree_desc` varchar(128) DEFAULT NULL COMMENT '规则树描述',
  `tree_node_rule_key` varchar(32) NOT NULL COMMENT '规则树根入口规则',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='规则表-树';

--
-- 转存表中的数据 `rule_tree`
--

INSERT INTO `rule_tree` (`id`, `tree_id`, `tree_name`, `tree_desc`, `tree_node_rule_key`, `create_time`, `update_time`) VALUES
(1, 'tree_lock_1', '规则树', '规则树', 'rule_lock', '2024-01-27 10:01:59', '2024-02-15 07:49:59'),
(2, 'tree_luck_award', '规则树-兜底奖励', '规则树-兜底奖励', 'rule_stock', '2024-02-15 07:35:06', '2024-02-15 07:50:20'),
(3, 'tree_lock_2', '规则树', '规则树', 'rule_lock', '2024-01-27 10:01:59', '2024-02-15 07:49:59'),
(4, 'tree_lock_3', '规则树', '规则树', 'rule_lock', '2024-01-27 10:01:59', '2024-02-15 07:49:59');

-- --------------------------------------------------------

--
-- 表的结构 `rule_tree_node`
--

CREATE TABLE `rule_tree_node` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
  `rule_key` varchar(32) NOT NULL COMMENT '规则Key',
  `rule_desc` varchar(64) NOT NULL COMMENT '规则描述',
  `rule_value` varchar(128) DEFAULT NULL COMMENT '规则比值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='规则表-树节点';

--
-- 转存表中的数据 `rule_tree_node`
--

INSERT INTO `rule_tree_node` (`id`, `tree_id`, `rule_key`, `rule_desc`, `rule_value`, `create_time`, `update_time`) VALUES
(1, 'tree_lock_1', 'rule_lock', '限定用户已完成N次抽奖后解锁', '1', '2024-01-27 10:03:09', '2024-02-15 07:50:57'),
(2, 'tree_lock_1', 'rule_luck_award', '兜底奖品随机积分', '101:1,100', '2024-01-27 10:03:09', '2024-02-15 07:51:00'),
(3, 'tree_lock_1', 'rule_stock', '库存扣减规则', NULL, '2024-01-27 10:04:43', '2024-02-15 07:51:02'),
(4, 'tree_luck_award', 'rule_stock', '库存扣减规则', NULL, '2024-02-15 07:35:55', '2024-02-15 07:39:19'),
(5, 'tree_luck_award', 'rule_luck_award', '兜底奖品随机积分', '101:1,100', '2024-02-15 07:35:55', '2024-02-15 07:39:23'),
(6, 'tree_lock_2', 'rule_lock', '限定用户已完成N次抽奖后解锁', '2', '2024-01-27 10:03:09', '2024-02-15 07:52:20'),
(7, 'tree_lock_2', 'rule_luck_award', '兜底奖品随机积分', '101:1,100', '2024-01-27 10:03:09', '2024-02-08 19:59:43'),
(8, 'tree_lock_2', 'rule_stock', '库存扣减规则', NULL, '2024-01-27 10:04:43', '2024-02-03 10:40:21'),
(9, 'tree_lock_3', 'rule_lock', '限定用户已完成N次抽奖后解锁', '3', '2024-01-27 10:03:09', '2024-04-27 13:06:45'),
(10, 'tree_lock_3', 'rule_luck_award', '兜底奖品随机积分', '101:1,100', '2024-01-27 10:03:09', '2024-04-27 13:06:53'),
(11, 'tree_lock_3', 'rule_stock', '库存扣减规则', NULL, '2024-01-27 10:04:43', '2024-02-03 10:40:21');

-- --------------------------------------------------------

--
-- 表的结构 `rule_tree_node_line`
--

CREATE TABLE `rule_tree_node_line` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
  `rule_node_from` varchar(32) NOT NULL COMMENT '规则Key节点 From',
  `rule_node_to` varchar(32) NOT NULL COMMENT '规则Key节点 To',
  `rule_limit_type` varchar(8) NOT NULL COMMENT '限定类型；1:=;2:>;3:<;4:>=;5<=;6:enum[枚举范围];',
  `rule_limit_value` varchar(32) NOT NULL COMMENT '限定值（到下个节点）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='规则表-树节点连线';

--
-- 转存表中的数据 `rule_tree_node_line`
--

INSERT INTO `rule_tree_node_line` (`id`, `tree_id`, `rule_node_from`, `rule_node_to`, `rule_limit_type`, `rule_limit_value`, `create_time`, `update_time`) VALUES
(1, 'tree_lock_1', 'rule_lock', 'rule_stock', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-02-15 07:55:08'),
(2, 'tree_lock_1', 'rule_lock', 'rule_luck_award', 'EQUAL', 'TAKE_OVER', '0000-00-00 00:00:00', '2024-02-15 07:55:11'),
(3, 'tree_lock_1', 'rule_stock', 'rule_luck_award', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-02-15 07:55:13'),
(4, 'tree_luck_award', 'rule_stock', 'rule_luck_award', 'EQUAL', 'ALLOW', '2024-02-15 07:37:31', '2024-02-15 07:39:28'),
(5, 'tree_lock_2', 'rule_lock', 'rule_stock', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-02-15 07:55:08'),
(6, 'tree_lock_2', 'rule_lock', 'rule_luck_award', 'EQUAL', 'TAKE_OVER', '0000-00-00 00:00:00', '2024-02-15 07:55:11'),
(7, 'tree_lock_2', 'rule_stock', 'rule_luck_award', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-02-15 07:55:13'),
(8, 'tree_lock_3', 'rule_lock', 'rule_luck_award', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-04-27 13:07:39'),
(9, 'tree_lock_3', 'rule_lock', 'rule_luck_award', 'EQUAL', 'TAKE_OVER', '0000-00-00 00:00:00', '2024-02-15 07:55:11'),
(10, 'tree_lock_3', 'rule_stock', 'rule_luck_award', 'EQUAL', 'ALLOW', '0000-00-00 00:00:00', '2024-02-15 07:55:13');

-- --------------------------------------------------------

--
-- 表的结构 `strategy`
--

CREATE TABLE `strategy` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `strategy_desc` varchar(128) NOT NULL COMMENT '抽奖策略描述',
  `rule_models` varchar(256) DEFAULT NULL COMMENT '规则模型，rule配置的模型同步到此表，便于使用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖策略';

--
-- 转存表中的数据 `strategy`
--

INSERT INTO `strategy` (`id`, `strategy_id`, `strategy_desc`, `rule_models`, `create_time`, `update_time`) VALUES
(1, 100001, '抽奖策略', 'rule_blacklist,rule_weight', '2023-12-09 09:37:19', '2024-01-20 11:39:23'),
(2, 100003, '抽奖策略-验证lock', NULL, '2024-01-13 10:34:06', '2024-04-03 16:03:21'),
(3, 100002, '抽奖策略-非完整1概率', NULL, '2023-12-09 09:37:19', '2024-02-03 10:14:17'),
(4, 100004, '抽奖策略-随机抽奖', NULL, '2023-12-09 09:37:19', '2024-01-20 19:21:03'),
(5, 100005, '抽奖策略-测试概率计算', NULL, '2023-12-09 09:37:19', '2024-01-21 21:54:58'),
(6, 100006, '抽奖策略-规则树', 'rule_blacklist,rule_weight', '2024-02-03 09:53:40', '2024-05-03 09:02:38');

-- --------------------------------------------------------

--
-- 表的结构 `strategy_award`
--

CREATE TABLE `strategy_award` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `strategy_id` bigint NOT NULL COMMENT '抽奖策略ID',
  `award_id` int NOT NULL COMMENT '抽奖奖品ID - 内部流转使用',
  `award_title` varchar(128) NOT NULL COMMENT '抽奖奖品标题',
  `award_subtitle` varchar(128) DEFAULT NULL COMMENT '抽奖奖品副标题',
  `award_count` int NOT NULL DEFAULT '0' COMMENT '奖品库存总量',
  `award_count_surplus` int NOT NULL DEFAULT '0' COMMENT '奖品库存剩余',
  `award_rate` decimal(6,4) NOT NULL COMMENT '奖品中奖概率',
  `rule_models` varchar(256) DEFAULT NULL COMMENT '规则模型，rule配置的模型同步到此表，便于使用',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖策略奖品概率';

--
-- 转存表中的数据 `strategy_award`
--

INSERT INTO `strategy_award` (`id`, `strategy_id`, `award_id`, `award_title`, `award_subtitle`, `award_count`, `award_count_surplus`, `award_rate`, `rule_models`, `sort`, `create_time`, `update_time`) VALUES
(1, 100001, 101, '随机积分', NULL, 80000, 79998, 0.3000, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-25 22:40:50'),
(2, 100001, 102, '5次使用', NULL, 10000, 9999, 0.2000, 'tree_luck_award', 2, '2023-12-09 09:39:18', '2024-02-25 22:40:55'),
(3, 100001, 103, '10次使用', NULL, 5000, 4998, 0.2000, 'tree_luck_award', 3, '2023-12-09 09:42:36', '2024-02-25 22:40:45'),
(4, 100001, 104, '20次使用', NULL, 4000, 3999, 0.1000, 'tree_luck_award', 4, '2023-12-09 09:43:15', '2024-02-25 22:40:00'),
(5, 100001, 105, '增加gpt-4对话模型', NULL, 600, 600, 0.1000, 'tree_luck_award', 5, '2023-12-09 09:43:47', '2024-02-15 07:42:13'),
(6, 100001, 106, '增加dall-e-2画图模型', NULL, 200, 200, 0.0500, 'tree_luck_award', 6, '2023-12-09 09:44:20', '2024-02-15 07:42:14'),
(7, 100001, 107, '增加dall-e-3画图模型', '抽奖1次后解锁', 200, 200, 0.0400, 'tree_luck_award', 7, '2023-12-09 09:45:38', '2024-02-15 07:42:17'),
(8, 100001, 108, '增加100次使用', '抽奖2次后解锁', 199, 199, 0.0099, 'tree_luck_award', 8, '2023-12-09 09:46:02', '2024-02-15 07:42:21'),
(9, 100001, 109, '解锁全部模型', '抽奖6次后解锁', 1, 1, 0.0001, 'tree_luck_award', 9, '2023-12-09 09:46:39', '2024-02-15 07:42:26'),
(10, 100002, 101, '随机积分', NULL, 1, 1, 0.5000, 'tree_luck_award', 1, '2023-12-09 09:46:39', '2024-02-15 07:42:29'),
(11, 100002, 102, '5次使用', NULL, 1, 1, 0.1000, 'tree_luck_award', 2, '2023-12-09 09:46:39', '2024-02-15 07:42:32'),
(12, 100002, 106, '增加dall-e-2画图模型', NULL, 1, 1, 0.0100, 'tree_luck_award', 3, '2023-12-09 09:46:39', '2024-02-15 07:42:35'),
(13, 100003, 107, '增加dall-e-3画图模型', '抽奖1次后解锁', 200, 200, 0.0400, 'tree_luck_award', 7, '2023-12-09 09:45:38', '2024-02-15 07:42:38'),
(14, 100003, 108, '增加100次使用', '抽奖2次后解锁', 199, 199, 0.0099, 'tree_luck_award', 8, '2023-12-09 09:46:02', '2024-02-15 07:42:41'),
(15, 100003, 109, '解锁全部模型', '抽奖6次后解锁', 1, 1, 0.0001, 'tree_luck_award', 9, '2023-12-09 09:46:39', '2024-02-15 07:42:44'),
(16, 100004, 109, '解锁全部模型', '抽奖6次后解锁', 1, 1, 1.0000, 'tree_luck_award', 9, '2023-12-09 09:46:39', '2024-02-15 07:42:46'),
(17, 100005, 101, '随机积分', NULL, 80000, 80000, 0.0300, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-15 07:42:47'),
(18, 100005, 102, '随机积分', NULL, 80000, 80000, 0.0300, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-15 07:42:48'),
(19, 100005, 103, '随机积分', NULL, 80000, 80000, 0.0300, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-15 07:42:50'),
(20, 100005, 104, '随机积分', NULL, 80000, 80000, 0.0300, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-15 07:42:51'),
(21, 100005, 105, '随机积分', NULL, 80000, 80000, 0.0010, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-02-15 07:42:52'),
(22, 100006, 101, '随机积分', NULL, 100, 60, 0.0200, 'tree_luck_award', 1, '2023-12-09 09:38:31', '2024-11-27 16:55:05'),
(23, 100006, 102, 'OpenAI会员卡', NULL, 100, 19, 0.0300, 'tree_luck_award', 2, '2023-12-09 09:38:31', '2024-04-27 15:00:20'),
(24, 100006, 103, '支付优惠券', NULL, 100, 42, 0.0300, 'tree_luck_award', 3, '2023-12-09 09:38:31', '2024-11-27 16:55:20'),
(25, 100006, 104, '小米台灯', NULL, 100, 35, 0.0300, 'tree_luck_award', 4, '2023-12-09 09:38:31', '2024-11-27 16:54:55'),
(26, 100006, 105, '小米su7周体验', '抽奖3次后解锁', 100, 38, 0.0300, 'tree_lock_3', 5, '2023-12-09 09:38:31', '2024-04-27 13:08:16'),
(27, 100006, 106, '轻奢办公椅', '抽奖2次后解锁', 100, 24, 0.0300, 'tree_lock_2', 6, '2023-12-09 09:38:31', '2024-11-27 16:55:10'),
(28, 100006, 107, '小霸王游戏机', '抽奖1次后解锁', 100, 23, 0.0300, 'tree_lock_1', 7, '2023-12-09 09:38:31', '2024-11-27 16:55:15'),
(29, 100006, 108, '暴走玩偶', NULL, 100, 32, 0.0300, 'tree_luck_award', 8, '2023-12-09 09:38:31', '2024-05-01 14:59:35');

-- --------------------------------------------------------

--
-- 表的结构 `strategy_rule`
--

CREATE TABLE `strategy_rule` (
  `id` bigint UNSIGNED NOT NULL COMMENT '自增ID',
  `strategy_id` int NOT NULL COMMENT '抽奖策略ID',
  `award_id` int DEFAULT NULL COMMENT '抽奖奖品ID【规则类型为策略，则不需要奖品ID】',
  `rule_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '抽象规则类型；1-策略规则、2-奖品规则',
  `rule_model` varchar(16) NOT NULL COMMENT '抽奖规则类型【rule_random - 随机值计算、rule_lock - 抽奖几次后解锁、rule_luck_award - 幸运奖(兜底奖品)】',
  `rule_value` varchar(256) NOT NULL COMMENT '抽奖规则比值',
  `rule_desc` varchar(128) NOT NULL COMMENT '抽奖规则描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='抽奖策略规则';

--
-- 转存表中的数据 `strategy_rule`
--

INSERT INTO `strategy_rule` (`id`, `strategy_id`, `award_id`, `rule_type`, `rule_model`, `rule_value`, `rule_desc`, `create_time`, `update_time`) VALUES
(13, 100001, NULL, 1, 'rule_weight', '60:102,103 4000:104,105 5000:106,107 6000:107,108', '消耗6000分，必中奖范围', '2023-12-09 10:30:43', '2024-11-26 23:22:36'),
(14, 100001, NULL, 1, 'rule_blacklist', '101:user001,user002,user003', '黑名单抽奖，积分兜底', '2023-12-09 12:59:45', '2024-02-14 18:16:20'),
(15, 100006, NULL, 1, 'rule_weight', '60:102,103 4000:104,105 5000:106,107 6000:107,108', '消耗6000分，必中奖范围', '2023-12-09 10:30:43', '2024-11-26 23:22:03'),
(16, 100006, NULL, 1, 'rule_blacklist', '101:user001,user002,user003', '黑名单抽奖，积分兜底', '2023-12-09 12:59:45', '2024-02-14 18:16:20');

--
-- 转储表的索引
--

--
-- 表的索引 `award`
--
ALTER TABLE `award`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `daily_behavior_rebate`
--
ALTER TABLE `daily_behavior_rebate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_behavior_type` (`behavior_type`);

--
-- 表的索引 `raffle_activity`
--
ALTER TABLE `raffle_activity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_activity_id` (`activity_id`),
  ADD UNIQUE KEY `uq_strategy_id` (`strategy_id`),
  ADD KEY `idx_begin_date_time` (`begin_date_time`),
  ADD KEY `idx_end_date_time` (`end_date_time`);

--
-- 表的索引 `raffle_activity_count`
--
ALTER TABLE `raffle_activity_count`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_activity_count_id` (`activity_count_id`);

--
-- 表的索引 `raffle_activity_sku`
--
ALTER TABLE `raffle_activity_sku`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sku` (`sku`),
  ADD KEY `idx_activity_id_activity_count_id` (`activity_id`,`activity_count_id`);

--
-- 表的索引 `rule_tree`
--
ALTER TABLE `rule_tree`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tree_id` (`tree_id`);

--
-- 表的索引 `rule_tree_node`
--
ALTER TABLE `rule_tree_node`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `rule_tree_node_line`
--
ALTER TABLE `rule_tree_node_line`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `strategy`
--
ALTER TABLE `strategy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_strategy_id` (`strategy_id`);

--
-- 表的索引 `strategy_award`
--
ALTER TABLE `strategy_award`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_strategy_id_award_id` (`strategy_id`,`award_id`);

--
-- 表的索引 `strategy_rule`
--
ALTER TABLE `strategy_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_strategy_id_rule_model` (`strategy_id`,`rule_model`),
  ADD KEY `idx_strategy_id_award_id` (`strategy_id`,`award_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `award`
--
ALTER TABLE `award`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `daily_behavior_rebate`
--
ALTER TABLE `daily_behavior_rebate`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `raffle_activity`
--
ALTER TABLE `raffle_activity`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `raffle_activity_count`
--
ALTER TABLE `raffle_activity_count`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `raffle_activity_sku`
--
ALTER TABLE `raffle_activity_sku`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `rule_tree`
--
ALTER TABLE `rule_tree`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `rule_tree_node`
--
ALTER TABLE `rule_tree_node`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `rule_tree_node_line`
--
ALTER TABLE `rule_tree_node_line`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `strategy`
--
ALTER TABLE `strategy`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `strategy_award`
--
ALTER TABLE `strategy_award`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `strategy_rule`
--
ALTER TABLE `strategy_rule`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID', AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
