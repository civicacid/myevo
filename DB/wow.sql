-- -----------------------------------------------------
-- table wowaccount 
-- -----------------------------------------------------
create table wowaccount (
    acc_id          number(8)       not null ,
    acc_name        varchar(98)     not null ,
    acc_pass        varchar(98)     not null ,
    status          number(1)       default 1   not null ,
    primary key (acc_id) ,
    unique (acc_name)
);
comment on table wowaccount is '账号';
comment on column wowaccount.acc_id is '账号ID';
comment on column wowaccount.acc_name is '战网邮箱名';
comment on column wowaccount.acc_pass is '战网密码';
comment on column wowaccount.status is '状态(1-可用，2-停用)';

-- -----------------------------------------------------
-- table wowchar
-- -----------------------------------------------------
create table wowchar (
    char_id         number(8)       not null ,
    acc_id          number(8)       not null ,
    char_name       varchar(98)     not null ,
    server          varchar(98)     not null ,
    acc_list        varchar(98)     null ,
    char_idx        number(1)       not null ,
    primary key (char_id) ,
    constraint fk_acc_id foreign key (acc_id ) references wowaccount (acc_id)
);
comment on table wowchar is '角色';

-- -----------------------------------------------------
-- table items
-- -----------------------------------------------------
create table items (
    item_id         varchar(10)     not null ,
    item_name       varchar(98)     not null ,
    item_quality    varchar(98)     not null ,
    primary key (item_id)
);
comment on table items is '物品数据库';

create table spells (
    SPELL_ID         varchar(10)     not null ,
    SPELL_NAME       varchar(98)     not null ,
    primary key (SPELL_ID)
);
comment on table spells is '法术数据库';

create table wowzone (z_id varchar(100),z_name varchar(200), constraint pk_zone primary key (z_id));

-- -----------------------------------------------------
-- table ahdata
-- -----------------------------------------------------
create table ahdata (
   server               varchar(98)                   not null ,
   seller               varchar(98)                   not null ,
   item_name            varchar(98)                   not null ,
   prize                number(8)          default 0  null,
   scantime             date                          not null ,
   constraint pk_ahdata primary key (server,seller,item_name,scantime)
);
comment on table ahdata is 'ah扫描数据';

-- -----------------------------------------------------
-- table charcreation
-- -----------------------------------------------------
create table charcreation (
   char_name           varchar(98)                       not null ,
   tradeskill          number(1)                         not null ,
   item_name           varchar(98)                       not null ,        -- 做成物品名称
   need_item_name1     varchar(98)                       not null ,        -- 原料一
   need_count1         number(1)                         null ,            -- 需要的原料数量
   need_item_name2     varchar(98)                       null ,            -- 原料二
   need_count2         number(1)                         null ,            -- 需要的原料数量
   disenchant          number(1)                         null ,            -- 是否分解
   constraint pk_charcreation primary key (char_name,tradeskill,item_name)
);
comment on table charcreation is '人物能做什么，包括技能和可以制造什么';
comment on column charcreation.tradeskill is '商业技能(1-珠宝，2-铭文，3-锻造，4-炼金，5-裁缝，6-附魔)';


-- -----------------------------------------------------
-- table itemsinbag
-- -----------------------------------------------------
create table itemsinbag (
   item_name                     varchar(98)                      not null ,
   char_name                     varchar(98)                      not null ,
   item_count                    number(8)      default 0         not null ,
   last_scan_time                date           default sysdate   not null ,
   constraint pk_itemsinbag primary key (char_name, item_name)
);
comment on table itemsinbag is '背包里面的东西';

-- -----------------------------------------------------
-- table autologin 自动登录计划
-- -----------------------------------------------------
create table autologin (
   starttime                  date               not null,                 -- 启动时间
   runtime                    number(8)          default 0 null,           -- 持续时间，分钟
   char_id                    number(8)          not null,
   char_name                  varchar(98)        null,
   dowhat                     varchar(200)       not null,                 -- CJ|ZBJG|AH|FJKS|LJ  (采集|珠宝加工|AH拍卖|分解矿石|炼金)
   machineid                  varchar(200)       not null,                 -- 机器标示
   everyday                   number(1)          default 0 null,           -- 是否每天执行(1--是,0--否)
   primary key (machineid,starttime,char_name)
);
comment on table autologin is '自动登录计划';

-- -----------------------------------------------------
-- table maillist  邮件列表
-- -----------------------------------------------------
create table maillist (
   server                     varchar(200)       not null,
   sender_char_name           varchar(200)       not null,              --寄件人（ALL，适用于该服务器的全部角色）
   receiver_char_name         varchar(200)       not null,              --收件人
   item_name                  varchar(200)       not null,   
   primary key (server,sender_char_name,receiver_char_name,item_name)
);
comment on table maillist is '邮件列表';

-- -----------------------------------------------------
-- table mine_fj  分矿列表
-- -----------------------------------------------------
create table mine_fj (
   item_name                    varchar(200)       not null,
   primary key (item_name)
);
comment on table mine_fj is '分矿列表';

-- -----------------------------------------------------
-- table ahitem 挂货
-- -----------------------------------------------------
create table ahitem (
   server                        varchar(200)                     not null,
   char_name                     varchar(200)                     not null,
   item_name                     varchar(200)                     not null,
   item_minprice                 number(15)        default 0      not null,            -- 每个物品的最低价格
   item_maxprice                 number(15)        default 0      not null,            -- 每个物品的最高价格
   item_count                    number(8)         default 0      not null,            -- 一次挂几堆
   item_stacksize                number(8)         default 0      not null,            -- 每一堆物品的数量
   backup_count                  number(8)         default 0      not null,            -- 备货数量
   constraint pk_ahitem primary key (char_name, item_name)
);
comment on table ahitem is '挂货';

-- -----------------------------------------------------
-- table wowlog 日志
-- -----------------------------------------------------
create table wowlog (
   char_name                     varchar(100)                        null,
   machineid                     varchar(100)                        null,
   logtype                       varchar(100)                        not null,
   logtext                       varchar(1000)                       not null,
   logtime                       date              default sysdate   not null
);
comment on table wowlog is '日志';

-- -----------------------------------------------------
-- table lazylog 日志
-- -----------------------------------------------------
create table lazylog (
   char_name                     varchar(100)                        not null,
   logtext                       varchar(1000)                       not null,
   logtime                       date              default sysdate   not null
);
comment on table lazylog is '日志';

-- -----------------------------------------------------
-- table LazyParameters 配置
-- -----------------------------------------------------
create table lazyparameters (
   bh                     varchar(100)                        not null,
   ms                     varchar(100)                        not null,
   nr                     varchar(1000)                       not null,
   constraint pk_param primary key (bh)
);
comment on table lazyparameters is '配置参数';


-- -----------------------------------------------------
-- table fight_file  战斗角色文件
-- -----------------------------------------------------
create table fight_file (
   roll_type               varchar(100)            not null,
   file_name               varchar(100)            not null,
   file_context            clob                    null,
   constraint pk_fight primary key (roll_type)
);
create unique index uk_fight_file on fight_file(file_name);
comment on table fight_file is '战斗角色文件';

-- -----------------------------------------------------
-- table map_file  地图文件
-- -----------------------------------------------------
create table map_file (
   map_name                varchar(100)            not null,
   file_name               varchar(100)            not null,
   file_context            clob                    null,
   mine_list               varchar(100)            null,                         -- 采矿列表，用$分割
   herb_list               varchar(100)            null,                         -- 采药列表，用$分割
   constraint pk_map primary key (map_name)
);
create unique index uk_map_file on map_file(file_name);
comment on table map_file is '地图文件';

-- -----------------------------------------------------
-- table LianJin  炼金制作清单
-- -----------------------------------------------------
create table lianjin (
   skill                varchar(10)                      not null,            -- 技能种类（炼金LJ、裁缝CF、MW铭文）
   itemname             varchar(100)                     not null,
   needitem             varchar(1000)                    not null,
   havecd               number(1)         default 0      not null,            -- 是否有CD
   memo                 varchar(1000)                    null,                -- 备注
   constraint pk_lianjin primary key (itemname)
);
comment on table lianjin is '炼金制作清单';
comment on column lianjin.skill     is '商业技能（炼金LJ、裁缝CF、MW铭文）';
comment on column lianjin.itemname  is '物品名称';
comment on column lianjin.needitem  is '原料表。按照 Item$Count#Item$Count# 格式保存';
comment on column lianjin.havecd    is '是否有CD';
comment on column lianjin.memo      is '备注';

-- -----------------------------------------------------
-- table char_lianjin  人物炼金技能对应表
-- -----------------------------------------------------
create table char_lianjin (
   server            varchar(100)                     not null,
   char_name         varchar(100)                     not null,
   skill             varchar(10)                      not null,            -- 技能种类（炼金LJ、裁缝CF）
   lianjin_itemname  varchar(100)                     not null,
   do_order          number(2)         default 0      not null,            -- 制作顺序
   dischant          number(1)         default 0      not null,            -- 是否分解
   mail              number(1)         default 0      not null,            -- 是否邮寄(0-不邮寄，1-邮寄)
   constraint pk_char_lj primary key (char_name,lianjin_itemname)
);
comment on table char_lianjin is '炼金制作清单';
comment on column char_lianjin.server            is '服务器';
comment on column char_lianjin.char_name         is '角色';
comment on column char_lianjin.lianjin_itemname  is '技能名称';
comment on column char_lianjin.do_order          is '制作顺序';
comment on column char_lianjin.dischant          is '是否分解';
comment on column char_lianjin.mail              is '是否邮寄';

-- -----------------------------------------------------
-- table char_gold  人物金币数量
-- -----------------------------------------------------
create table char_gold (
   char_name         varchar(100)                       not null,           -- 角色名称
   gold              number(16)                         not null,           -- 金币
   refresh_time      date                               null,               -- 刷新时间
   constraint pk_char_gold primary key (char_name)
);
comment on table char_gold is '人物金币数量';
comment on column char_gold.char_name is '角色名称';
comment on column char_gold.gold is '金币';
comment on column char_gold.refresh_time is '刷新时间';

-- -----------------------------------------------------
-- Sequence 公用序列
-- -----------------------------------------------------
create sequence seq_all;


create view v_login_info as
select wc.char_id,
       wc.char_name,
       wc.server,
       wc.char_idx,
       wc.acc_list,
       wa.acc_name,
       wa.acc_pass
  from WOWCHAR wc, wowaccount wa
 where wa.acc_id = wc.acc_id;



-----------------------------------------------------------------------------------------------------------------------------------
-- 添加物品
CREATE OR REPLACE PROCEDURE add_item
(
   p_item_id   STRING,
   p_item_name STRING,
   p_item_q    STRING
) IS
   v_count INTEGER;
BEGIN
   SELECT COUNT(1)
     INTO v_count
     FROM dual
    WHERE EXISTS (SELECT 1 FROM items WHERE item_id = p_item_id);
   IF v_count = 0 THEN
      INSERT INTO items
         (item_id,
          item_name,
          item_quality)
      VALUES
         (p_item_id,
          p_item_name,
          p_item_q);
   ELSE
      UPDATE items
         SET item_name    = p_item_name,
             item_quality = p_item_q
       WHERE item_id = p_item_id;
   END IF;
   commit;
END;
/
-- 添加魔法
CREATE OR REPLACE PROCEDURE add_spell
(
   p_spell_id   STRING,
   p_spell_name STRING
) IS
   v_count INTEGER;
BEGIN
   SELECT COUNT(1)
     INTO v_count
     FROM dual
    WHERE EXISTS (SELECT 1 FROM spells WHERE spell_id = p_spell_id);
   IF v_count = 0 THEN
      INSERT INTO spells
         (spell_id,
          spell_name)
      VALUES
         (p_spell_id,
          p_spell_name);
   ELSE
      UPDATE spells
         SET spell_name = p_spell_name
       WHERE spell_id = p_spell_id;
   END IF;
   COMMIT;
END add_spell;
/
-- 添加背包
CREATE OR REPLACE PROCEDURE add_bag
(
   p_char_name  STRING,
   p_item_name  STRING,
   p_item_count INTEGER
) IS
   v_i_count INTEGER;
BEGIN
   SELECT COUNT(*)
     INTO v_i_count
     FROM itemsinbag
    WHERE item_name = p_item_name
      AND char_name = p_char_name;
   IF v_i_count = 0 THEN
      INSERT INTO itemsinbag
         (char_name,
          item_name,
          item_count)
      VALUES
         (p_char_name,
          p_item_name,
          p_item_count);
   ELSE
      UPDATE itemsinbag
         SET item_count     = p_item_count,
             last_scan_time = SYSDATE
       WHERE item_name = p_item_name
         AND char_name = p_char_name;
   END IF;
   COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE add_ahinfo
(
   p_char_name   STRING,
   p_seller_name STRING,
   p_item_name   STRING,
   p_item_prize  INTEGER
) IS
   v_vc_server VARCHAR(100);
BEGIN
   SELECT server
     INTO v_vc_server
     FROM wowchar
    WHERE char_name = p_char_name;
   IF v_vc_server IS NULL THEN
      v_vc_server := 'UNKNOW';
   END IF;

   INSERT INTO ahdata
      (server,
       seller,
       item_name,
       prize,
       scantime)
   VALUES
      (v_vc_server,
       p_seller_name,
       p_item_name,
       p_item_prize,
       SYSDATE);

   COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE gold
(
   p_char_name      STRING,
   p_gold           INTEGER
) IS
   v_i_count        integer;
BEGIN

    select count(*) into v_i_count from char_gold where char_name = p_char_name;
    if v_i_count > 0 then
        update char_gold set gold = p_gold,refresh_time=sysdate where char_name = p_char_name;
    else
        insert into char_gold (char_name, gold, refresh_time) values (p_char_name, p_gold, sysdate);
    end if;
   COMMIT;
END;
