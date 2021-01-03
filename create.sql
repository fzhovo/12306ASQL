CREATE TABLE `users`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `username` VARCHAR(100) NOT NULL COMMENT '用户名',
    `password` VARCHAR(500) NOT NULL COMMENT 'md5摘要密码',
    `state` TINYINT(3) DEFAULT 0 COMMENT '状态',
    `token` VARCHAR(500) DEFAULT '' COMMENT '验证标识',
    `token_expire` TIMESTAMP COMMENT '标识过期时间',
    `passenger_01_name` VARCHAR(100) COMMENT '常用乘车人姓名',
    `passenger_01_id` VARCHAR(100) COMMENT '常用乘车人身份证号码',
    `passenger_02_name` VARCHAR(100),
    `passenger_02_id` VARCHAR(100),
    `passenger_03_name` VARCHAR(100),
    `passenger_03_id` VARCHAR(100),
    `passenger_04_name` VARCHAR(100),
    `passenger_04_id` VARCHAR(100),
    `passenger_05_name` VARCHAR(100),
    `passenger_05_id` VARCHAR(100)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户管理';

CREATE TABLE `orders`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `user_id` INT(10) UNSIGNED NOT NULL COMMENT '用户名',
    `alipay_order_info` VARCHAR(500) NOT NULL COMMENT '支付宝的信息',
    `money` VARCHAR(100) NOT NULL COMMENT '支付金额',
    `affair_id` VARCHAR(100) NOT NULL COMMENT '业务单号',
    `expire_duration` INT(5) COMMENT '过期时间, 秒数',
    `order_outer_id` VARCHAR(100) NOT NULL UNIQUE COMMENT '订单外部id',
    `state` TINYINT(3) COMMENT '状态,0未支付，1已支付，2已过期',
    CONSTRAINT fk_order_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单管理';

CREATE TABLE `stations`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `name` VARCHAR(50) NOT NULL COMMENT '车站名',
    `city` VARCHAR(50) NOT NULL COMMENT '所在城市',
    `spell` VARCHAR(50) NOT NULL COMMENT '站名拼音',
    `state` TINYINT(3) DEFAULT 0 COMMENT '状态'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车站管理';

CREATE TABLE `train_types`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `type_number` VARCHAR(50) NOT NULL UNIQUE COMMENT '列车类型编号',
    `carriage_list` VARCHAR(200) NOT NULL COMMENT '车厢id , 逗号分隔',
    `carriage_num` INT(4) COMMENT '车箱数',
    `max_speed` INT(4) COMMENT '最高速度, 单位km/h',
    `wifi_state` TINYINT(3) DEFAULT 0 COMMENT '0没有Wifi, 1有wifi',
    `fool_carriages` VARCHAR(50) DEFAULT '' COMMENT '餐车车厢号, 用逗号分隔',
    `max_passenger` INT(5) DEFAULT 0 COMMENT '定员数',
    `length` INT(5) DEFAULT 0 COMMENT '列车长度, 单位m'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车辆类型';

CREATE TABLE `carriage_types`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `soft_berth_number` INT(5) DEFAULT 0 COMMENT '软卧数量',
    `hard_berth_number` INT(5) DEFAULT 0 COMMENT '硬卧数量',
    `senior_soft_benth_number` INT(5) DEFAULT 0 COMMENT '高级软卧数量',
    `hard_seat_number` INT(5) DEFAULT 0 COMMENT '硬座数量',
    `second_seat_number` INT(5) DEFAULT 0 COMMENT '二等座数量',
    `first_seat_number` INT(5) DEFAULT 0 COMMENT '一等座数量',
    `business_seat_number` INT(5) DEFAULT 0 COMMENT '商务座数量',
    `business_seat` VARCHAR(200) DEFAULT '' COMMENT '商务座的全部编号',
    `first_seat` VARCHAR(50) DEFAULT '' COMMENT '一等座开始编号，如A、B、E、F',
    `second_seat` VARCHAR(50) DEFAULT '' COMMENT '二等座开始编号',
    `hard_seat` VARCHAR(50) DEFAULT '' COMMENT '硬座开始编号',
    `hard_berth` VARCHAR(50) DEFAULT '' COMMENT '硬卧开始编号',
    `soft_berth` VARCHAR(50) DEFAULT '' COMMENT '软卧开始编号',
    `senior_soft_berth` VARCHAR(50) DEFAULT '' COMMENT '高级软卧开始编号'
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车厢类型';

CREATE TABLE `trains`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `number` VARCHAR(50) NOT NULL COMMENT '车次号',
    `start_station` VARCHAR(100) NOT NULL COMMENT '车次起点站',
    `end_station` VARCHAR(100) NOT NULL COMMENT '车次终点站',
    `train_type` INT(10) UNSIGNED NOT NULL COMMENT '列车类型 外键',
    `state` TINYINT(3) DEFAULT 0 COMMENT '状态',
    CONSTRAINT fk_train_type FOREIGN KEY (train_type) REFERENCES train_types(id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车次管理';

CREATE TABLE `stop_infos`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `train_id` INT(10) UNSIGNED NOT NULL COMMENT '车次id 外键',
    `station_id`  INT(10) UNSIGNED NOT NULL COMMENT '车站id 外键',
    `train_number` VARCHAR(50) NOT NULL COMMENT '车次编号',
    `station_name` VARCHAR(50) NOT NULL COMMENT '车站名',
    `arrived_time` VARCHAR(50) NOT NULL COMMENT '到达时间',
    `stay_duration` INT(4) UNSIGNED DEFAULT 0 COMMENT '停留时间, 单位秒',
    `stay_num` INT(3) UNSIGNED DEFAULT 0 COMMENT '停留序号',
    CONSTRAINT fk_stop_info_train_id FOREIGN KEY (train_id) REFERENCES trains(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_stop_info_station_id FOREIGN KEY (station_id) REFERENCES stations(id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车次停留站点情况';


CREATE TABLE `candidates`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `date` TIMESTAMP NOT NULL COMMENT '候补时间',
    `train_id`  INT(10) UNSIGNED NOT NULL COMMENT '候补车次id 外键',
    `user_id` INT(10) UNSIGNED NOT NULL COMMENT '候补的用户id 外键',
    `passenger_number` INT(2) NOT NULL COMMENT '候补人数',
    `passenger_id_tag` VARCHAR(20) NOT NULL COMMENT '候补乘车人的身份证标识，用逗号分隔',
    `state` TINYINT(3) DEFAULT 0 COMMENT '状态，0正在候补，1候补成功，2为候补失败',
    CONSTRAINT fk_candidate_train_id FOREIGN KEY (train_id) REFERENCES trains(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_candidate_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='候补管理';


CREATE TABLE `tickets`(
     `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
     `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
     `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
     `deleted_at` TIMESTAMP COMMENT '软删除时间',
     `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `user_id` INT(10) UNSIGNED NOT NULL COMMENT '用户id 外键',
    `start_station`  VARCHAR(100) NOT NULL COMMENT '等待车站名称',
    `end_station` VARCHAR(100) NOT NULL COMMENT '下车站名称',
    `start_time` TIMESTAMP NOT NULL COMMENT '发车时间',
    `train_id` INT(10) UNSIGNED NOT NULL COMMENT '车次id 外键',
    `ticket_outer_id` VARCHAR(100) NOT NULL COMMENT '票外部id',
    `train_num` VARCHAR(50) NOT NULL COMMENT '车次号',
    `passager_name` VARCHAR(100) NOT NULL COMMENT '乘客名',
    `passager_id` VARCHAR(100) NOT NULL COMMENT '乘客身份证号',
    `state` TINYINT(3) DEFAULT 0 COMMENT '状态，0正在候补，1候补成功，2为候补失败',
    CONSTRAINT fk_ticket_train_id FOREIGN KEY (train_id) REFERENCES trains(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ticket_user_id FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已购票管理';

CREATE TABLE `train_run_infos`(
    `id` INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '内部id',
    `created_at` TIMESTAMP NOT NULL COMMENT '创建时间',
    `modified_at` TIMESTAMP COMMENT '最近一次修改时间',
    `deleted_at` TIMESTAMP COMMENT '软删除时间',
    `create_by` VARCHAR(100) NOT NULL COMMENT '创建人',
    `modified_by` VARCHAR(100) COMMENT '最后一次修改人',
    `deleted_by` VARCHAR(100) COMMENT '删除人',

    `train_id` INT(10) UNSIGNED NOT NULL COMMENT '车次id 外键',
    `now_station`  VARCHAR(100) NOT NULL COMMENT '当前停靠车站名',
    `state` TINYINT(3) DEFAULT 1 COMMENT '状态，1为在行驶，2为在停靠站',
    CONSTRAINT fk_runinfo_train_id FOREIGN KEY (train_id) REFERENCES trains(id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='车次运行信息管理';