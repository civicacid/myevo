---------------------------------------------
-- Export file for user WOW                --
-- Created by spyman on 2012/7/2, 22:20:22 --
---------------------------------------------

spool Create_DB.log

prompt
prompt Creating table AHDATA
prompt =====================
prompt
create table WOW.AHDATA
(
  SERVER    VARCHAR2(98) not null,
  SELLER    VARCHAR2(98) not null,
  ITEM_NAME VARCHAR2(98) not null,
  PRIZE     NUMBER(8) default 0,
  SCANTIME  DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.AHDATA
  is 'ah扫描数据';
alter table WOW.AHDATA
  add constraint PK_AHDATA primary key (SERVER, SELLER, ITEM_NAME, SCANTIME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AHITEM
prompt =====================
prompt
create table WOW.AHITEM
(
  SERVER         VARCHAR2(200) not null,
  CHAR_NAME      VARCHAR2(200) not null,
  ITEM_NAME      VARCHAR2(200) not null,
  ITEM_MINPRICE  NUMBER(15) default 0 not null,
  ITEM_MAXPRICE  NUMBER(15) default 0 not null,
  ITEM_COUNT     NUMBER(8) default 0 not null,
  ITEM_STACKSIZE NUMBER(8) default 0 not null,
  BACKUP_COUNT   NUMBER(8) default 0 not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.AHITEM
  is '挂货';
alter table WOW.AHITEM
  add constraint PK_AHITEM primary key (CHAR_NAME, ITEM_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table AUTOLOGIN
prompt ========================
prompt
create table WOW.AUTOLOGIN
(
  STARTTIME DATE not null,
  RUNTIME   NUMBER(8) default 0,
  CHAR_ID   NUMBER(8) not null,
  CHAR_NAME VARCHAR2(98) not null,
  DOWHAT    VARCHAR2(200) not null,
  MACHINEID VARCHAR2(200) not null,
  EVERYDAY  NUMBER(1) default 0
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.AUTOLOGIN
  is '自动登录计划';
alter table WOW.AUTOLOGIN
  add primary key (MACHINEID, STARTTIME, CHAR_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CHARCREATION
prompt ===========================
prompt
create table WOW.CHARCREATION
(
  CHAR_NAME       VARCHAR2(98) not null,
  TRADESKILL      NUMBER(1) not null,
  ITEM_NAME       VARCHAR2(98) not null,
  NEED_ITEM_NAME1 VARCHAR2(98) not null,
  NEED_COUNT1     NUMBER(1),
  NEED_ITEM_NAME2 VARCHAR2(98),
  NEED_COUNT2     NUMBER(1),
  DISENCHANT      NUMBER(1)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.CHARCREATION
  is '人物能做什么，包括技能和可以制造什么';
comment on column WOW.CHARCREATION.TRADESKILL
  is '商业技能(1-珠宝，2-铭文，3-锻造，4-炼金，5-裁缝，6-附魔)';
alter table WOW.CHARCREATION
  add constraint PK_CHARCREATION primary key (CHAR_NAME, TRADESKILL, ITEM_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CHAR_GOLD
prompt ========================
prompt
create table WOW.CHAR_GOLD
(
  CHAR_NAME    VARCHAR2(100) not null,
  GOLD         NUMBER(16) not null,
  REFRESH_TIME DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.CHAR_GOLD
  is '人物金币数量';
comment on column WOW.CHAR_GOLD.CHAR_NAME
  is '角色名称';
comment on column WOW.CHAR_GOLD.GOLD
  is '金币';
alter table WOW.CHAR_GOLD
  add constraint PK_CHAR_GOLD primary key (CHAR_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CHAR_LIANJIN
prompt ===========================
prompt
create table WOW.CHAR_LIANJIN
(
  SERVER           VARCHAR2(100) not null,
  CHAR_NAME        VARCHAR2(100) not null,
  SKILL            VARCHAR2(10) not null,
  LIANJIN_ITEMNAME VARCHAR2(100) not null,
  DO_ORDER         NUMBER(2) default 0 not null,
  DISCHANT         NUMBER(1) default 0 not null,
  MAIL             NUMBER(1) default 0 not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.CHAR_LIANJIN
  is '炼金制作清单';
comment on column WOW.CHAR_LIANJIN.SERVER
  is '服务器';
comment on column WOW.CHAR_LIANJIN.CHAR_NAME
  is '角色';
comment on column WOW.CHAR_LIANJIN.LIANJIN_ITEMNAME
  is '技能名称';
comment on column WOW.CHAR_LIANJIN.DO_ORDER
  is '制作顺序';
comment on column WOW.CHAR_LIANJIN.DISCHANT
  is '是否分解';
comment on column WOW.CHAR_LIANJIN.MAIL
  is '是否邮寄';
alter table WOW.CHAR_LIANJIN
  add constraint PK_CHAR_LJ primary key (CHAR_NAME, LIANJIN_ITEMNAME, SKILL)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FIGHT_FILE
prompt =========================
prompt
create table WOW.FIGHT_FILE
(
  ROLL_TYPE    VARCHAR2(100) not null,
  FILE_NAME    VARCHAR2(100) not null,
  FILE_CONTEXT CLOB
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.FIGHT_FILE
  is '战斗角色文件';
alter table WOW.FIGHT_FILE
  add constraint PK_FIGHT primary key (ROLL_TYPE)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create unique index WOW.UK_FIGHT_FILE on WOW.FIGHT_FILE (FILE_NAME)
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table HIS_GOLD
prompt =======================
prompt
create table WOW.HIS_GOLD
(
  CHAR_NAME    VARCHAR2(100) not null,
  GOLD         NUMBER(16) not null,
  REFRESH_TIME DATE,
  HIS_DATE     DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ITEMS
prompt ====================
prompt
create table WOW.ITEMS
(
  ITEM_ID      VARCHAR2(10) not null,
  ITEM_NAME    VARCHAR2(98) not null,
  ITEM_QUALITY VARCHAR2(98) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.ITEMS
  is 'ÎïÆ·Êý¾Ý¿â';
alter table WOW.ITEMS
  add primary key (ITEM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ITEMSINBAG
prompt =========================
prompt
create table WOW.ITEMSINBAG
(
  ITEM_NAME      VARCHAR2(98) not null,
  CHAR_NAME      VARCHAR2(98) not null,
  ITEM_COUNT     NUMBER(8) default 0 not null,
  LAST_SCAN_TIME DATE default sysdate not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.ITEMSINBAG
  is '背包里面的东西';
alter table WOW.ITEMSINBAG
  add constraint PK_ITEMSINBAG primary key (CHAR_NAME, ITEM_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LAZYLOG
prompt ======================
prompt
create table WOW.LAZYLOG
(
  CHAR_NAME VARCHAR2(100) not null,
  LOGTEXT   VARCHAR2(1000) not null,
  LOGTIME   DATE default sysdate not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.LAZYLOG
  is '日志';

prompt
prompt Creating table LAZYPARAMETERS
prompt =============================
prompt
create table WOW.LAZYPARAMETERS
(
  BH VARCHAR2(100) not null,
  MS VARCHAR2(100) not null,
  NR VARCHAR2(1000) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.LAZYPARAMETERS
  is '配置参数';
alter table WOW.LAZYPARAMETERS
  add constraint PK_PARAM primary key (BH)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LIANJIN
prompt ======================
prompt
create table WOW.LIANJIN
(
  SKILL    VARCHAR2(10) not null,
  ITEMNAME VARCHAR2(100) not null,
  NEEDITEM VARCHAR2(1000) not null,
  HAVECD   NUMBER(1) default 0 not null,
  MEMO     VARCHAR2(200)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.LIANJIN
  is '炼金制作清单';
comment on column WOW.LIANJIN.ITEMNAME
  is '物品名称';
comment on column WOW.LIANJIN.NEEDITEM
  is '原料表。按照 Item$Count#Item$Count# 格式保存';
comment on column WOW.LIANJIN.HAVECD
  is '是否有CD';
alter table WOW.LIANJIN
  add constraint PK_LIANJIN primary key (ITEMNAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LOGGING
prompt ======================
prompt
create table WOW.LOGGING
(
  LOGTYPE VARCHAR2(100) not null,
  LOGTEXT VARCHAR2(1000) not null,
  LOGTIME DATE default sysdate not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.LOGGING
  is '日志';

prompt
prompt Creating table MAILLIST
prompt =======================
prompt
create table WOW.MAILLIST
(
  SERVER             VARCHAR2(200) not null,
  SENDER_CHAR_NAME   VARCHAR2(200) not null,
  RECEIVER_CHAR_NAME VARCHAR2(200) not null,
  ITEM_NAME          VARCHAR2(200) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.MAILLIST
  is '邮件列表';
alter table WOW.MAILLIST
  add primary key (SERVER, SENDER_CHAR_NAME, RECEIVER_CHAR_NAME, ITEM_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MAP_FILE
prompt =======================
prompt
create table WOW.MAP_FILE
(
  MAP_NAME     VARCHAR2(100) not null,
  FILE_NAME    VARCHAR2(100) not null,
  FILE_CONTEXT CLOB,
  MINE_LIST    VARCHAR2(100),
  HERB_LIST    VARCHAR2(100)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.MAP_FILE
  is '地图文件';
alter table WOW.MAP_FILE
  add constraint PK_MAP primary key (MAP_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create unique index WOW.UK_MAP_FILE on WOW.MAP_FILE (FILE_NAME)
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table MINE_FJ
prompt ======================
prompt
create table WOW.MINE_FJ
(
  ITEM_NAME VARCHAR2(200) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.MINE_FJ
  is '分矿列表';
alter table WOW.MINE_FJ
  add primary key (ITEM_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SPELLS
prompt =====================
prompt
create table WOW.SPELLS
(
  SPELL_ID   VARCHAR2(10) not null,
  SPELL_NAME VARCHAR2(98) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.SPELLS
  is '·¨ÊõÊý¾Ý¿â';
alter table WOW.SPELLS
  add primary key (SPELL_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WOWACCOUNT
prompt =========================
prompt
create table WOW.WOWACCOUNT
(
  ACC_ID   NUMBER(8) not null,
  ACC_NAME VARCHAR2(98) not null,
  ACC_PASS VARCHAR2(98) not null,
  STATUS   NUMBER(1) default 1 not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.WOWACCOUNT
  is 'ÕËºÅ';
comment on column WOW.WOWACCOUNT.STATUS
  is '×´Ì¬(1-¿ÉÓÃ£¬2-Í£ÓÃ)';
alter table WOW.WOWACCOUNT
  add primary key (ACC_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table WOW.WOWACCOUNT
  add unique (ACC_NAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WOWCHAR
prompt ======================
prompt
create table WOW.WOWCHAR
(
  CHAR_ID   NUMBER(8) not null,
  ACC_ID    NUMBER(8) not null,
  CHAR_NAME VARCHAR2(98) not null,
  SERVER    VARCHAR2(98) not null,
  ACC_LIST  VARCHAR2(98),
  CHAR_IDX  NUMBER(1) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.WOWCHAR
  is '½ÇÉ«';
alter table WOW.WOWCHAR
  add primary key (CHAR_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table WOW.WOWCHAR
  add constraint FK_ACC_ID foreign key (ACC_ID)
  references WOW.WOWACCOUNT (ACC_ID);

prompt
prompt Creating table WOWLOG
prompt =====================
prompt
create table WOW.WOWLOG
(
  CHAR_NAME VARCHAR2(100),
  LOGTYPE   VARCHAR2(100) not null,
  LOGTEXT   VARCHAR2(1000) not null,
  LOGTIME   DATE default sysdate not null,
  MACHINEID VARCHAR2(100)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table WOW.WOWLOG
  is '日志';

prompt
prompt Creating table WOWZONE
prompt ======================
prompt
create table WOW.WOWZONE
(
  Z_ID   VARCHAR2(100) not null,
  Z_NAME VARCHAR2(200)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table WOW.WOWZONE
  add constraint PK_ZONE primary key (Z_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating sequence SEQ_ALL
prompt =========================
prompt
create sequence WOW.SEQ_ALL
minvalue 1
maxvalue 999999999999999999999999999
start with 121
increment by 1
cache 20;

prompt
prompt Creating view V_LOGIN_INFO
prompt ==========================
prompt
create or replace view wow.v_login_info as
select wc.char_id,
       wc.char_name,
       wc.server,
       wc.char_idx,
       wc.acc_list,
       wa.acc_name,
       wa.acc_pass
  from WOWCHAR wc, wowaccount wa
 where wa.acc_id = wc.acc_id;

prompt
prompt Creating procedure ADD_AHINFO
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE WOW.add_ahinfo
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

prompt
prompt Creating procedure ADD_BAG
prompt ==========================
prompt
CREATE OR REPLACE PROCEDURE WOW.add_bag
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

prompt
prompt Creating procedure ADD_ITEM
prompt ===========================
prompt
CREATE OR REPLACE PROCEDURE WOW.add_item
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

prompt
prompt Creating procedure ADD_SPELL
prompt ============================
prompt
CREATE OR REPLACE PROCEDURE WOW.add_spell
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

prompt
prompt Creating procedure GOLD
prompt =======================
prompt
CREATE OR REPLACE PROCEDURE WOW.gold
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
/

prompt
prompt Creating procedure P_HIS_GOLD
prompt =============================
prompt
create or replace procedure wow.p_his_gold is
begin
  insert into his_gold
  select char_name, gold, refresh_time ,sysdate as his_date from char_gold where refresh_time > trunc(sysdate) -1 and refresh_time < trunc(sysdate); 
end ;
/


spool off
