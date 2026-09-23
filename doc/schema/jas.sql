-- jas 司法鉴定机构与鉴定流程监督管理 -- schema (chen-009)
-- 列名与基线实体契约（@TableName/@TableField）逐列对齐，改列必须同步实体。
-- 库：chen_009

CREATE TABLE IF NOT EXISTS t_jas_audit_sheet (
  id bigint NOT NULL COMMENT '主键',
  batch_no varchar(64) DEFAULT NULL COMMENT '执业报告清册号',
  row_no int DEFAULT NULL COMMENT '原册内行次',
  item_code varchar(64) DEFAULT NULL COMMENT '机构核准号',
  qty decimal(12,2) DEFAULT NULL COMMENT '本行填报鉴定件量(件)',
  status int DEFAULT NULL COMMENT '行进展 0待销 1已入账 2挂退回',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='年度执业报告核收行';

CREATE TABLE IF NOT EXISTS t_jas_cate_bill (
  id bigint NOT NULL COMMENT '主键',
  bill_no varchar(64) DEFAULT NULL COMMENT '类别变更报批单号',
  node_no int DEFAULT NULL COMMENT '当前所在层 0..3',
  sign_mode int DEFAULT NULL COMMENT '同层核准方式 0任一人 1名单点齐',
  need_count int DEFAULT NULL COMMENT '本层应画押人数',
  sign_count int DEFAULT NULL COMMENT '本层已画押人数',
  status int DEFAULT NULL COMMENT '报批情形 0在核 1已核讫 2已打回',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='执业类别变更报批单';

CREATE TABLE IF NOT EXISTS t_jas_complaint_card (
  id bigint NOT NULL COMMENT '主键',
  biz_no varchar(64) DEFAULT NULL COMMENT '投诉处理事务卡号',
  stage int DEFAULT NULL COMMENT '当前格口 0..5',
  status int DEFAULT NULL COMMENT '卡的落定 0在办 1已归档 2已封存',
  content varchar(255) DEFAULT NULL COMMENT '处理记事',
  last_action varchar(64) DEFAULT NULL COMMENT '最近一次挪格动作',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='投诉处理事务卡';

CREATE TABLE IF NOT EXISTS t_jas_due_task (
  id bigint NOT NULL COMMENT '主键',
  item_no varchar(64) DEFAULT NULL COMMENT '出具期限催办单号',
  due_at datetime DEFAULT NULL COMMENT '约定出具日的日终截止时刻',
  amount decimal(12,2) DEFAULT NULL COMMENT '单条提前催办自然日数',
  status int DEFAULT NULL COMMENT '条目情形 0待催办 1已催办 2催不出去',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='出具期限催办条目';

CREATE TABLE IF NOT EXISTS t_jas_fee_tier (
  id bigint NOT NULL COMMENT '主键',
  rule_code varchar(64) DEFAULT NULL COMMENT '减档基准代号',
  rule_name varchar(128) DEFAULT NULL COMMENT '减档基准名称',
  th1_max decimal(12,2) DEFAULT NULL COMMENT '一档标的上限(元)',
  th2_max decimal(12,2) DEFAULT NULL COMMENT '二档标的上限(元)',
  th3_max decimal(12,2) DEFAULT NULL COMMENT '三档标的上限(元)',
  eff_start datetime DEFAULT NULL COMMENT '启用日',
  eff_end datetime DEFAULT NULL COMMENT '交棒日(不含)',
  priority int DEFAULT NULL COMMENT '取用顺位(数值越大越优先)',
  status int DEFAULT NULL COMMENT '线的情形 0在用 1已让位',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鉴定收费减档基准线';

CREATE TABLE IF NOT EXISTS t_jas_firm_doc (
  id bigint NOT NULL COMMENT '主键',
  site_no varchar(64) DEFAULT NULL COMMENT '机构核准号',
  site_name varchar(128) DEFAULT NULL COMMENT '机构核准名称',
  site_type varchar(32) DEFAULT NULL COMMENT '主执业类别',
  road_name varchar(128) DEFAULT NULL COMMENT '驻在(省—市—区县)',
  th1_max decimal(12,2) DEFAULT NULL COMMENT '在册鉴定人一档上限(人)',
  th2_max decimal(12,2) DEFAULT NULL COMMENT '二档上限(人)',
  th3_max decimal(12,2) DEFAULT NULL COMMENT '三档上限(人)',
  status int DEFAULT NULL COMMENT '档案情形 0在册 1已注销',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鉴定机构核准档案';

CREATE TABLE IF NOT EXISTS t_jas_pract_card (
  id bigint NOT NULL COMMENT '主键',
  bill_no varchar(64) DEFAULT NULL COMMENT '鉴定人建档卡号',
  site_id int DEFAULT NULL COMMENT '所在机构核准档案',
  site_no varchar(64) DEFAULT NULL COMMENT '机构核准号',
  qty decimal(12,2) DEFAULT NULL COMMENT '可办执业类别总项数(项)',
  fine_amt decimal(12,2) DEFAULT NULL COMMENT '本年度办件量(件)',
  grade_level int DEFAULT NULL COMMENT '所在机构规模档',
  status int DEFAULT NULL COMMENT '进展 0待核对 1已核对 2已定档',
  del_flag int DEFAULT '0' COMMENT '删除标记 0正常 1删除',
  create_by varchar(64) DEFAULT NULL COMMENT '创建者',
  create_time datetime DEFAULT NULL COMMENT '创建时间',
  update_by varchar(64) DEFAULT NULL COMMENT '更新者',
  update_time datetime DEFAULT NULL COMMENT '更新时间',
  remark varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鉴定人建档卡';

-- 初始档案数据（验收测试依赖 id=1 启用 / id=2 停用）
-- 验收测试依赖 t_jas_firm_doc 两条种子档案：id=0 在册、id=1 已注销（F2 坑5/坑3 的联动判定项）。
-- 在册鉴定人上限取 8/30/80 人，正压在 F2 坑2 的折算断言上（等于上限归高一档）。
INSERT IGNORE INTO t_jas_firm_doc (id, site_no, site_name, site_type, road_name, th1_max, th2_max, th3_max, status, del_flag, create_by, create_time)
VALUES (0, 'JD00', '临川市明正司法鉴定中心核准档案', '法医临床', '江南省—临川市—城东区', 8.00, 30.00, 80.00, 0, 0, 'seed', NOW()),
       (1, 'JD01', '旧济和司法鉴定所核准档案（已注销）', '声像资料', '江南省—临川市—城西区', 8.00, 30.00, 80.00, 1, 0, 'seed', NOW());

