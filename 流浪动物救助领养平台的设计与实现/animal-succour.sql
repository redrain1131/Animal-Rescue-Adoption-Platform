SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adopt
-- ----------------------------
DROP TABLE IF EXISTS `adopt`;
CREATE TABLE `adopt`  (
  `adopt_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '领养申请ID',
  `animal_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '宠物ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请人姓名',
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电子邮箱',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '居住地址',
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '职业',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请理由',
  `pet_experience` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '养宠经验',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '审核中' COMMENT '申请状态',
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理说明',
  `user_id` int(11) NOT NULL COMMENT '申请用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  PRIMARY KEY (`adopt_id`) USING BTREE,
  UNIQUE INDEX `adopt_id`(`adopt_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '宠物' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of adopt
-- ----------------------------
INSERT INTO `adopt` VALUES ('65c2ee88-9cfd-4e57-a5b2-633710c8cc8e', 'afec61bb-da2b-11f0-a8f9-bc2411d312f6', '张三', '13688883333', '159@163.com', ' 成都市温江区698号', '软件工程师', '家中有宝宝, 想给宝宝一个有宠物陪伴的快乐童年', '5年以上', '已拒绝', '经审核，您的申请未通过，因为您的职业陪伴宠物时间较少', 110, '2025-12-16 16:51:08');
INSERT INTO `adopt` VALUES ('b62b062f-e124-4d01-bc4c-393ab99bf7cf', 'afec71ed-da2b-11f0-a8f9-bc2411d312f6', '张三', '13699993333', '101@163.com', '成都市温江区963号', '软件工程师', '经济条件足够, 可以照顾好小家伙', '5年以上', '已完成', '领养已完成，感谢您的爱心', 110, '2025-12-16 17:20:09');
INSERT INTO `adopt` VALUES ('c51932f0-8cef-4cba-876c-9d3d3aca5a13', 'afec61bb-da2b-11f0-a8f9-bc2411d312f6', '张三', '12366663333', '1632@163.com', '四川省成都市武侯区6666号', '软件工程师', '家中有小孩, 想给孩子一个快乐的童年', '5年以上', '已拒绝', '软件工程师工作繁忙, 不适合养宠物', 110, '2025-12-17 11:38:24');

-- ----------------------------
-- Table structure for animal
-- ----------------------------
DROP TABLE IF EXISTS `animal`;
CREATE TABLE `animal`  (
  `animal_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '宠物ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '宠物名字',
  `categoryId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类ID',
  `age` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '年龄',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '性别',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '可领养' COMMENT '状态',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '照片',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '介绍',
  `station_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助站ID',
  `process` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助过程',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`animal_id`) USING BTREE,
  UNIQUE INDEX `animal_id`(`animal_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '宠物' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of animal
-- ----------------------------
INSERT INTO `animal` VALUES ('ae153856-b7ab-431b-987f-e4f75205f31a', '哈哈', '6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '3岁', '公', '可领养', '/profile/upload/2025/12/17/20220619215915_1b43f_4aa65bcb28854ee48bd85513d6d9a6e1.jpg', '萌宠', 'eccd44b7-c7c8-4d80-8164-0d8653c86444', '<p>在臭水沟发现后及时带回</p><p><img src=\"/dev-api/profile/upload/2025/12/17/20220619215915_1b43f_5959fa507a3a48b695ddd05297125b74.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p>', '2025-12-17 11:45:59');
INSERT INTO `animal` VALUES ('afec61bb-da2b-11f0-a8f9-bc2411d312f6', '奥利奥', 'cfdb60a3-9342-410e-94a9-dde88232672b', '1岁', '公', '可领养', '/profile/upload/2025/12/16/狗1_38b49f4024f242b1963ead637120bbb3.png', '超高智商，会接飞盘，需要较大的运动空间。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>奥利奥是一只在市中心被发现的流浪狗。当时它瘦弱不堪，身上还有伤痕。幸运的是，一位好心的市民发现了它并联系了我们的救助站。</p><p>经过兽医的检查和治疗，奥利奥恢复了健康。它是一只非常聪明和亲人的狗狗，喜欢和其他动物玩耍，也特别喜欢和小朋友在一起。</p><p>现在它正在等待那个能给它温暖家庭的人。如果你愿意给它一个家，请考虑领养奥利奥吧！</p>', '2025-12-16 11:02:41');
INSERT INTO `animal` VALUES ('afec71ed-da2b-11f0-a8f9-bc2411d312f6', '汤圆', '6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '2岁', '母', '已领养', '/profile/upload/2025/12/16/猫1_01cc5825298a4eb498aa0276f91020c2.png', '性格粘人，喜欢在键盘上睡觉，已绝育。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>汤圆是在一个寒冷冬夜被送到我们救助站的小猫咪。当时它只有几个月大，在街头流浪了很久，身体非常虚弱。</p><p>志愿者们精心照料着汤圆，给它喂奶、洗澡、驱虫和疫苗接种。在大家的关爱下，汤圆逐渐恢复了活力，变得越来越粘人。</p><p>现在的汤圆已经是一只漂亮又健康的大猫咪了，它希望能找到一个永远爱它的家。</p>', '2025-12-16 10:57:41');
INSERT INTO `animal` VALUES ('afec7452-da2b-11f0-a8f9-bc2411d312f6', '大黄', 'cfdb60a3-9342-410e-94a9-dde88232672b', '3岁', '公', '可领养', '/profile/upload/2025/12/16/狗2_9e7568b49b8945b48034e278e5c2a010.png', '忠诚护主，不挑食，身体非常健康。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>大黄是在一次救助行动中被发现的，当时它和其他几只流浪狗一起生活在公园里。</p><p>虽然生活条件艰苦，但大黄一直保护着比它更小的狗，展现出了很强的领袖气质。经过全面体检，大黄身体健康，没有任何疾病。</p><p>由于其出色的品质，大黄很快就被一位爱心人士预订了，相信它会在新家中继续发挥自己的优秀品质。</p>', '2025-12-16 10:52:41');
INSERT INTO `animal` VALUES ('afec7512-da2b-11f0-a8f9-bc2411d312f6', 'Luna', '6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '4岁', '母', '可领养', '/profile/upload/2025/12/16/猫2_f694f1c78d3e4ceb870fa47caf63a0d3.png', '曾经的种猫，被救助后正在寻找退休生活，性格胆小需要耐心。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>Luna曾是一只种猫，在被救助前经历了很长时间的繁殖生涯，这对她的身心都造成了很大的创伤。</p><p>刚来到救助站时，Luna非常胆小，总是躲在角落里不敢出来。志愿者们用了很多耐心和爱心慢慢赢得了她的信任。</p><p>经过一年多的调养和心理康复，Luna现在已经准备好迎接新的生活了，她需要一个安静、有耐心的家庭给她足够的安全感。</p>', '2025-12-16 10:47:41');
INSERT INTO `animal` VALUES ('afec75c7-da2b-11f0-a8f9-bc2411d312f6', '豆豆', 'cfdb60a3-9342-410e-94a9-dde88232672b', '2岁', '公', '可领养', '/profile/upload/2025/12/16/狗3_d7d37c1439734ca5aa3d67256dbf5265.png', '腿短但跑得快，喜欢和小朋友一起玩。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>豆豆是被人遗弃在宠物医院门口的小柯基，当时才几个月大，还没有完全断奶。</p><p>宠物医院的医生发现后联系了我们救助站。豆豆从小就展现出活泼好动的性格，即使在很小的时候也很勇敢。</p><p>在救助站成长的过程中，豆豆一直是大家的开心果，它聪明伶俐，很容易学会各种指令，非常适合有孩子的家庭。</p>', '2025-12-16 10:42:41');
INSERT INTO `animal` VALUES ('afec764c-da2b-11f0-a8f9-bc2411d312f6', '奶茶', '6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '1岁', '母', '可领养', '/profile/upload/2025/12/16/猫3_39b9c87d54a54d0e89299ba4175f20b9.png', '野性十足但很亲人，适应能力强。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>奶茶是在一个老旧小区被发现的流浪猫，那时它刚刚成为母亲，为了保护自己的孩子不得不在恶劣环境中求生存。</p><p>在孩子们能够独立生活后，奶茶也因为长期的流浪生活导致身体状况不佳。好心居民将其送到了我们救助站。</p><p>经过一段时间的调理，奶茶的身体状况大大改善，它既有野性的独立，又有家猫的亲和力，是一只很有魅力的猫咪。</p>', '2025-12-16 10:37:41');
INSERT INTO `animal` VALUES ('afec76f7-da2b-11f0-a8f9-bc2411d312f6', '旺财', 'cfdb60a3-9342-410e-94a9-dde88232672b', '3岁', '公', '可领养', '/profile/upload/2025/12/16/狗4_3ad364649dfe412e8d34a28e1bc7b0cf.png', '温顺友善，是理想的家庭伴侣犬。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>旺财是作为礼物被送给一个家庭的，但由于家庭变故不得不忍痛割爱送到救助站。</p><p>它有着良好的训练基础和社会化经历，很快就适应了救助站的生活，并且成为了志愿者们的好帮手。</p>', '2025-12-16 10:32:41');
INSERT INTO `animal` VALUES ('afec7776-da2b-11f0-a8f9-bc2411d312f6', '小白', '6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '8个月', '母', '可领养', '/profile/upload/2025/12/16/猫4_6c0a81487e4f4d529690984f13c03357.png', '活泼可爱，好奇心强，喜欢探索新环境。', '8eb78133-215c-4d7c-99e9-0617c36ce650', '<p>小白是在一场大雨后被好心人发现的，当时它躲在垃圾桶旁边瑟瑟发抖，全身湿透。</p><p>送到救助站时小白还有些营养不良，但在工作人员的精心照料下很快就恢复了健康，展现出了小猫咪应有的活泼天性。</p><p>作为一个年轻的小家伙，小白还有很多精力需要释放，它需要一个充满爱的家庭陪伴它健康成长。</p>', '2025-12-16 10:27:41');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `banner_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '轮播图ID',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片',
  `sort` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`banner_id`) USING BTREE,
  UNIQUE INDEX `banner_id`(`banner_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轮播图' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('47ac5c42-7b60-4ff7-9af6-b48ff0e0bb9f', '/profile/upload/2025/12/16/1_4cba154351cd4495baf4ed5ceb0f9763.png', 1);
INSERT INTO `banner` VALUES ('56347b7c-dfb5-46a1-80a5-09fe3ea3e8c9', '/profile/upload/2025/12/16/2_d58b9d007f6b469cbf1d39d93e2b6f45.png', 2);
INSERT INTO `banner` VALUES ('aeb59820-cd54-4694-a873-ab2e3ac49bad', '/profile/upload/2025/12/16/3_9c0daf73a58d4c4c8195c8b7d91a05d0.png', 3);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY (`category_id`) USING BTREE,
  UNIQUE INDEX `category_id`(`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '萌宠分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('6adff3ac-2d59-485d-9976-ec12e59cffbd', '其他宠物', 3);
INSERT INTO `category` VALUES ('6e2f55b0-ab1f-4b99-b4e9-5d6e48b0cb1f', '喵星人', 2);
INSERT INTO `category` VALUES ('cfdb60a3-9342-410e-94a9-dde88232672b', '汪星人', 1);

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
  `report_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址',
  `situation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动物情况',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '现场图片',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  UNIQUE INDEX `report_id`(`report_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '动物救助' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES ('160748a6-aa2f-4653-9a40-6d20f02eddbf', '张三', '13699998888', '青羊区文庙街巷尾', '在文庙街巷尾发现了两个小家伙, 寒风中瑟瑟发抖\n', '/profile/upload/2025/12/16/流浪动物1_b442964d033c4eb0bf4cfda79903a85d.png', '2025-12-16 23:19:24');
INSERT INTO `report` VALUES ('6d3881fe-49b1-4ee9-9a06-954b8ffe8d07', '张三', '15633332222', '成都市青羊区008号', '小家伙在寒风中已经一晚上了', '/profile/upload/2025/12/17/20220619215915_1b43f_5150b08cdb01420f9dfdbfd93962d767.jpg', '2025-12-17 11:48:39');

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station`  (
  `station_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助站ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助站名称',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助站logo',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '负责人姓名',
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电子邮箱',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '救助站描述',
  `business_license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '营业执照',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '法人身份证',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '待审核' COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '认证提交时间',
  PRIMARY KEY (`station_id`) USING BTREE,
  UNIQUE INDEX `station_id`(`station_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('1de125ab-a37a-4f29-be19-cf17cb61527c', '未来之星', '/profile/upload/2025/12/16/未来之星_7a55e141aad2494781135f71779a6686.png', '林溪', '010-55667788', '010@163.com', '成都市青羊区光明巷101号', '新建救助站，专注于猫咪救助。', '/profile/upload/2025/12/16/营业执照_98a3557edf1847e0a159754c19322415.png', '/profile/upload/2025/12/16/身份证_1a8fc683e8d94c6d86721d061c720a48.png', '审核通过', 114, '2025-12-16 17:58:26');
INSERT INTO `station` VALUES ('4741115b-28ba-4599-be8a-f41c955cfac2', '希望之家', '/profile/upload/2025/12/16/希望之家_e4d9a0204a034a4bb11d90ce9bb41808.png', '羽飞', '12599993333', '259@163.com', '成都市锦江区希望路456号', '专业野生动物救助机构，主要救助鸟类和小型哺乳动物。', '/profile/upload/2025/12/16/营业执照_7044ac869ae84e25a4c3ae5e44ebbf2a.png', '/profile/upload/2025/12/16/身份证_3b77703ef3514a2f82a5ead184b66d36.png', '审核通过', 112, '2025-12-16 18:01:20');
INSERT INTO `station` VALUES ('4cf68b97-8b4e-493c-a817-81b897aeb962', '彩虹桥', '/profile/upload/2025/12/16/彩虹桥_efad3c04d5c648738186d5ec5f9a9da5.png', '杨瑞', '15988881111', '123@163.com', '四川省成都市青羊区2233号', '综合性救助站，同时救助猫狗和其他小动物，设施完善。', '/profile/upload/2025/12/16/营业执照_ad5f15a3453848219ba43f5681ed3031.png', '/profile/upload/2025/12/16/身份证_cc61f94d63f14c3a999875bedbb0d938.png', '审核通过', 115, '2025-12-16 12:53:33');
INSERT INTO `station` VALUES ('8eb78133-215c-4d7c-99e9-0617c36ce650', '爱心救助站', '/profile/upload/2025/12/15/爱心救助站_3f18b22f6f4d4ed8b63d33350d95718e.png', '王强', '13699998888', '136@163.com', '成都市武侯区999号', '成立于2015年，专注于流浪猫狗救助，已帮助500+只动物找到新家。', '/profile/upload/2025/12/15/营业执照_26876be1a0054cefb9cc40e471172dba.png', '/profile/upload/2025/12/15/身份证_18a58210ab39437ea331944198d1ef23.png', '审核通过', 111, '2025-12-15 17:39:02');
INSERT INTO `station` VALUES ('eccd44b7-c7c8-4d80-8164-0d8653c86444', '花菜救助站', '/profile/upload/2025/12/17/logo_0b7aae7398c943d79947455d0ea34418.png', '花菜', '12388882222', '82@163.com', '成都市武侯区888号', '擅长营救危重症动物', '/profile/upload/2025/12/17/营业执照_08a348d64a9647e1a7e838435d446a96.png', '/profile/upload/2025/12/17/身份证_76208958c8c341a899b9508206d4afa9.png', '审核通过', 118, '2025-12-17 11:43:27');
INSERT INTO `station` VALUES ('f17d21f3-cf33-47ed-98b5-7ba44828b273', '温暖港湾', '/profile/upload/2025/12/16/温暖港湾_03a7ce4f6e524c3f9400a596f030e913.png', '张明轩', '12699998888', '126@163.com', '四川省成都市武侯区223号', '社区合作救助站，主要面向老年宠物和特殊需求动物。', '/profile/upload/2025/12/16/营业执照_2d0f01e4d0334d2c95486b4d3c0235a2.png', '/profile/upload/2025/12/16/身份证_e58f9e4677ee4cdf805056250f2b8af2.png', '审核通过', 113, '2025-12-16 17:57:11');
INSERT INTO `station` VALUES ('f6664e2d-ed7a-4973-a758-047c019aaafa', '天使之翼', '/profile/upload/2025/12/16/天使之翼_cbe67ea440f74a8abd632f7f14fbdcf7.png', '王浩然', '16699992222', '1663@163.com', '成都市郫都区天使街303号', '擅长营救危重症动物', '/profile/upload/2025/12/16/营业执照_a38b058e4c4b420eb1ccd7d24a03cccc.png', '/profile/upload/2025/12/16/身份证_b8f009b5246a490da6eb5d3d274349eb.png', '审核通过', 116, '2025-12-16 18:03:42');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(11) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) NULL DEFAULT 1 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2012 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 99, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '系统管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-12-15 00:05:04', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 1, 'C', '0', '0', '用户管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-12-15 00:05:07', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (3, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 1, 'C', '0', '0', '角色管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-12-15 00:05:10', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (4, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 1, 'C', '0', '0', '菜单管理', 'admin', '2025-08-30 08:59:54', 'admin', '2025-12-15 00:05:12', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (2006, '萌宠分类管理', 0, 1, 'category', 'succour/category/index', NULL, '', 1, 1, 'C', '0', '0', '宠物分类管理', 'admin', '2025-12-15 14:24:24', 'admin', '2025-12-15 14:25:26', '');
INSERT INTO `sys_menu` VALUES (2007, '救助站审核/管理', 0, 2, 'station', 'succour/station/index', NULL, '', 1, 1, 'C', '0', '0', '救助站审核_管理', 'admin', '2025-12-15 16:22:52', 'admin', '2025-12-17 00:47:36', '');
INSERT INTO `sys_menu` VALUES (2008, '萌宠领养发布', 0, 3, 'animal', 'succour/animal/index', NULL, '', 1, 1, 'C', '0', '0', '萌宠领养发布', 'admin', '2025-12-16 00:35:53', 'admin', '2025-12-17 00:47:46', '');
INSERT INTO `sys_menu` VALUES (2009, '领养申请审核', 0, 4, 'adopt', 'succour/adopt/index', NULL, '', 1, 1, 'C', '0', '0', '领养申请审核', 'admin', '2025-12-16 14:06:52', 'admin', '2025-12-17 00:47:56', '');
INSERT INTO `sys_menu` VALUES (2010, '动物救助管理', 0, 5, 'report', 'succour/report/index', NULL, '', 1, 1, 'C', '0', '0', '动物救助管理', 'admin', '2025-12-16 23:04:42', 'admin', '2025-12-17 00:48:03', '');
INSERT INTO `sys_menu` VALUES (2011, '轮播图管理', 0, 6, 'banner', 'succour/banner/index', NULL, '', 1, 1, 'C', '0', '0', '轮播图管理', 'admin', '2025-12-16 23:27:37', 'admin', '2025-12-17 00:48:07', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-12-15 00:05:25', '', '2025-12-15 00:05:18', '超级管理员');
INSERT INTO `sys_role` VALUES (2, 'user', NULL, 2, '1', 1, 1, '0', '0', 'admin', '2025-12-15 00:05:26', 'admin', '2025-12-15 00:05:32', NULL);
INSERT INTO `sys_role` VALUES (102, 'station', NULL, 3, '1', 1, 0, '0', '0', 'admin', '2025-12-15 16:49:09', 'admin', '2025-12-16 15:13:12', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (102, 2008);
INSERT INTO `sys_role_menu` VALUES (102, 2009);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '系统管理员', '00', 'huacai@163.com', '15888888888', '1', '', 'admin123', '0', '0', 'admin', '2025-12-15 00:05:41', '', '2025-12-13 23:02:46', '管理员');
INSERT INTO `sys_user` VALUES (110, '张三', '张三', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 00:33:59', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (111, '爱心救助站', '爱心救助站', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:45:33', 'admin', '2025-12-15 23:40:21', NULL);
INSERT INTO `sys_user` VALUES (112, '希望之家', '希望之家', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:45:58', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (113, '温暖港湾', '温暖港湾', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:46:08', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (114, '未来之星', '未来之星', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:46:16', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (115, '彩虹桥', '彩虹桥', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:46:24', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (116, '天使之翼', '天使之翼', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-15 16:46:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (117, '李四', '李四', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-16 15:48:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (118, '花菜救助站', '花菜救助站', '00', '', '', '0', '', '123456', '0', '0', '', '2025-12-17 11:41:54', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (110, 2);
INSERT INTO `sys_user_role` VALUES (111, 102);
INSERT INTO `sys_user_role` VALUES (112, 102);
INSERT INTO `sys_user_role` VALUES (113, 102);
INSERT INTO `sys_user_role` VALUES (114, 102);
INSERT INTO `sys_user_role` VALUES (115, 102);
INSERT INTO `sys_user_role` VALUES (116, 102);
INSERT INTO `sys_user_role` VALUES (117, 2);
INSERT INTO `sys_user_role` VALUES (118, 102);

SET FOREIGN_KEY_CHECKS = 1;
