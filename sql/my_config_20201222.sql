DROP DATABASE IF EXISTS `knight-config`;

CREATE DATABASE  `knight-config` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;

/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : knight-config

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2021-01-22 16:57:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `content` longtext COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `c_use` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `effect` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `c_schema` text COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

-- ----------------------------
-- Records of config_info
-- ----------------------------
insert into config_info(id, data_id, group_id, content, md5, gmt_create, gmt_modified, src_user, src_ip, app_name, tenant_id, c_desc, c_use, effect, type, c_schema) values
(1,'application-dev.yml','DEFAULT_GROUP','spring:\n  main:\n    allow-bean-definition-overriding: true\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n','c07e6f7321493f6d5390d0a08bffb75a','2019-11-29 16:31:20','2020-12-21 15:29:24',NULL,'0:0:0:0:0:0:0:1','','','通用配置','null','null','yaml','null'),
(2,'knight-gateway-dev.yml','DEFAULT_GROUP','spring:\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: knight-auth\r\n          uri: lb://knight-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # 代码生成\r\n        - id: ruoyi-gen\r\n          uri: lb://knight-modules-gen\r\n          predicates:\r\n            - Path=/code/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 定时任务\r\n        - id: knight-modules-job\r\n          uri: lb://ruoyi-job\r\n          predicates:\r\n            - Path=/schedule/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 系统模块\r\n        - id: knight-modules-system\r\n          uri: lb://knight-modules-system\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 文件服务\r\n        - id: knight-modules-file\r\n          uri: lb://knight-modules-file\r\n          predicates:\r\n            - Path=/file/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 不校验白名单\r\nignore:\r\n  whites:\r\n    - /auth/logout\r\n    - /auth/login\r\n    - /*/v2/api-docs\r\n    - /csrf\r\n','ef4a58daf989827334b3aac1c9d68392','2020-05-14 14:17:55','2020-11-18 17:53:23',NULL,'0:0:0:0:0:0:0:1','','','网关模块','null','null','yaml','null'),
(3,'knight-auth-dev.yml','DEFAULT_GROUP','spring: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/knight-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n','868c15010a7a15c027d4c90a48aabb3e','2020-11-20 00:00:00','2020-11-20 00:00:00',NULL,'0:0:0:0:0:0:0:1','','','认证中心','null','null','yaml','null'),
(4,'knight-monitor-dev.yml','DEFAULT_GROUP','# spring\r\nspring: \r\n  security:\r\n    user:\r\n      name: knight\r\n      password: 123456\r\n  boot:\r\n    admin:\r\n      ui:\r\n        title: 服务状态监控\r\n','d8997d0707a2fd5d9fc4e8409da38129','2020-11-20 00:00:00','2020-12-21 16:28:07',NULL,'0:0:0:0:0:0:0:1','','','监控中心','null','null','yaml','null'),
(5,'knight-modules-system-dev.yml','DEFAULT_GROUP','# spring配置\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    druid:\r\n      stat-view-servlet:\r\n        enabled: true\r\n        loginUsername: admin\r\n        loginPassword: 123456\r\n    dynamic:\r\n      druid:\r\n        initial-size: 5\r\n        min-idle: 5\r\n        maxActive: 20\r\n        maxWait: 60000\r\n        timeBetweenEvictionRunsMillis: 60000\r\n        minEvictableIdleTimeMillis: 300000\r\n        validationQuery: SELECT 1 FROM DUAL\r\n        testWhileIdle: true\r\n        testOnBorrow: false\r\n        testOnReturn: false\r\n        poolPreparedStatements: true\r\n        maxPoolPreparedStatementPerConnectionSize: 20\r\n        filters: stat,wall,slf4j\r\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\r\n      datasource:\r\n          # 主库数据源\r\n          master:\r\n            driver-class-name: com.mysql.cj.jdbc.Driver\r\n            url: jdbc:mysql://localhost:3306/knight-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n            username: root\r\n            password: password\r\n          # 从库数据源\r\n          # slave:\r\n            # url: \r\n            # username: \r\n            # password: \r\n            # driver-class-name: \r\n\r\n# mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.wujie.system\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger配置\r\nswagger:\r\n  title: 系统模块接口文档\r\n  license: Powered By wujie\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: Knight OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n','c8eede0126999265ffb465a21502add7','2020-11-20 00:00:00','2020-12-21 16:27:55',NULL,'0:0:0:0:0:0:0:1','','','系统模块','null','null','yaml','null'),
(6,'knight-modules-gen-dev.yml','DEFAULT_GROUP','# spring配置\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource: \r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/knight-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.wujie.gen.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger配置\r\nswagger:\r\n  title: 代码生成接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: Knight OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n\r\n# 代码生成\r\ngen: \r\n  # 作者\r\n  author: wujie\r\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\r\n  packageName: com.wujie.system\r\n  # 自动去除表前缀，默认是false\r\n  autoRemovePre: false\r\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\r\n  tablePrefix: sys_\r\n','5554d54c838876bf2372934c0631aa1b','2020-11-20 00:00:00','2020-12-21 16:23:44',NULL,'0:0:0:0:0:0:0:1','','','代码生成','null','null','yaml','null'),
(7,'knight-modules-job-dev.yml','DEFAULT_GROUP','# spring配置\r\nspring: \r\n  redis:\r\n    host: localhost\r\n    port: 6379\r\n    password: \r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://localhost:3306/knight-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\r\n    username: root\r\n    password: password\r\n\r\n# mybatis配置\r\nmybatis:\r\n    # 搜索指定包别名\r\n    typeAliasesPackage: com.wujie.job.domain\r\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\r\n    mapperLocations: classpath:mapper/**/*.xml\r\n\r\n# swagger配置\r\nswagger:\r\n  title: 定时任务接口文档\r\n  license: Powered By ruoyi\r\n  licenseUrl: https://ruoyi.vip\r\n  authorization:\r\n    name: Knight OAuth\r\n    auth-regex: ^.*$\r\n    authorization-scope-list:\r\n      - scope: server\r\n        description: 客户端授权范围\r\n    token-url-list:\r\n      - http://localhost:8080/auth/oauth/token\r\n','b187acdcbfb8be114f0570bc569ca96d','2020-11-20 00:00:00','2020-12-21 16:24:07',NULL,'0:0:0:0:0:0:0:1','','','定时任务','null','null','yaml','null'),
(8,'knight-modules-file-dev.yml','DEFAULT_GROUP','# 本地文件上传    \r\nfile:\r\n    domain: http://127.0.0.1:9300\r\n    path: D:/ruoyi/uploadPath\r\n    prefix: /statics\r\n\r\n# FastDFS配置\r\nfdfs:\r\n  domain: http://8.129.231.12\r\n  soTimeout: 3000\r\n  connectTimeout: 2000\r\n  trackerList: 8.129.231.12:22122\r\n\r\n# Minio配置\r\nminio:\r\n  url: http://8.129.231.12:9000\r\n  accessKey: minioadmin\r\n  secretKey: minioadmin\r\n  bucketName: test','5382b93f3d8059d6068c0501fdd41195','2020-11-20 00:00:00','2020-12-21 21:01:59',NULL,'0:0:0:0:0:0:0:1','','','文件服务','null','null','yaml','null'),
(9,'sentinel-knight-gateway','DEFAULT_GROUP','[\r\n    {\r\n        \"resource\": \"knight-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"knight-modules-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"knight-modules-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"knight-modules-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]','9f3a3069261598f74220bc47958ec252','2020-11-20 00:00:00','2020-11-20 00:00:00',NULL,'0:0:0:0:0:0:0:1','','','限流策略','null','null','json','null');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info` (
  `id` bigint(64) unsigned NOT NULL,
  `nid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text COLLATE utf8_bin,
  `src_ip` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `op_type` char(10) COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES ('3', '1', 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', '', 0x737072696E673A200D0A202064617461736F757263653A0D0A202020206472697665722D636C6173732D6E616D653A20636F6D2E6D7973716C2E636A2E6A6462632E4472697665720D0A2020202075726C3A206A6462633A6D7973716C3A2F2F6C6F63616C686F73743A333330362F72792D636C6F75643F757365556E69636F64653D7472756526636861726163746572456E636F64696E673D75746638267A65726F4461746554696D654265686176696F723D636F6E76657274546F4E756C6C2675736553534C3D747275652673657276657254696D657A6F6E653D474D54253242380D0A20202020757365726E616D653A20726F6F740D0A2020202070617373776F72643A2070617373776F72640D0A202072656469733A0D0A20202020686F73743A206C6F63616C686F73740D0A20202020706F72743A20363337390D0A2020202070617373776F72643A200D0A, '868c15010a7a15c027d4c90a48aabb3e', '2021-01-22 16:03:42', '2021-01-22 16:03:41', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('3', '2', 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', '', 0x737072696E673A200D0A202064617461736F757263653A0D0A202020206472697665722D636C6173732D6E616D653A20636F6D2E6D7973716C2E636A2E6A6462632E4472697665720D0A2020202075726C3A206A6462633A6D7973716C3A2F2F6C6F63616C686F73743A333330362F6B6E696768742D636C6F75643F757365556E69636F64653D7472756526636861726163746572456E636F64696E673D75746638267A65726F4461746554696D654265686176696F723D636F6E76657274546F4E756C6C2675736553534C3D747275652673657276657254696D657A6F6E653D474D54253242380D0A20202020757365726E616D653A20726F6F740D0A2020202070617373776F72643A2070617373776F72640D0A202072656469733A0D0A20202020686F73743A206C6F63616C686F73740D0A20202020706F72743A20363337390D0A2020202070617373776F72643A200D0A, '4e819f72aa6d4776d971738a7089eafd', '2021-01-22 16:04:16', '2021-01-22 16:04:16', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('3', '3', 'ruoyi-auth-dev.yml', 'DEFAULT_GROUP', '', 0x737072696E673A200D0A202064617461736F757263653A0D0A202020206472697665722D636C6173732D6E616D653A20636F6D2E6D7973716C2E636A2E6A6462632E4472697665720D0A2020202075726C3A206A6462633A6D7973716C3A2F2F6C6F63616C686F73743A333330362F6B6E696768742D636C6F75643F757365556E69636F64653D7472756526636861726163746572456E636F64696E673D75746638267A65726F4461746554696D654265686176696F723D636F6E76657274546F4E756C6C2675736553534C3D747275652673657276657254696D657A6F6E653D474D54253242380D0A20202020757365726E616D653A20726F6F740D0A2020202070617373776F72643A203132333435360D0A202072656469733A0D0A20202020686F73743A206C6F63616C686F73740D0A20202020706F72743A20363337390D0A2020202070617373776F72643A200D0A, 'd8cb43017f675830617bb7ce3285160d', '2021-01-22 16:06:06', '2021-01-22 16:06:06', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('2', '4', 'knight-gateway-dev.yml', 'DEFAULT_GROUP', '', 0x737072696E673A0D0A202072656469733A0D0A20202020686F73743A206C6F63616C686F73740D0A20202020706F72743A20363337390D0A2020202070617373776F72643A200D0A2020636C6F75643A0D0A20202020676174657761793A0D0A202020202020646973636F766572793A0D0A20202020202020206C6F6361746F723A0D0A202020202020202020206C6F776572436173655365727669636549643A20747275650D0A20202020202020202020656E61626C65643A20747275650D0A202020202020726F757465733A0D0A20202020202020202320E8AEA4E8AF81E4B8ADE5BF830D0A20202020202020202D2069643A2072756F79692D617574680D0A202020202020202020207572693A206C623A2F2F72756F79692D617574680D0A20202020202020202020707265646963617465733A0D0A2020202020202020202020202D20506174683D2F617574682F2A2A0D0A2020202020202020202066696C746572733A0D0A2020202020202020202020202320E9AA8CE8AF81E7A081E5A484E790860D0A2020202020202020202020202D2043616368655265717565737446696C7465720D0A2020202020202020202020202D2056616C6964617465436F646546696C7465720D0A2020202020202020202020202D2053747269705072656669783D310D0A20202020202020202320E4BBA3E7A081E7949FE688900D0A20202020202020202D2069643A2072756F79692D67656E0D0A202020202020202020207572693A206C623A2F2F72756F79692D67656E0D0A20202020202020202020707265646963617465733A0D0A2020202020202020202020202D20506174683D2F636F64652F2A2A0D0A2020202020202020202066696C746572733A0D0A2020202020202020202020202D2053747269705072656669783D310D0A20202020202020202320E5AE9AE697B6E4BBBBE58AA10D0A20202020202020202D2069643A2072756F79692D6A6F620D0A202020202020202020207572693A206C623A2F2F72756F79692D6A6F620D0A20202020202020202020707265646963617465733A0D0A2020202020202020202020202D20506174683D2F7363686564756C652F2A2A0D0A2020202020202020202066696C746572733A0D0A2020202020202020202020202D2053747269705072656669783D310D0A20202020202020202320E7B3BBE7BB9FE6A8A1E59D970D0A20202020202020202D2069643A2072756F79692D73797374656D0D0A202020202020202020207572693A206C623A2F2F72756F79692D73797374656D0D0A20202020202020202020707265646963617465733A0D0A2020202020202020202020202D20506174683D2F73797374656D2F2A2A0D0A2020202020202020202066696C746572733A0D0A2020202020202020202020202D2053747269705072656669783D310D0A20202020202020202320E69687E4BBB6E69C8DE58AA10D0A20202020202020202D2069643A2072756F79692D66696C650D0A202020202020202020207572693A206C623A2F2F72756F79692D66696C650D0A20202020202020202020707265646963617465733A0D0A2020202020202020202020202D20506174683D2F66696C652F2A2A0D0A2020202020202020202066696C746572733A0D0A2020202020202020202020202D2053747269705072656669783D310D0A0D0A2320E4B88DE6A0A1E9AA8CE799BDE5908DE58D950D0A69676E6F72653A0D0A20207768697465733A0D0A202020202D202F617574682F6C6F676F75740D0A202020202D202F617574682F6C6F67696E0D0A202020202D202F2A2F76322F6170692D646F63730D0A202020202D202F637372660D0A, 'ef4a58daf989827334b3aac1c9d68392', '2021-01-22 16:26:04', '2021-01-22 16:26:04', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('4', '5', 'knight-monitor-dev.yml', 'DEFAULT_GROUP', '', 0x2320737072696E670D0A737072696E673A200D0A202073656375726974793A0D0A20202020757365723A0D0A2020202020206E616D653A2072756F79690D0A20202020202070617373776F72643A203132333435360D0A2020626F6F743A0D0A2020202061646D696E3A0D0A20202020202075693A0D0A20202020202020207469746C653A20E88BA5E4BE9DE69C8DE58AA1E78AB6E68081E79B91E68EA70D0A, 'd8997d0707a2fd5d9fc4e8409da38129', '2021-01-22 16:26:47', '2021-01-22 16:26:47', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('4', '6', 'knight-monitor-dev.yml', 'DEFAULT_GROUP', '', 0x2320737072696E670D0A737072696E673A200D0A202073656375726974793A0D0A20202020757365723A0D0A2020202020206E616D653A206B6E696768740D0A20202020202070617373776F72643A203132333435360D0A2020626F6F743A0D0A2020202061646D696E3A0D0A20202020202075693A0D0A20202020202020207469746C653A20E69C8DE58AA1E78AB6E68081E79B91E68EA70D0A, '1b80e9dc1edc3bb2d3fac7e3db683fbf', '2021-01-22 16:29:01', '2021-01-22 16:29:02', null, '127.0.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES ('5', '7', 'knight-system-dev.yml', 'DEFAULT_GROUP', '', 0x2320737072696E67E9858DE7BDAE0D0A737072696E673A200D0A202072656469733A0D0A20202020686F73743A206C6F63616C686F73740D0A20202020706F72743A20363337390D0A2020202070617373776F72643A200D0A202064617461736F757263653A0D0A2020202064727569643A0D0A202020202020737461742D766965772D736572766C65743A0D0A2020202020202020656E61626C65643A20747275650D0A20202020202020206C6F67696E557365726E616D653A2061646D696E0D0A20202020202020206C6F67696E50617373776F72643A203132333435360D0A2020202064796E616D69633A0D0A20202020202064727569643A0D0A2020202020202020696E697469616C2D73697A653A20350D0A20202020202020206D696E2D69646C653A20350D0A20202020202020206D61784163746976653A2032300D0A20202020202020206D6178576169743A2036303030300D0A202020202020202074696D654265747765656E4576696374696F6E52756E734D696C6C69733A2036303030300D0A20202020202020206D696E457669637461626C6549646C6554696D654D696C6C69733A203330303030300D0A202020202020202076616C69646174696F6E51756572793A2053454C45435420312046524F4D204455414C0D0A2020202020202020746573745768696C6549646C653A20747275650D0A2020202020202020746573744F6E426F72726F773A2066616C73650D0A2020202020202020746573744F6E52657475726E3A2066616C73650D0A2020202020202020706F6F6C507265706172656453746174656D656E74733A20747275650D0A20202020202020206D6178506F6F6C507265706172656453746174656D656E74506572436F6E6E656374696F6E53697A653A2032300D0A202020202020202066696C746572733A20737461742C77616C6C2C736C66346A0D0A2020202020202020636F6E6E656374696F6E50726F706572746965733A2064727569642E737461742E6D6572676553716C5C3D747275653B64727569642E737461742E736C6F7753716C4D696C6C69735C3D353030300D0A20202020202064617461736F757263653A0D0A202020202020202020202320E4B8BBE5BA93E695B0E68DAEE6BA900D0A202020202020202020206D61737465723A0D0A2020202020202020202020206472697665722D636C6173732D6E616D653A20636F6D2E6D7973716C2E636A2E6A6462632E4472697665720D0A20202020202020202020202075726C3A206A6462633A6D7973716C3A2F2F6C6F63616C686F73743A333330362F72792D636C6F75643F757365556E69636F64653D7472756526636861726163746572456E636F64696E673D75746638267A65726F4461746554696D654265686176696F723D636F6E76657274546F4E756C6C2675736553534C3D747275652673657276657254696D657A6F6E653D474D54253242380D0A202020202020202020202020757365726E616D653A20726F6F740D0A20202020202020202020202070617373776F72643A2070617373776F72640D0A202020202020202020202320E4BB8EE5BA93E695B0E68DAEE6BA900D0A202020202020202020202320736C6176653A0D0A202020202020202020202020232075726C3A200D0A2020202020202020202020202320757365726E616D653A200D0A202020202020202020202020232070617373776F72643A200D0A20202020202020202020202023206472697665722D636C6173732D6E616D653A200D0A0D0A23206D796261746973E9858DE7BDAE0D0A6D7962617469733A0D0A202020202320E6909CE7B4A2E68C87E5AE9AE58C85E588ABE5908D0D0A2020202074797065416C69617365735061636B6167653A20636F6D2E72756F79692E73797374656D0D0A202020202320E9858DE7BDAE6D6170706572E79A84E689ABE68F8FEFBC8CE689BEE588B0E68980E69C89E79A846D61707065722E786D6CE698A0E5B084E69687E4BBB60D0A202020206D61707065724C6F636174696F6E733A20636C617373706174683A6D61707065722F2A2A2F2A2E786D6C0D0A0D0A232073776167676572E9858DE7BDAE0D0A737761676765723A0D0A20207469746C653A20E7B3BBE7BB9FE6A8A1E59D97E68EA5E58FA3E69687E6A1A30D0A20206C6963656E73653A20506F77657265642042792072756F79690D0A20206C6963656E736555726C3A2068747470733A2F2F72756F79692E7669700D0A2020617574686F72697A6174696F6E3A0D0A202020206E616D653A2052756F5969204F417574680D0A20202020617574682D72656765783A205E2E2A240D0A20202020617574686F72697A6174696F6E2D73636F70652D6C6973743A0D0A2020202020202D2073636F70653A207365727665720D0A20202020202020206465736372697074696F6E3A20E5AEA2E688B7E7ABAFE68E88E69D83E88C83E59BB40D0A20202020746F6B656E2D75726C2D6C6973743A0D0A2020202020202D20687474703A2F2F6C6F63616C686F73743A383038302F617574682F6F617574682F746F6B656E0D0A, 'c8eede0126999265ffb465a21502add7', '2021-01-22 16:30:20', '2021-01-22 16:30:20', null, '127.0.0.1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `role` varchar(50) NOT NULL,
  `resource` varchar(512) NOT NULL,
  `action` varchar(8) NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `username` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', '1');
