/*
Navicat MySQL Data Transfer

Source Server         : kedao
Source Server Version : 50718
Source Host           : cd-cdb-lx77e2kk.sql.tencentcdb.com:63130
Source Database       : kedao_test

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2019-06-13 20:45:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for c_account_share_show
-- ----------------------------
DROP TABLE IF EXISTS `c_account_share_show`;
CREATE TABLE `c_account_share_show` (
  `c_accountShareShowId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '分享时显示对应的名称主键',
  `s_wxId` bigint(32) DEFAULT NULL,
  `c_taId` bigint(32) DEFAULT NULL,
  PRIMARY KEY (`c_accountShareShowId`),
  KEY `share_wxId` (`s_wxId`),
  KEY `share_taId` (`c_taId`),
  CONSTRAINT `share_taId` FOREIGN KEY (`c_taId`) REFERENCES `c_table_account_info` (`c_taid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `share_wxId` FOREIGN KEY (`s_wxId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_bargain_record_info
-- ----------------------------
DROP TABLE IF EXISTS `c_bargain_record_info`;
CREATE TABLE `c_bargain_record_info` (
  `c_bargainRecordId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'bargainrecordinfoId,自增主键',
  `c_bargainId` bigint(32) DEFAULT NULL COMMENT 'bargainInfoId，外键',
  `c_wxId` bigint(11) DEFAULT NULL COMMENT '微信用户',
  `c_bargainTime` datetime(6) DEFAULT NULL COMMENT '砍价时间',
  `c_bargainMoney` decimal(10,2) DEFAULT NULL COMMENT '砍价钱数',
  `c_bargainDistance` double DEFAULT NULL COMMENT '潜在消费者与消费者之间的距离',
  `c_longitude` varchar(128) DEFAULT NULL COMMENT '帮砍用户的经度',
  `c_latitude` varchar(128) DEFAULT NULL COMMENT '帮砍用户的纬度',
  PRIMARY KEY (`c_bargainRecordId`),
  KEY `barginId` (`c_bargainId`),
  CONSTRAINT `barginId` FOREIGN KEY (`c_bargainId`) REFERENCES `c_bargin_info` (`c_barginId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_bargin_info
-- ----------------------------
DROP TABLE IF EXISTS `c_bargin_info`;
CREATE TABLE `c_bargin_info` (
  `c_barginId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '消费者砍价ID',
  `c_taId` bigint(32) NOT NULL COMMENT '账单主键',
  `c_wxId` bigint(32) NOT NULL COMMENT '消费者微信ID',
  `c_barginTimes` bigint(20) DEFAULT NULL COMMENT '消费者现砍价的次数',
  `c_barginMoney` decimal(10,2) DEFAULT NULL COMMENT '消费者现砍价总金额',
  `c_maxBarginTimes` bigint(20) DEFAULT NULL COMMENT '最大砍价次数',
  `c_maxBarginMoney` decimal(10,2) DEFAULT NULL COMMENT '最大砍价金额',
  `c_barginStartTime` datetime DEFAULT NULL COMMENT '砍价开始时间',
  `c_barginEndTime` datetime DEFAULT NULL COMMENT '砍价结束时间',
  `c_barginRefundTime` datetime DEFAULT NULL COMMENT '返现时间',
  `c_refundStatus` tinyint(1) DEFAULT '0' COMMENT '消费者返款状态 1 返款 0未返款',
  `c_refundOrder` varchar(255) DEFAULT NULL COMMENT '返款的订单号',
  `c_free` int(1) DEFAULT '0' COMMENT '0是不免单，1是免单',
  `c_effect` tinyint(1) DEFAULT '0' COMMENT '返款是否生效，0是不生效，1是生效',
  PRIMARY KEY (`c_barginId`),
  KEY `taId` (`c_taId`),
  KEY `bargin_wxId` (`c_wxId`),
  CONSTRAINT `bargin_wxId` FOREIGN KEY (`c_wxId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `taId` FOREIGN KEY (`c_taId`) REFERENCES `c_table_account_info` (`c_taid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_coupon_info
-- ----------------------------
DROP TABLE IF EXISTS `c_coupon_info`;
CREATE TABLE `c_coupon_info` (
  `c_couponId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '优惠券编号 自增主键',
  `c_bargainRecordId` bigint(32) DEFAULT NULL COMMENT '外键砍一刀记录ID',
  `s_wxId` bigint(32) DEFAULT NULL COMMENT '帮砍 用户的微信ID',
  `taId` bigint(32) DEFAULT NULL COMMENT '桌子账单的ID(帮哪个订单砍价)',
  `c_couponAmount` decimal(10,2) DEFAULT NULL COMMENT '优惠券的金额',
  `c_couponCreateTime` datetime DEFAULT NULL COMMENT '优惠券的创建时间',
  `c_couponValidTime` datetime DEFAULT NULL COMMENT '优惠券的有效使用时间',
  `c_coupon_flag` tinyint(1) DEFAULT NULL COMMENT '优惠券的标志位',
  PRIMARY KEY (`c_couponId`),
  KEY `c_bargainRecordId` (`c_bargainRecordId`),
  KEY `s_wxId` (`s_wxId`),
  KEY `taId` (`taId`),
  CONSTRAINT `c_coupon_info_ibfk_1` FOREIGN KEY (`c_bargainRecordId`) REFERENCES `c_bargain_record_info` (`c_bargainRecordId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `c_coupon_info_ibfk_2` FOREIGN KEY (`s_wxId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `c_coupon_info_ibfk_3` FOREIGN KEY (`taId`) REFERENCES `c_table_account_info` (`c_taid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='砍一刀生成的优惠券表';

-- ----------------------------
-- Table structure for c_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `c_customer_info`;
CREATE TABLE `c_customer_info` (
  `c_customerInfoID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '消费者ID',
  `c_customerInfoWebChatAccount` varchar(64) DEFAULT NULL COMMENT '消费者微信账号',
  `c_customerInfoTelphone` varchar(32) DEFAULT NULL COMMENT '消费者电话',
  `c_customerInfoNote` varchar(128) DEFAULT NULL COMMENT '消费者信息备注',
  PRIMARY KEY (`c_customerInfoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_discount_info
-- ----------------------------
DROP TABLE IF EXISTS `c_discount_info`;
CREATE TABLE `c_discount_info` (
  `c_giftInfoID` bigint(32) NOT NULL AUTO_INCREMENT,
  `c_giftInfoName` varchar(64) DEFAULT NULL,
  `c_giftInfoDesc` varchar(512) DEFAULT NULL,
  `c_giftInfoMoney` decimal(10,2) DEFAULT NULL,
  `c_giftInfoNote` varchar(128) DEFAULT NULL,
  `c_endTime` datetime DEFAULT NULL,
  `c_beforeDay` int(11) DEFAULT NULL,
  PRIMARY KEY (`c_giftInfoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_discount_status
-- ----------------------------
DROP TABLE IF EXISTS `c_discount_status`;
CREATE TABLE `c_discount_status` (
  `c_giftStatusID` bigint(32) NOT NULL AUTO_INCREMENT,
  `c_giftStatusName` varchar(64) DEFAULT NULL,
  `c_giftStatusDesc` varchar(512) DEFAULT NULL,
  `c_giftStatusNote` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`c_giftStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_refund_record
-- ----------------------------
DROP TABLE IF EXISTS `c_refund_record`;
CREATE TABLE `c_refund_record` (
  `c_refundRecordId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `c_taId` bigint(32) DEFAULT NULL COMMENT '账单id',
  `c_refundOrder` varchar(255) DEFAULT NULL COMMENT '返款单号',
  `c_refundTime` datetime DEFAULT NULL COMMENT '返款时间',
  `c_refundStatus` tinyint(1) DEFAULT NULL COMMENT '0表示返款失败，1成功',
  `c_refundCode` varchar(255) DEFAULT NULL COMMENT '返款状态描述',
  PRIMARY KEY (`c_refundRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_refunds_status
-- ----------------------------
DROP TABLE IF EXISTS `c_refunds_status`;
CREATE TABLE `c_refunds_status` (
  `c_refundsStatusID` bigint(32) NOT NULL AUTO_INCREMENT,
  `c_refundsStatusName` varchar(64) DEFAULT NULL,
  `c_refundsStatusDesc` varchar(512) DEFAULT NULL,
  `c_refundsStatusNote` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`c_refundsStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for c_table_account_info
-- ----------------------------
DROP TABLE IF EXISTS `c_table_account_info`;
CREATE TABLE `c_table_account_info` (
  `c_taId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家Id',
  `r_tableInfoId` bigint(20) DEFAULT NULL COMMENT '桌子编号',
  `c_wxId` bigint(20) DEFAULT NULL COMMENT '消费者标号',
  `r_waitorID` bigint(32) DEFAULT NULL COMMENT '服务员编号',
  `c_menuOrderTime` datetime DEFAULT NULL COMMENT '点餐时间',
  `c_menuPaymentTime` datetime DEFAULT NULL COMMENT '结账时间',
  `c_paymentType` int(1) DEFAULT NULL COMMENT '付款类型(1 微信支付，2 其他支付)',
  `c_totalPayment` decimal(10,2) DEFAULT NULL COMMENT '总共付款金额',
  `c_actualPayment` decimal(10,2) DEFAULT NULL COMMENT '实际付款金额',
  `c_discountids` varchar(255) DEFAULT NULL COMMENT '使用的优惠券们（优惠券的ids）',
  `c_discountMoney` decimal(10,2) DEFAULT NULL COMMENT '抵扣金额',
  `c_menuInfo` varchar(6000) DEFAULT NULL COMMENT '客户消费记录',
  `s_bonusFee` decimal(10,2) DEFAULT NULL COMMENT '平台提成费用',
  `c_checkoutFlag` int(10) DEFAULT '0' COMMENT '是否结账的标志位(1 结账 0 没有结账,2退款)',
  `r_billNo` varchar(50) DEFAULT NULL COMMENT '餐饮店的账单编号',
  `r_acBilNo` varchar(50) DEFAULT NULL COMMENT '在微信端实际的商家账单号',
  `r_wxBillNo` varchar(50) DEFAULT NULL COMMENT '微信支付的账单编号',
  `s_couponFee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`c_taId`),
  KEY `tableId` (`r_tableInfoId`),
  KEY `weixinId` (`c_wxId`),
  KEY `S_WaitorID` (`r_waitorID`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `c_table_account_info_ibfk_1` FOREIGN KEY (`r_waitorID`) REFERENCES `r_waitor` (`r_waitorid`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `c_table_account_info_ibfk_2` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tableId` FOREIGN KEY (`r_tableInfoId`) REFERENCES `r_table_info` (`r_tableinfoid`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `weixinId` FOREIGN KEY (`c_wxId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8 COMMENT='桌子点菜 桌子账单的相关信息';

-- ----------------------------
-- Table structure for c_table_food_info
-- ----------------------------
DROP TABLE IF EXISTS `c_table_food_info`;
CREATE TABLE `c_table_food_info` (
  `c_foodID` bigint(32) NOT NULL AUTO_INCREMENT,
  `c_menuID` int(11) DEFAULT NULL,
  `c_foodName` varchar(128) DEFAULT NULL,
  `c_foodPrice` decimal(10,2) DEFAULT NULL,
  `c_foodNum` bigint(20) DEFAULT NULL,
  `c_foodUnit` varchar(32) DEFAULT NULL,
  `c_foodNote` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`c_foodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_bargain_coupon
-- ----------------------------
DROP TABLE IF EXISTS `r_bargain_coupon`;
CREATE TABLE `r_bargain_coupon` (
  `r_bargainTacticsID` bigint(32) NOT NULL,
  `r_couponID` bigint(32) NOT NULL,
  KEY `r_bargainTacticsID` (`r_bargainTacticsID`),
  KEY `r_couponID` (`r_couponID`),
  CONSTRAINT `r_bargain_coupon_ibfk_1` FOREIGN KEY (`r_bargainTacticsID`) REFERENCES `r_bargain_tactics` (`r_bargaintacticsid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_bargain_coupon_ibfk_2` FOREIGN KEY (`r_couponID`) REFERENCES `r_coupon_tactics` (`r_couponid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_bargain_tactics
-- ----------------------------
DROP TABLE IF EXISTS `r_bargain_tactics`;
CREATE TABLE `r_bargain_tactics` (
  `r_bargainTacticsID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `r_marketingStrategyID` bigint(32) DEFAULT NULL COMMENT '外键（营销策略ID）',
  `r_bargainTacticsName` varchar(64) DEFAULT '超级助力赢红包' COMMENT '砍价名称',
  `r_bargainTacticsDesc` varchar(512) DEFAULT NULL COMMENT '砍价描述',
  `r_bargainTacticsNote` varchar(128) DEFAULT NULL COMMENT '砍价备注',
  `r_bargainTacticsDiscount` int(11) DEFAULT '20' COMMENT '砍价折扣',
  `r_bargainTacticsTotalNumber` int(11) DEFAULT '30' COMMENT '砍价人数',
  `r_bargainTacticsStartTime` date DEFAULT NULL COMMENT '砍价策略开始时间',
  `r_bargainTacticsEndTime` date DEFAULT NULL COMMENT '砍价策略结束时间',
  `r_maxAmount` double DEFAULT '5' COMMENT '每次砍价最大金额',
  `r_bargainTimeSpan` int(11) DEFAULT '240' COMMENT '活动时长(时间跨度)',
  `r_available` int(11) DEFAULT '1' COMMENT '优惠券当天是否可用。0，表示当天可用，N，表示N天后可用',
  `r_bargainTacticsDistanceBase` double DEFAULT '2' COMMENT '距离基数',
  `r_bargainTacticsFreeStatus` int(11) DEFAULT '0' COMMENT '是否可免单',
  `r_bargainTacticsFreeMaxNum` int(11) DEFAULT NULL COMMENT '当天免单最大数',
  `r_bargainTacticsFreeMinShareNum` int(11) DEFAULT NULL COMMENT '免单最低分享数',
  `r_bargainMaxDistance` double DEFAULT '99' COMMENT '砍价的最大距离',
  `r_bargainTacticsUintDistance` double unsigned DEFAULT '2.5' COMMENT '砍价金额计算的单位距离',
  `r_bargainDate` varchar(512) DEFAULT '星期一,星期二,星期三,星期四,星期五,星期六,星期日' COMMENT '活动可用的星期数，每星期的天数按逗号分隔\r\n',
  `r_couponNum` int(11) DEFAULT '1' COMMENT '每天可用券数量',
  `r_bothUse` tinyint(1) DEFAULT '0' COMMENT '砍价和优惠券能不能同时使用，1 能  0不能',
  PRIMARY KEY (`r_bargainTacticsID`),
  KEY `tartics_strategy` (`r_marketingStrategyID`),
  CONSTRAINT `tartics_strategy` FOREIGN KEY (`r_marketingStrategyID`) REFERENCES `r_marketing_strategy` (`r_marketingstrategyid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='砍价策略\r\n';

-- ----------------------------
-- Table structure for r_bargain_template
-- ----------------------------
DROP TABLE IF EXISTS `r_bargain_template`;
CREATE TABLE `r_bargain_template` (
  `r_bargainTemplateID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家Id',
  `r_bargainTemplateName` varchar(64) DEFAULT NULL COMMENT '模板名',
  `r_bargainTemplateTitle` varchar(255) DEFAULT NULL COMMENT '标题文案',
  `r_bargainTemplateDesc` varchar(512) DEFAULT NULL COMMENT '活动文案',
  `r_bargainTemplateImagePath` varchar(512) DEFAULT NULL COMMENT '活动图片',
  PRIMARY KEY (`r_bargainTemplateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_brand
-- ----------------------------
DROP TABLE IF EXISTS `r_brand`;
CREATE TABLE `r_brand` (
  `r_brandId` int(11) NOT NULL,
  `r_brandName` varchar(255) DEFAULT NULL,
  `r_groupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`r_brandId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_cooperation_agreement
-- ----------------------------
DROP TABLE IF EXISTS `r_cooperation_agreement`;
CREATE TABLE `r_cooperation_agreement` (
  `r_cooperationAgreementID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '商家合作协议编号',
  `r_cooperationAgreement` text COMMENT '商家合作协议',
  `r_cooperationAgreementNote` varchar(256) DEFAULT NULL COMMENT '商家合作协议备注',
  PRIMARY KEY (`r_cooperationAgreementID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_coupon_record
-- ----------------------------
DROP TABLE IF EXISTS `r_coupon_record`;
CREATE TABLE `r_coupon_record` (
  `r_couponID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '商家优惠券ID',
  `r_id` bigint(32) DEFAULT NULL COMMENT '店家编号',
  `c_wxId` bigint(32) DEFAULT NULL,
  `c_fromTaId` bigint(32) DEFAULT NULL COMMENT '从哪个账单发的',
  `c_bargainRecordId` bigint(32) DEFAULT NULL COMMENT '砍价记录ID',
  `r_couponBuildTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `r_couponUseTime` datetime DEFAULT NULL COMMENT '优惠券使用时间',
  `r_couponName` varchar(128) DEFAULT NULL COMMENT '优惠券的名字',
  `r_couponMoney` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `r_couponRange` varchar(128) DEFAULT NULL COMMENT '优惠券的使用范围',
  `r_couponValidityTime` datetime DEFAULT NULL COMMENT '优惠券的有效期 (截止时间)',
  `r_couponStartRemindTime` time DEFAULT NULL COMMENT '优惠券的开始提醒时间',
  `r_couponRemindTimes` varchar(128) DEFAULT NULL COMMENT '优惠券提醒次数',
  `r_couponRemindEndTime` time DEFAULT NULL COMMENT '优惠券结束提醒时间',
  `r_couponUseFlag` tinyint(1) DEFAULT '0' COMMENT '优惠券是否使用的标志位 1使用 0未使用',
  `r_couponUseMinMoney` decimal(10,2) DEFAULT NULL COMMENT '每次最多消费多少可以使用优惠券',
  `r_couponWaitTime` datetime DEFAULT NULL COMMENT '优惠券使用前等待时间',
  `r_couponMixUse` tinyint(1) DEFAULT '0' COMMENT '该优惠券是否可以混合使用',
  `r_couponCouldGiveToOthers` tinyint(1) DEFAULT '0' COMMENT '是否可以转赠给他人',
  `r_couponNote` varchar(128) DEFAULT NULL COMMENT '优惠券的备注信息',
  `c_taId` bigint(32) DEFAULT NULL COMMENT '使用优惠券的账单ID',
  `r_validityWeekDays` varchar(255) DEFAULT NULL COMMENT '一周内可用的天',
  PRIMARY KEY (`r_couponID`),
  KEY `R_ID` (`r_id`),
  KEY `c_bargainRecordId` (`c_bargainRecordId`),
  KEY `r_coupon_record_ibfk_5` (`c_wxId`),
  KEY `c_fromTaId` (`c_fromTaId`),
  CONSTRAINT `r_coupon_record_ibfk_3` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_coupon_record_ibfk_4` FOREIGN KEY (`c_bargainRecordId`) REFERENCES `c_bargain_record_info` (`c_bargainRecordId`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `r_coupon_record_ibfk_5` FOREIGN KEY (`c_wxId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_coupon_record_ibfk_6` FOREIGN KEY (`c_fromTaId`) REFERENCES `c_table_account_info` (`c_taId`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8 COMMENT='优惠券记录';

-- ----------------------------
-- Table structure for r_coupon_tactics
-- ----------------------------
DROP TABLE IF EXISTS `r_coupon_tactics`;
CREATE TABLE `r_coupon_tactics` (
  `r_couponID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '优惠券编号',
  `r_marketStrategyId` bigint(32) DEFAULT NULL COMMENT '商家营销策略ID',
  `r_couponValidateTime` datetime DEFAULT NULL COMMENT '优惠券的有效时间(截止时间)',
  `r_couponAdvanceRemindTime` varchar(255) DEFAULT NULL COMMENT '优惠券提前提醒时间(优惠券截止时间(几天前)',
  `r_couponStartRemindTime` time DEFAULT NULL COMMENT '优惠券的每天开始提醒时间',
  `r_couponEndRemindTime` time DEFAULT NULL COMMENT '优惠券的每天结束提醒时间',
  `r_couponRemindTimes` varchar(255) DEFAULT NULL COMMENT '优惠券的提醒次数',
  `t_couponName` varchar(128) DEFAULT NULL COMMENT '商家优惠券名称',
  `r_couponNote` varchar(128) DEFAULT NULL COMMENT '优惠券备注',
  `r_couponState` int(11) DEFAULT '0' COMMENT '0停用，1启用',
  `r_couponEffectivePeriod` varchar(255) DEFAULT NULL COMMENT '使用期间',
  `r_couponEffectiveDay` int(11) DEFAULT NULL COMMENT '有效期多少天',
  `r_reachAmount` double(11,0) DEFAULT NULL COMMENT '消费满足达到的金额才减（表示需要达到的金额）',
  `r_discountAmount` double(11,0) DEFAULT NULL COMMENT '满减的金额（表示达到条件后减的金额）',
  `r_available` int(11) DEFAULT '1' COMMENT '优惠券当天是否可用。0，表示当天可用，N，表示N天后可用',
  PRIMARY KEY (`r_couponID`),
  KEY `R_MarketStrategyId` (`r_marketStrategyId`),
  CONSTRAINT `r_coupon_tactics_ibfk_1` FOREIGN KEY (`r_marketStrategyId`) REFERENCES `r_marketing_strategy` (`r_marketingstrategyid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='商家优惠券';

-- ----------------------------
-- Table structure for r_coupon_use_menu
-- ----------------------------
DROP TABLE IF EXISTS `r_coupon_use_menu`;
CREATE TABLE `r_coupon_use_menu` (
  `r_couponUseMenuID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券使用菜品ID',
  `r_couponUseMenuNo` varchar(32) DEFAULT NULL COMMENT '优惠券使用菜单编号',
  `r_couponUseMenuName` varchar(128) DEFAULT NULL COMMENT '优惠券使用菜单名字',
  `r_couponUseMenuNote` varchar(128) DEFAULT NULL COMMENT '优惠券使用菜单备注',
  `r_couponID` bigint(32) DEFAULT NULL COMMENT '优惠券记录ID',
  PRIMARY KEY (`r_couponUseMenuID`),
  CONSTRAINT `r_coupon_use_menu_ibfk_1` FOREIGN KEY (`r_couponUseMenuID`) REFERENCES `r_coupon_record` (`r_couponID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_coupon_use_time
-- ----------------------------
DROP TABLE IF EXISTS `r_coupon_use_time`;
CREATE TABLE `r_coupon_use_time` (
  `r_couponUseTimeID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '优惠券使用时间ID',
  `r_couponID` bigint(11) DEFAULT NULL COMMENT '商家优惠券编号',
  `r_couponUseTimeNo` varchar(64) DEFAULT NULL COMMENT '优惠券使用时间编号',
  `r_couponUseTime` datetime DEFAULT NULL COMMENT '优惠券使用时间',
  `r_couponUseTimeStartTime` datetime DEFAULT NULL COMMENT '使用优惠券的开始时间',
  `r_couponUseTimeEndTime` datetime DEFAULT NULL COMMENT '使用优惠券的截止时间',
  PRIMARY KEY (`r_couponUseTimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_group
-- ----------------------------
DROP TABLE IF EXISTS `r_group`;
CREATE TABLE `r_group` (
  `r_groupId` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_groupName` varchar(50) DEFAULT NULL COMMENT '集团名称',
  `r_groupAddress` varchar(512) DEFAULT NULL COMMENT '集团地址',
  `r_groupTel` varchar(11) NOT NULL COMMENT '集团电话',
  `r_groupPrincipal` varchar(255) DEFAULT NULL COMMENT '集团负责人',
  `r_groupLicense` varchar(255) DEFAULT NULL COMMENT '营业执照',
  `r_groupBrand` varchar(255) NOT NULL COMMENT '集团品牌',
  `r_groupTag` int(1) NOT NULL DEFAULT '0' COMMENT '是否有效 0无效 1 有效',
  `r_logo` varchar(255) NOT NULL COMMENT '集团logo',
  `r_userID` bigint(32) NOT NULL,
  PRIMARY KEY (`r_groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_group_res
-- ----------------------------
DROP TABLE IF EXISTS `r_group_res`;
CREATE TABLE `r_group_res` (
  `r_groupResId` int(11) NOT NULL AUTO_INCREMENT,
  `r_groupId` bigint(32) DEFAULT NULL,
  `r_id` bigint(32) DEFAULT NULL,
  `r_status` int(1) DEFAULT '0' COMMENT '0 未审核；1审核通过',
  PRIMARY KEY (`r_groupResId`),
  KEY `gr_group` (`r_groupId`),
  KEY `gr_res` (`r_id`),
  CONSTRAINT `gr_group` FOREIGN KEY (`r_groupId`) REFERENCES `r_group` (`r_groupId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gr_res` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_marketing_strategy
-- ----------------------------
DROP TABLE IF EXISTS `r_marketing_strategy`;
CREATE TABLE `r_marketing_strategy` (
  `r_marketingStrategyID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '商家营销策略ID',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家砍价策略编号',
  `r_marketingStrategyType` int(11) NOT NULL COMMENT '商家营销策略类型 1 砍价  2 红包 3 优惠券',
  `r_marketingStrategyDesc` varchar(255) NOT NULL COMMENT '商家营销策略描述',
  `r_marketingStrategyNote` varchar(255) DEFAULT NULL COMMENT '商家营销策略备注',
  `r_marketStrategyFlag` tinyint(1) unsigned DEFAULT '1' COMMENT '商家营销策略的状态',
  PRIMARY KEY (`r_marketingStrategyID`),
  KEY `restaurant_stragtegy` (`r_id`),
  CONSTRAINT `restaurant_stragtegy` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='商家营销策略标注';

-- ----------------------------
-- Table structure for r_operate_type
-- ----------------------------
DROP TABLE IF EXISTS `r_operate_type`;
CREATE TABLE `r_operate_type` (
  `r_operateTypeID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '餐厅业态编号',
  `r_operateTypeName` varchar(32) DEFAULT NULL COMMENT '餐厅业态名称',
  `r_operateTypeNote` varchar(128) DEFAULT NULL COMMENT '业态备注',
  `r_parentID` bigint(32) DEFAULT NULL COMMENT '父ID',
  `r_operateStatus` int(10) DEFAULT '1' COMMENT '状态',
  `r_discount` int(11) DEFAULT NULL COMMENT '砍价折扣默认值',
  `r_totalNumber` int(11) DEFAULT NULL COMMENT '最大参与人数默认值',
  `r_timeSpan` int(11) DEFAULT NULL COMMENT '活动结束时长默认值',
  `r_available` int(11) DEFAULT NULL COMMENT '活动当天是否可用，0表示不可用，1可用，2、3、4表示几天后可用 ',
  `r_basicDistance` double DEFAULT NULL COMMENT '距离基数默认值',
  `r_unitDistance` double DEFAULT NULL COMMENT '砍价金额计算的单位距离的默认值',
  `r_maxDistance` double DEFAULT NULL COMMENT '砍价的最大距离默认值',
  `r_maxAmount` double DEFAULT NULL COMMENT '每次砍价的最大金额默认值',
  `r_freeStatus` tinyint(1) DEFAULT NULL COMMENT '是否可免单默认值',
  `r_freeLeastNumber` int(11) DEFAULT NULL COMMENT '免单最低砍价人数默认值',
  `r_freeNumPerDay` int(11) DEFAULT NULL COMMENT '每天免单数量默认值',
  PRIMARY KEY (`r_operateTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_operator_restaurant
-- ----------------------------
DROP TABLE IF EXISTS `r_operator_restaurant`;
CREATE TABLE `r_operator_restaurant` (
  `r_id` bigint(32) NOT NULL COMMENT '餐厅id',
  `r_userID` bigint(32) NOT NULL COMMENT '用户id',
  KEY `or_id` (`r_id`),
  KEY `or_userId` (`r_userID`),
  CONSTRAINT `or_id` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `or_userId` FOREIGN KEY (`r_userID`) REFERENCES `r_user_info` (`r_userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_pay_fee
-- ----------------------------
DROP TABLE IF EXISTS `r_pay_fee`;
CREATE TABLE `r_pay_fee` (
  `r_payFeeID` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_payFeeTypeID` int(11) DEFAULT NULL,
  `r_id` varchar(32) DEFAULT NULL,
  `r_payFeeNum` float NOT NULL,
  `r_payFeeUnit` varchar(32) DEFAULT NULL,
  `r_payFeeMan` varchar(64) NOT NULL,
  `r_payFeeNote` varchar(128) DEFAULT NULL,
  `r_payFeeEndTime` datetime DEFAULT NULL,
  `r_taxName` varchar(128) DEFAULT NULL,
  `r_taxAddress` varchar(128) DEFAULT NULL,
  `r_taxNo` varchar(128) DEFAULT NULL,
  `r_taxBankNo` varchar(128) DEFAULT NULL,
  `r_taxBankAdress` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`r_payFeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_pay_fee_type
-- ----------------------------
DROP TABLE IF EXISTS `r_pay_fee_type`;
CREATE TABLE `r_pay_fee_type` (
  `r_payFeeTypeID` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_payFeeName` varchar(32) NOT NULL,
  `r_payFeeNote` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`r_payFeeTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_publicity
-- ----------------------------
DROP TABLE IF EXISTS `r_publicity`;
CREATE TABLE `r_publicity` (
  `r_publicityId` bigint(32) NOT NULL,
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家id',
  `r_slogan1` varchar(255) DEFAULT NULL COMMENT '口号1',
  `r_slogan2` varchar(255) DEFAULT NULL COMMENT '口号2',
  `r_slogan3` varchar(255) DEFAULT NULL COMMENT '口号3',
  `r_picture1` varchar(255) DEFAULT NULL COMMENT '宣传图片1',
  `r_picture2` varchar(255) DEFAULT NULL COMMENT '宣传图片2',
  `r_picture3` varchar(255) DEFAULT NULL COMMENT '宣传图片3',
  PRIMARY KEY (`r_publicityId`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `r_publicity_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_qr_code
-- ----------------------------
DROP TABLE IF EXISTS `r_qr_code`;
CREATE TABLE `r_qr_code` (
  `r_qrCodeId` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_qrNun` varchar(20) NOT NULL,
  `r_qrCode` varchar(255) NOT NULL COMMENT '二维码',
  `r_qrFlag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被使用0-未使用1-已使用',
  `r_qrPath` varchar(255) DEFAULT NULL COMMENT '二维码路径',
  `r_name` varchar(255) DEFAULT NULL COMMENT '使用单位',
  `r_qrDownload` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`r_qrCodeId`),
  UNIQUE KEY `qrUnique` (`r_qrCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_red_packet_info
-- ----------------------------
DROP TABLE IF EXISTS `r_red_packet_info`;
CREATE TABLE `r_red_packet_info` (
  `r_redPacketInfoId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '红包实例ID',
  `r_redPacketID` bigint(32) DEFAULT NULL COMMENT '红包策略ID 外键',
  `c_taId` bigint(32) DEFAULT NULL COMMENT '桌子账单ID',
  `r_sharedRedPacketAmount` int(32) DEFAULT NULL COMMENT '已分享红包总数',
  `r_sharedRedPacketMoney` decimal(10,2) DEFAULT NULL COMMENT '已分享红包的总金额',
  `r_usedRedPacketAmount` int(32) DEFAULT NULL COMMENT '已使用红包的数目',
  `r_usedRedPacketsTotalMoney` decimal(10,2) DEFAULT NULL COMMENT '已使用红包总金额',
  `r_disusedRedPacketAmount` int(32) DEFAULT NULL COMMENT '未使用的红包数',
  `r_disusedRedPacketTotalMoney` decimal(10,2) DEFAULT NULL COMMENT '未使用红包的总金额',
  `r_redPacketInfoDesc` varchar(255) DEFAULT NULL COMMENT '红包实例的描述',
  `r_redPacketInfoCreateTime` datetime DEFAULT NULL COMMENT '红包实例的创建时间',
  `r_sharedPacketFlag` tinyint(4) DEFAULT NULL COMMENT '分享红包的标志位（看这个红包是否已经分享  分享1  没有分享0）',
  PRIMARY KEY (`r_redPacketInfoId`),
  KEY `r_redPacketID` (`r_redPacketID`),
  KEY `c_taId` (`c_taId`),
  CONSTRAINT `r_red_packet_info_ibfk_1` FOREIGN KEY (`r_redPacketID`) REFERENCES `r_red_packet_tactics` (`r_redpacketid`),
  CONSTRAINT `r_red_packet_info_ibfk_2` FOREIGN KEY (`c_taId`) REFERENCES `c_table_account_info` (`c_taId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包实例表';

-- ----------------------------
-- Table structure for r_red_packet_tactics
-- ----------------------------
DROP TABLE IF EXISTS `r_red_packet_tactics`;
CREATE TABLE `r_red_packet_tactics` (
  `r_redPacketID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '商家分享红包ID',
  `r_marketingStrategyID` bigint(20) DEFAULT NULL COMMENT '营销策略ID',
  `r_redPacketMoney` decimal(10,2) DEFAULT NULL COMMENT '商家分享的红包金额',
  `r_maxSharedPeople` int(11) DEFAULT NULL COMMENT '红包的数目(最大分享人数)',
  `r_redPacketTacticsCreateTime` datetime DEFAULT NULL COMMENT '红包策略的创建时间',
  `r_redPacketTacticsFlag` tinyint(4) DEFAULT NULL COMMENT '红包策略的标志位 1有效 0无效',
  `r_consumeMoneyProportion` int(20) DEFAULT NULL COMMENT '消费金额比率单位:%',
  `r_redPacketDesc` varchar(256) DEFAULT NULL COMMENT '分享红包描述',
  `r_redPacketNote` varchar(256) DEFAULT NULL COMMENT '分享红包备注',
  PRIMARY KEY (`r_redPacketID`),
  KEY `r_red_packet_tactics_ibfk_1` (`r_marketingStrategyID`),
  CONSTRAINT `r_red_packet_tactics_ibfk_1` FOREIGN KEY (`r_marketingStrategyID`) REFERENCES `r_marketing_strategy` (`r_marketingStrategyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='分享红包';

-- ----------------------------
-- Table structure for r_res_dev
-- ----------------------------
DROP TABLE IF EXISTS `r_res_dev`;
CREATE TABLE `r_res_dev` (
  `r_devId` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_appId` varchar(32) NOT NULL DEFAULT '' COMMENT '设备号',
  `r_secret` varchar(32) NOT NULL DEFAULT '' COMMENT '秘钥',
  `r_id` bigint(32) NOT NULL,
  PRIMARY KEY (`r_devId`),
  KEY `dev_id` (`r_id`),
  CONSTRAINT `dev_id` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_restaurant_info
-- ----------------------------
DROP TABLE IF EXISTS `r_restaurant_info`;
CREATE TABLE `r_restaurant_info` (
  `r_id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `r_no` varchar(20) NOT NULL COMMENT '餐饮店编号',
  `r_name` varchar(128) NOT NULL COMMENT '餐厅名字',
  `r_address` varchar(256) DEFAULT NULL COMMENT '餐饮店地址',
  `r_detailAddress` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `r_operateTypes` varchar(256) DEFAULT NULL COMMENT '经营范围',
  `r_cooperationAgreementID` int(11) DEFAULT NULL COMMENT '餐饮店合作协议编号',
  `r_operatorID` int(11) DEFAULT NULL COMMENT '餐饮店操作员编号',
  `r_area` varchar(255) DEFAULT NULL COMMENT '餐饮店地方',
  `r_principalID` int(11) DEFAULT NULL COMMENT '餐饮店负责人ID',
  `r_principalName` varchar(64) NOT NULL COMMENT '餐饮店负责人名字',
  `r_principalTelephone` varchar(32) NOT NULL COMMENT '餐饮店负责人电话',
  `r_principalIDCardNo` varchar(32) NOT NULL COMMENT '餐饮店负责人身份证',
  `r_principalIDCardAPath` varchar(256) DEFAULT NULL COMMENT '餐饮店负责人身份证正面',
  `r_principalIDCardBPath` varchar(256) DEFAULT NULL COMMENT '餐饮店负责人身份证反面',
  `r_doorheadPhotoPathAndName` varchar(256) DEFAULT NULL COMMENT '餐饮店门头照',
  `r_logoPath` varchar(256) DEFAULT NULL COMMENT '餐饮店logo',
  `r_regist` int(11) DEFAULT '1' COMMENT '餐饮店注册1,审核中，2审核通过，3审核不通过，4注册人不可查看',
  `r_registStatus` varchar(128) DEFAULT NULL COMMENT '餐饮店注册状态',
  `r_businessLicenseNo` varchar(50) DEFAULT NULL COMMENT '餐饮店营业执照编号',
  `r_businessLicensePath` varchar(256) DEFAULT NULL COMMENT '商家营业执照',
  `r_businessDay` varchar(256) DEFAULT NULL COMMENT '餐饮店营业天',
  `r_businessTime` varchar(256) DEFAULT NULL COMMENT '餐饮店营业时间(每天)',
  `r_businessService` varchar(256) DEFAULT NULL COMMENT '商家的服务',
  `r_registrantPhone` varchar(32) DEFAULT NULL COMMENT '注册人电话',
  `r_registrantWebChatNo` varchar(128) DEFAULT NULL COMMENT '注册人微信',
  `r_hygienicLicensePath` varchar(255) DEFAULT NULL COMMENT '卫生许可证地址',
  `r_mchId` varchar(30) DEFAULT NULL COMMENT '微信商户号',
  `r_longitude` varchar(128) DEFAULT NULL COMMENT '餐饮店经度',
  `r_latitude` varchar(128) DEFAULT NULL COMMENT '餐饮店纬度',
  `r_brand` varchar(50) DEFAULT NULL COMMENT '商家品牌',
  `r_claimStatus` int(1) NOT NULL DEFAULT '0' COMMENT '商家认领状态 0 未认领，1已认领',
  `r_adCode` varchar(30) DEFAULT NULL,
  `s_realAdCode` int(8) DEFAULT NULL COMMENT '地理位置',
  `r_principalEmail` varchar(255) DEFAULT NULL,
  `r_businessFullName` varchar(255) DEFAULT NULL,
  `r_businessAddress` varchar(255) DEFAULT NULL,
  `r_otherService` varchar(255) DEFAULT NULL,
  `r_barPhoto` varchar(255) DEFAULT NULL COMMENT '餐厅吧台照片',
  `r_restaurantPhoto` varchar(255) DEFAULT NULL COMMENT '餐厅照片',
  `r_bankName` varchar(255) DEFAULT NULL COMMENT '开户银行名称',
  `r_branchAddress` varchar(255) DEFAULT NULL COMMENT '支行地址',
  `r_branchName` varchar(255) DEFAULT NULL COMMENT '支行名称',
  `r_account` varchar(255) DEFAULT NULL COMMENT '开户账户',
  `r_branchAdCode` varchar(255) DEFAULT NULL,
  `s_realBranchAdCode` int(8) DEFAULT NULL,
  `s_saleID` int(11) DEFAULT NULL,
  `s_profitShareFlag` int(11) DEFAULT '0' COMMENT '是否开通分账，1 开通，0未开通',
  PRIMARY KEY (`r_id`),
  KEY `R_OperateTypeID` (`r_operateTypes`),
  KEY `r_restaurant_info_ibfk_2` (`r_principalID`),
  KEY `r_no` (`r_no`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_restaurantPay
-- ----------------------------
DROP TABLE IF EXISTS `r_restaurantPay`;
CREATE TABLE `r_restaurantPay` (
  `r_restaurantPayId` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家Id',
  `r_restaurantPayAmount` decimal(10,2) DEFAULT NULL COMMENT '付款金额',
  `r_restaurantPayTime` datetime DEFAULT NULL COMMENT '付款时间',
  `r_restaurantValidyTime` datetime DEFAULT NULL COMMENT '有效时间',
  `r_restaurantPayType` int(10) DEFAULT NULL COMMENT '付款类型',
  `r_restaurantPayTypeName` varchar(30) DEFAULT NULL COMMENT '付费类型名称',
  PRIMARY KEY (`r_restaurantPayId`),
  KEY `r_pay_id` (`r_id`) USING BTREE,
  CONSTRAINT `r_pay_id` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_share_packet_record
-- ----------------------------
DROP TABLE IF EXISTS `r_share_packet_record`;
CREATE TABLE `r_share_packet_record` (
  `r_shareRedPacketID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '分享红包ID',
  `r_redPacketInfoId` bigint(32) NOT NULL COMMENT '分享红包实例ID',
  `s_wxId` bigint(20) DEFAULT NULL COMMENT '获取红包用户WxId',
  `r_shareRedPacketMoney` decimal(10,2) DEFAULT NULL COMMENT '分享红包的金额',
  `r_shareRedPacketStatus` tinyint(6) DEFAULT NULL COMMENT '红包的状态 1使用 0未使用',
  `r_shareRedPacketDesc` varchar(256) DEFAULT NULL COMMENT '分享红包的描述',
  `r_shareRedPacketNote` varchar(256) DEFAULT NULL COMMENT '分享红包的备注',
  `r_sharePacketCreateTime` datetime DEFAULT NULL COMMENT '分享红包记录的创建时间',
  PRIMARY KEY (`r_shareRedPacketID`),
  KEY `s_wxId` (`s_wxId`),
  CONSTRAINT `r_share_packet_record_ibfk_2` FOREIGN KEY (`s_wxId`) REFERENCES `s_wxinfo` (`s_wxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for r_system_user_info
-- ----------------------------
DROP TABLE IF EXISTS `r_system_user_info`;
CREATE TABLE `r_system_user_info` (
  `s_systemUserID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '系统人员ID',
  `s_systemNo` varchar(50) DEFAULT NULL COMMENT '人员编号',
  `s_systemUserPassword` varchar(32) NOT NULL COMMENT '系统用户密码',
  `s_systemUserNote` varchar(32) DEFAULT NULL COMMENT '系统用户信息备注',
  `s_systemUserStatus` int(11) DEFAULT '1' COMMENT '系统用户信息状态',
  `s_systemUserName` varchar(255) NOT NULL COMMENT '用户名',
  `s_parentId` bigint(32) NOT NULL DEFAULT '0' COMMENT '创建者',
  `s_adCode` varchar(30) DEFAULT NULL COMMENT '区域编号',
  `s_realAdCode` int(8) DEFAULT NULL COMMENT '区域编号',
  `s_systemRealName` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `s_systemSex` int(10) DEFAULT NULL COMMENT '性别',
  `s_systemPhone` varchar(20) DEFAULT NULL COMMENT '电话',
  `s_systemType` int(10) DEFAULT '1' COMMENT '人员类型  2代理商  1普通销售人员',
  PRIMARY KEY (`s_systemUserID`),
  KEY `adcode` (`s_adCode`),
  KEY `adcode_1` (`s_realAdCode`),
  CONSTRAINT `adcode_1` FOREIGN KEY (`s_realAdCode`) REFERENCES `s_area` (`s_adcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统用户信息\r\n';

-- ----------------------------
-- Table structure for r_table_info
-- ----------------------------
DROP TABLE IF EXISTS `r_table_info`;
CREATE TABLE `r_table_info` (
  `r_tableInfoID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '桌子编号',
  `r_id` bigint(32) DEFAULT NULL COMMENT '店家编号',
  `r_tableNum` varchar(11) DEFAULT NULL COMMENT '桌子号码',
  `r_qrCodeId` bigint(32) DEFAULT NULL COMMENT '桌子二维码',
  PRIMARY KEY (`r_tableInfoID`),
  KEY `qrCodeId` (`r_qrCodeId`),
  KEY `rId` (`r_id`),
  CONSTRAINT `qrCodeId` FOREIGN KEY (`r_qrCodeId`) REFERENCES `r_qr_code` (`r_qrCodeId`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `rId` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COMMENT='桌子的相关信息';

-- ----------------------------
-- Table structure for r_user_info
-- ----------------------------
DROP TABLE IF EXISTS `r_user_info`;
CREATE TABLE `r_user_info` (
  `r_userID` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_userTelephone` varchar(20) NOT NULL COMMENT '商家用户电话',
  `r_userPassword` varchar(32) DEFAULT NULL COMMENT '商家用户的密码',
  `r_userName` varchar(32) NOT NULL COMMENT '用户名',
  `r_userStatus` int(11) NOT NULL DEFAULT '1' COMMENT '商家用户的状态',
  `r_userNote` varchar(32) DEFAULT NULL COMMENT '商家用户的信息',
  `r_wxOpenId` varchar(32) DEFAULT NULL COMMENT '微信openId',
  `r_wxName` varchar(255) DEFAULT NULL,
  `r_wxPhoto` varchar(255) DEFAULT NULL,
  `r_userType` int(1) NOT NULL DEFAULT '0' COMMENT '0 商家 ，1 集团 , 2 操作员',
  `r_organizateName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`r_userID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='商家用户的相关信息\r\n';

-- ----------------------------
-- Table structure for r_waitor
-- ----------------------------
DROP TABLE IF EXISTS `r_waitor`;
CREATE TABLE `r_waitor` (
  `r_waitorID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '服务员ID',
  `r_id` bigint(32) DEFAULT NULL COMMENT '餐饮店编号',
  `r_waitorType` varchar(64) DEFAULT NULL COMMENT '服务员类型',
  `r_waitorName` varchar(64) DEFAULT NULL COMMENT '服务员名字',
  `r_waitorTel` varchar(64) DEFAULT NULL COMMENT '服务员电话',
  `r_waitorNo` varchar(32) DEFAULT NULL COMMENT '服务员编号',
  `r_waitorSex` int(11) DEFAULT NULL,
  `r_wxOpenId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`r_waitorID`),
  CONSTRAINT `r_waitor_ibfk_2` FOREIGN KEY (`r_waitorID`) REFERENCES `r_restaurant_info` (`r_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='服务员信息表';

-- ----------------------------
-- Table structure for s_agent
-- ----------------------------
DROP TABLE IF EXISTS `s_agent`;
CREATE TABLE `s_agent` (
  `s_agentId` bigint(32) NOT NULL,
  `s_systemUserID` bigint(32) DEFAULT NULL,
  `s_agentOpenNumber` int(10) DEFAULT '0' COMMENT '剩余开通数量',
  `s_agentValidTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '有效期',
  `s_startTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `s_agentStatus` int(1) DEFAULT '1' COMMENT '状态',
  `s_returnPercent` decimal(10,0) DEFAULT '0' COMMENT '返佣比例',
  PRIMARY KEY (`s_agentId`),
  KEY `agent_systemUser` (`s_systemUserID`),
  CONSTRAINT `agent_systemUser` FOREIGN KEY (`s_systemUserID`) REFERENCES `r_system_user_info` (`s_systemUserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_agentPay
-- ----------------------------
DROP TABLE IF EXISTS `s_agentPay`;
CREATE TABLE `s_agentPay` (
  `s_agentPayId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_agentId` bigint(32) DEFAULT NULL,
  `s_systemUserID` bigint(30) DEFAULT NULL,
  `s_agentPayType` varchar(50) DEFAULT NULL COMMENT '支付时长选择',
  `r_payFeeTypeID` bigint(32) DEFAULT NULL COMMENT '支付方式',
  `s_agentPayAmount` decimal(10,0) DEFAULT NULL COMMENT '付款金额',
  `s_agentPayTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '付款时间',
  `s_agentPayStartTime` datetime DEFAULT NULL COMMENT '付款开始时间',
  `s_agentValidTime` datetime DEFAULT NULL COMMENT '有效时间',
  `s_agentPayMan` varchar(10) DEFAULT NULL COMMENT '付款人',
  `s_agentPayNote` varchar(255) DEFAULT NULL COMMENT '付款备注',
  `s_invoiceName` varchar(50) DEFAULT NULL COMMENT '开票名称',
  `s_invoiceAdress` varchar(255) DEFAULT NULL COMMENT '开票地址',
  `s_invoicePhone` varchar(20) DEFAULT NULL COMMENT '开票电话',
  `s_invoiceNumber` varchar(30) DEFAULT NULL COMMENT ' 开票税号',
  `s_openBank` varchar(255) DEFAULT NULL COMMENT '开户行',
  `s_bankCardNumber` varchar(30) DEFAULT NULL COMMENT '开户行账号',
  `s_invoiveStatus` int(1) DEFAULT '0' COMMENT '开票状态  1 开票  0没开',
  PRIMARY KEY (`s_agentPayId`),
  KEY `agentPay_systemUser` (`s_systemUserID`),
  KEY `agent_agentPay` (`s_agentId`),
  CONSTRAINT `agentPay_systemUser` FOREIGN KEY (`s_systemUserID`) REFERENCES `r_system_user_info` (`s_systemUserID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `agent_agentPay` FOREIGN KEY (`s_agentId`) REFERENCES `s_agent` (`s_agentId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_agreement
-- ----------------------------
DROP TABLE IF EXISTS `s_agreement`;
CREATE TABLE `s_agreement` (
  `s_agreementId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_agreementNo` varchar(50) DEFAULT NULL COMMENT '协议编号',
  `s_agreementName` varchar(50) DEFAULT NULL COMMENT '协议名称',
  `s_agreementFileName` varchar(50) DEFAULT NULL COMMENT '协议文件名称',
  `s_agreementFilePath` varchar(255) DEFAULT NULL COMMENT '协议文件路径',
  `s_agreementStatus` int(10) DEFAULT '1' COMMENT '协议状态',
  PRIMARY KEY (`s_agreementId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_area
-- ----------------------------
DROP TABLE IF EXISTS `s_area`;
CREATE TABLE `s_area` (
  `s_areaName` varchar(50) DEFAULT NULL COMMENT '区域名称',
  `s_cityCode` varchar(10) DEFAULT NULL COMMENT '区号',
  `s_adCode` int(8) NOT NULL COMMENT '区域编号',
  `s_centerLongitude` varchar(128) DEFAULT NULL COMMENT '中心经度',
  `s_centerLatitude` varchar(128) DEFAULT NULL COMMENT '中心维度',
  `s_level` varchar(10) DEFAULT NULL COMMENT '级别',
  `s_cityParentCode` int(10) DEFAULT NULL COMMENT '父Id',
  PRIMARY KEY (`s_adCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_bonus_count
-- ----------------------------
DROP TABLE IF EXISTS `s_bonus_count`;
CREATE TABLE `s_bonus_count` (
  `s_bonusCountID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '平台提成结算编号',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家ID',
  `s_bonusID` bigint(11) DEFAULT NULL COMMENT '平台提成ID',
  `c_taId` bigint(11) DEFAULT NULL COMMENT '桌子账单信息的ID',
  `s_bonusAmount` decimal(10,2) DEFAULT NULL COMMENT '平台提成金额',
  `s_bonusCountStartTime` datetime DEFAULT NULL COMMENT '平台提成开始时间',
  `s_bonusCountEndTime` datetime DEFAULT NULL COMMENT '平台提成结束时间',
  `s_bonusCountNote` varchar(64) DEFAULT NULL COMMENT '平台提成备注',
  PRIMARY KEY (`s_bonusCountID`),
  KEY `R_ID` (`r_id`),
  KEY `S_BonusID` (`s_bonusID`),
  KEY `c_taId` (`c_taId`),
  CONSTRAINT `s_bonus_count_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`),
  CONSTRAINT `s_bonus_count_ibfk_2` FOREIGN KEY (`s_bonusID`) REFERENCES `s_platform_bonus` (`s_bonusID`),
  CONSTRAINT `s_bonus_count_ibfk_3` FOREIGN KEY (`c_taId`) REFERENCES `c_table_account_info` (`c_taId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台提成表 平台对使用系统的每个商家每单都抽取提成 每个时间段形成一个结算表';

-- ----------------------------
-- Table structure for s_log
-- ----------------------------
DROP TABLE IF EXISTS `s_log`;
CREATE TABLE `s_log` (
  `s_logId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `s_type` varchar(20) DEFAULT NULL COMMENT '日志类型',
  `s_title` varchar(20) DEFAULT NULL COMMENT '日志标题',
  `s_remoteAddr` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `s_requestUri` varchar(255) DEFAULT NULL COMMENT 'uri',
  `s_className` varchar(255) DEFAULT NULL COMMENT '类名',
  `s_method` varchar(20) DEFAULT NULL COMMENT '请求方式',
  `s_params` varchar(5000) DEFAULT NULL COMMENT '提交参数',
  `s_exception` varchar(5000) DEFAULT NULL COMMENT '异常',
  `s_operateDate` datetime(6) DEFAULT NULL COMMENT '开始时间',
  `s_userId` bigint(32) DEFAULT NULL COMMENT '用户ID',
  `s_userName` varchar(255) DEFAULT NULL COMMENT '用户名',
  `s_userType` varchar(10) DEFAULT NULL COMMENT '用户类型',
  `s_resultParams` varchar(5000) DEFAULT NULL COMMENT '返回参数',
  PRIMARY KEY (`s_logId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_pay_platform_fee
-- ----------------------------
DROP TABLE IF EXISTS `s_pay_platform_fee`;
CREATE TABLE `s_pay_platform_fee` (
  `s_payId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '商家付费编号',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家id',
  `r_payFeeTypeID` bigint(32) DEFAULT NULL COMMENT '支付方式(支付宝、微信等)的id',
  `s_systemUserID` bigint(32) DEFAULT NULL COMMENT '管理人员id(信息录入人员)',
  `s_payPersonName` varchar(64) DEFAULT NULL COMMENT '付款人姓名',
  `s_payWay` varchar(64) DEFAULT NULL COMMENT '付费方式(年付、季付等)',
  `s_payAmount` double DEFAULT NULL COMMENT '付款金额',
  `s_payTime` date DEFAULT NULL COMMENT '付款时间',
  `s_payStartDate` date DEFAULT NULL COMMENT '开始时间',
  `s_payEndDate` date DEFAULT NULL COMMENT '到期时间',
  `s_payStatus` int(11) DEFAULT NULL COMMENT '商家支付状态（0表示停用，1表示启用）',
  `s_payPhone` varchar(255) DEFAULT NULL COMMENT '开票地电话',
  `s_payNote` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`s_payId`),
  KEY `pay_restaurant` (`r_id`),
  KEY `platform_type` (`r_payFeeTypeID`),
  KEY `pay_systemUser` (`s_systemUserID`),
  CONSTRAINT `pay_restaurant` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pay_systemUser` FOREIGN KEY (`s_systemUserID`) REFERENCES `r_system_user_info` (`s_systemUserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `platform_type` FOREIGN KEY (`r_payFeeTypeID`) REFERENCES `r_pay_fee_type` (`r_payFeeTypeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_pay_success_log
-- ----------------------------
DROP TABLE IF EXISTS `s_pay_success_log`;
CREATE TABLE `s_pay_success_log` (
  `r_success_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `s_wxId` bigint(20) DEFAULT NULL,
  `r_totalAmount` decimal(20,0) DEFAULT NULL,
  `r_disAmount` decimal(10,0) DEFAULT NULL,
  `r_acAmount` decimal(10,0) DEFAULT NULL,
  `r_payTime` varchar(255) DEFAULT NULL,
  `r_resName` varchar(255) DEFAULT NULL,
  `r_billNo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`r_success_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_permission
-- ----------------------------
DROP TABLE IF EXISTS `s_permission`;
CREATE TABLE `s_permission` (
  `s_permissionId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_permissionName` varchar(32) NOT NULL,
  `s_permissionStatus` int(10) NOT NULL DEFAULT '1' COMMENT '0 不可用；1可用',
  `s_permissionNode` varchar(255) DEFAULT NULL,
  `s_showWeight` int(3) NOT NULL DEFAULT '1' COMMENT '目录的权重，为了排序',
  `s_parentId` bigint(32) DEFAULT NULL,
  `s_permissionVisiable` int(1) NOT NULL DEFAULT '1' COMMENT '0 不可见；1可见',
  `s_level` int(1) NOT NULL COMMENT '级别',
  `s_menuPath` varchar(255) DEFAULT NULL COMMENT '目录路径',
  `s_menuIco` varchar(255) DEFAULT NULL COMMENT '目录图标',
  `s_type` int(1) NOT NULL DEFAULT '1' COMMENT '1系统用户 0商家用户',
  PRIMARY KEY (`s_permissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_permission_role
-- ----------------------------
DROP TABLE IF EXISTS `s_permission_role`;
CREATE TABLE `s_permission_role` (
  `s_permissionId` bigint(32) NOT NULL,
  `s_roleId` bigint(32) NOT NULL,
  PRIMARY KEY (`s_permissionId`,`s_roleId`),
  KEY `ss_roles` (`s_roleId`),
  CONSTRAINT `s_permissionId` FOREIGN KEY (`s_permissionId`) REFERENCES `s_permission` (`s_permissionId`),
  CONSTRAINT `ss_roles` FOREIGN KEY (`s_roleId`) REFERENCES `s_role` (`s_roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_platform_bonus
-- ----------------------------
DROP TABLE IF EXISTS `s_platform_bonus`;
CREATE TABLE `s_platform_bonus` (
  `s_bonusID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '平台提成ID',
  `r_id` bigint(32) DEFAULT NULL COMMENT '商家编号',
  `s_bonusNo` varchar(64) DEFAULT NULL COMMENT '平台提成编号',
  `s_bonusName` varchar(64) DEFAULT NULL COMMENT '平台提成名字（按单，优惠券）',
  `s_bonusType` int(11) DEFAULT NULL COMMENT '平台提成类型',
  `s_bonusNumber` float(10,2) DEFAULT NULL COMMENT '平台提成金额或者百分比',
  `s_bonusStatus` tinyint(3) DEFAULT NULL COMMENT '平台提成状态',
  `s_bonusNote` varchar(64) DEFAULT NULL COMMENT '平台提成备注',
  `s_projectNo` varchar(255) DEFAULT NULL,
  `s_startDate` date DEFAULT NULL,
  PRIMARY KEY (`s_bonusID`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `s_platform_bonus_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台提成费用';

-- ----------------------------
-- Table structure for s_restaurant_platform_bonus
-- ----------------------------
DROP TABLE IF EXISTS `s_restaurant_platform_bonus`;
CREATE TABLE `s_restaurant_platform_bonus` (
  `s_restaurant_bonus_id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `r_id` bigint(32) DEFAULT NULL,
  `s_shareBonus` float(10,2) DEFAULT NULL COMMENT '分享抽成',
  `s_couponBonus` float(10,2) DEFAULT NULL COMMENT '优惠券抽成',
  `s_startDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '生效日期',
  `s_standard_charge` float(10,2) DEFAULT NULL COMMENT '标准手续费',
  `s_discount_charge` float(10,2) DEFAULT NULL COMMENT '优惠手续费',
  `s_discount_endDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '优惠到期日',
  PRIMARY KEY (`s_restaurant_bonus_id`),
  KEY `r_bonus` (`r_id`),
  CONSTRAINT `s_restaurant_platform_bonus_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_role
-- ----------------------------
DROP TABLE IF EXISTS `s_role`;
CREATE TABLE `s_role` (
  `s_roleId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_roleNo` varchar(50) DEFAULT NULL COMMENT '角色编号',
  `s_name` varchar(32) NOT NULL,
  `s_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`s_roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_ruser_role
-- ----------------------------
DROP TABLE IF EXISTS `s_ruser_role`;
CREATE TABLE `s_ruser_role` (
  `s_roleId` bigint(32) NOT NULL,
  `r_userId` bigint(32) NOT NULL,
  PRIMARY KEY (`s_roleId`,`r_userId`),
  KEY `user` (`r_userId`),
  CONSTRAINT `role` FOREIGN KEY (`s_roleId`) REFERENCES `s_role` (`s_roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`r_userId`) REFERENCES `r_user_info` (`r_userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_sales
-- ----------------------------
DROP TABLE IF EXISTS `s_sales`;
CREATE TABLE `s_sales` (
  `s_saleID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '销售人员ID',
  `s_saleType` varchar(64) DEFAULT NULL COMMENT '销售人员类型',
  `s_saleName` varchar(64) DEFAULT NULL COMMENT '销售人员名称',
  `s_saleTel` varchar(64) DEFAULT NULL COMMENT '销售人员电话',
  `s_saleIDCardNo` varchar(32) NOT NULL COMMENT '销售人员身份证号码',
  `s_saleIDCardA` varchar(256) DEFAULT NULL COMMENT '销售人员身份证',
  `s_saleIDCardB` varchar(256) DEFAULT NULL,
  `s_saleAddress` varchar(128) DEFAULT NULL COMMENT '销售人员地址',
  `s_saleParentID` int(11) DEFAULT NULL COMMENT '销售人员上一级ID',
  `s_sex` int(11) DEFAULT NULL,
  `s_state` int(11) DEFAULT NULL,
  `s_systemUserID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`s_saleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_service
-- ----------------------------
DROP TABLE IF EXISTS `s_service`;
CREATE TABLE `s_service` (
  `s_docId` bigint(32) NOT NULL AUTO_INCREMENT,
  `r_id` bigint(32) DEFAULT NULL,
  `s_wxOpenId` varchar(32) DEFAULT NULL COMMENT '消费者微信openId',
  `s_serviceType` int(11) DEFAULT NULL COMMENT '意见渠道（0表示消费者，1表示商家）',
  `s_docment` varchar(2048) DEFAULT NULL,
  `s_handleWay` varchar(64) DEFAULT NULL,
  `s_handleStatus` varchar(64) DEFAULT NULL,
  `s_handleResult` varchar(255) DEFAULT NULL,
  `s_linkManName` varchar(64) DEFAULT NULL,
  `s_linkManTelephone` varchar(32) DEFAULT NULL,
  `s_docSubmitTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '意见提交时间',
  `s_docHandleTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '意见处理时间',
  PRIMARY KEY (`s_docId`),
  KEY `r_id` (`r_id`) USING BTREE,
  CONSTRAINT `service_restaurant` FOREIGN KEY (`r_id`) REFERENCES `r_restaurant_info` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_service_handle
-- ----------------------------
DROP TABLE IF EXISTS `s_service_handle`;
CREATE TABLE `s_service_handle` (
  `s_serviceHandleId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_docId` bigint(32) DEFAULT NULL COMMENT '意见id',
  `s_handleWay` varchar(64) DEFAULT NULL COMMENT '意见处理方式',
  `s_handleProcess` varchar(2048) DEFAULT NULL COMMENT '处理过程',
  `s_handlePerson` varchar(32) DEFAULT NULL COMMENT '意见处理人',
  `s_handleDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '意见处理时间',
  PRIMARY KEY (`s_serviceHandleId`),
  KEY `handle_service` (`s_docId`),
  CONSTRAINT `handle_service` FOREIGN KEY (`s_docId`) REFERENCES `s_service` (`s_docId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_strategy
-- ----------------------------
DROP TABLE IF EXISTS `s_strategy`;
CREATE TABLE `s_strategy` (
  `s_strategyId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_strategyNo` varchar(30) DEFAULT NULL COMMENT '策略序号',
  `s_strategyName` varchar(50) DEFAULT NULL COMMENT '策略名称',
  `s_strategyDes` varchar(255) DEFAULT NULL COMMENT '策略描述',
  `s_strategyStatus` int(10) DEFAULT '1' COMMENT '策略状态',
  PRIMARY KEY (`s_strategyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_suser_role
-- ----------------------------
DROP TABLE IF EXISTS `s_suser_role`;
CREATE TABLE `s_suser_role` (
  `s_roleId` bigint(32) NOT NULL,
  `s_userId` bigint(32) NOT NULL,
  PRIMARY KEY (`s_roleId`,`s_userId`),
  KEY `s_user` (`s_userId`),
  CONSTRAINT `s_role` FOREIGN KEY (`s_roleId`) REFERENCES `s_role` (`s_roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `s_user` FOREIGN KEY (`s_userId`) REFERENCES `r_system_user_info` (`s_systemUserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `s_sys_config`;
CREATE TABLE `s_sys_config` (
  `s_configId` bigint(32) NOT NULL AUTO_INCREMENT,
  `s_configNo` varchar(30) DEFAULT NULL COMMENT '配置编号',
  `s_configName` varchar(255) DEFAULT NULL COMMENT '配置名称',
  `s_configValue` varchar(20000) DEFAULT NULL COMMENT '配置信息',
  `s_configNote` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`s_configId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_wuser_role
-- ----------------------------
DROP TABLE IF EXISTS `s_wuser_role`;
CREATE TABLE `s_wuser_role` (
  `s_roleId` bigint(32) NOT NULL,
  `c_userId` bigint(32) NOT NULL,
  PRIMARY KEY (`s_roleId`,`c_userId`),
  KEY `w_user` (`c_userId`),
  CONSTRAINT `w_role` FOREIGN KEY (`s_roleId`) REFERENCES `s_role` (`s_roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `w_user` FOREIGN KEY (`c_userId`) REFERENCES `s_wxinfo` (`s_wxid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for s_wxinfo
-- ----------------------------
DROP TABLE IF EXISTS `s_wxinfo`;
CREATE TABLE `s_wxinfo` (
  `s_wxId` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `s_openId` varchar(32) NOT NULL COMMENT '腾讯openId',
  `s_username` varchar(32) DEFAULT NULL COMMENT '微信昵称',
  `s_picturePath` varchar(255) DEFAULT NULL COMMENT '微信头像',
  PRIMARY KEY (`s_wxId`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;
DROP TRIGGER IF EXISTS `reset_qrCode`;
DELIMITER ;;
CREATE TRIGGER `reset_qrCode` AFTER DELETE ON `r_table_info` FOR EACH ROW update r_qr_code set r_qrFlag=0,r_name=null where r_qrCodeId = old.r_qrCodeId
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
