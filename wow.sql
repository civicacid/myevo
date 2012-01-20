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
comment on column wowaccount.status is '状态(1-可用，2-停用)';

-- -----------------------------------------------------
-- table wowchar
-- -----------------------------------------------------
create table wowchar (
    char_id         number(8)       not null ,
    acc_id          number(8)       not null ,
    char_name       varchar(98)     not null ,
    server          varchar(98)     not null ,
    acc_list        varchar(98)     not null ,
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

-- -----------------------------------------------------
-- table spells
-- -----------------------------------------------------
create table spells (
    spell_id         varchar(10)     not null ,
    spell_name       varchar(98)     not null ,
    primary key (spell_id)
);
comment on table spells is '法术数据库';

-- -----------------------------------------------------
-- table ahdata
-- -----------------------------------------------------
create table ahdata (
   idahdata            number(8)                     not null ,
   item_id             varchar(10)                   not null ,
   item_name           varchar(98)                   not null ,
   bid                 number(8)          default 0  null ,
   buyout              number(8)          default 0  null,
   seller              varchar(98)                   not null ,
   scantime            date                          not null ,
   constraint pk_ahdata primary key (idahdata) ,
   constraint fk_item foreign key (item_id) references items (item_id)
);
comment on table ahdata is 'ah扫描数据';

-- -----------------------------------------------------
-- table charcreation
-- -----------------------------------------------------
create table charcreation (
   char_id             number(8)                         not null ,
   char_name           varchar(98)                       not null ,
   tradeskill          number(1)                         not null ,
   item_id             varchar(10)                       not null ,
   item_name           varchar(98)                       not null ,
   constraint pk_charcreation primary key (char_id),
   constraint fk_char_id foreign key (char_id) references wowchar(char_id),
   constraint fk_item_id foreign key (item_id) references items(item_id)
);
comment on table charcreation is '人物能做什么，包括技能和可以制造什么';
comment on column charcreation.tradeskill is '商业技能(1-珠宝，2-铭文，3-锻造，4-炼金，5-裁缝)';


-- -----------------------------------------------------
-- table itemsinbag
-- -----------------------------------------------------
create table itemsinbag (
   item_id                       varchar(10)                      not null ,
   item_name                     varchar(98)                      not null ,
   char_id                       number(8)                        not null ,
   char_name                     varchar(98)                      not null ,
   item_count                    number(8)      default 0         not null ,
   last_scan_time                date           default sysdate   not null ,
   constraint pk_itemsinbag primary key (item_id) ,
   constraint fk_itemsinbag_item_id foreign key (item_id) references items (item_id) ,
   constraint fk_itemsinbag_char_id foreign key (char_id) references wowchar (char_id)
);
comment on table itemsinbag is '背包里面的东西';

-- -----------------------------------------------------
-- table AHItemGroup 挂货组
-- -----------------------------------------------------
create table ahitemgroup (
   group_id                      number(8)                        not null,
   item_id                       varchar(10)                      not null,
   item_name                     varchar(200)                     not null,
   item_minprice                 number(15)        default 0      not null,            -- 每个物品的最低价格
   item_maxprice                 number(15)        default 0      not null,            -- 每个物品的最高价格
   item_count                    number(8)         default 0      not null,            -- 一次挂几堆
   item_stacksize                number(8)         default 0      not null,            -- 每一堆物品的数量
   constraint pk_ahitemgroup primary key (group_id, item_id),
   constraint fk_ahitemgroup_item_id foreign key (item_id) references items (item_id)
);
comment on table ahitemgroup is '挂货组';

-- -----------------------------------------------------
-- table charahitem 角色挂货计划
-- -----------------------------------------------------
create table ahplan (
   char_id                       number(8)                           not null,            --角色ID
   char_name                     varchar(98)                         not null ,
   group_id                      number(8)                           not null,            --挂货组ID
   begin_time                    date              default sysdate   not null,            --开始时间
   end_time                      date,                                                    --结束时间
   constraint pk_charahitem primary key(char_id, group_id),
   constraint fk_charahitem_char_id foreign key(char_id) references wowchar(char_id)
);
comment on table ahplan is '角色挂货计划';

-- -----------------------------------------------------
-- table autologin 自动登录计划
-- -----------------------------------------------------
create table autologin (
   autologin_id               number(8)          not null,
   worktime                   date               not null,     -- 启动时间
   downtime                   date               not null,     -- 结束时间
   char_id                    number(8)          not null,
   char_name                  varchar(98)        not null,
   dowhat                     varchar(200)       not null,     -- worktype#work_id$worktype#work_id$
   primary key (autologin_id),
   constraint fk_autologin_char_id foreign key (char_id) references wowchar (char_id)
);
comment on table autologin is '自动登录计划';

-- -----------------------------------------------------
-- table autowork_diag_mine  自动挖矿
-- -----------------------------------------------------
create table autowork_diag_mine (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   profile                    varchar(200)       not null,
   behavior                   varchar(200)       not null,
   primary key (work_id)
);
comment on table autologin is '自动挖矿';

-- -----------------------------------------------------
-- table autowork_maillist  邮件列表
-- -----------------------------------------------------
create table autowork_maillist (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   item_id                    varchar(200)       not null,
   char_id                    number(8)          not null,
   primary key (work_id)
);
comment on table autowork_maillist is '邮件列表';

-- -----------------------------------------------------
-- table autowork_mine  分矿列表
-- -----------------------------------------------------
create table autowork_mine (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   item_id                    varchar(200)       not null,
   primary key (work_id)
);
comment on table autowork_mine is '分矿列表';

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
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'ctais2k@sina.cn','ctais!1@2oracle',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'spyman1802@gmail.com','2008bjsat',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'stefani_wang@163.com','wow1!1erwin81',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'spyman1802@hotmail.com','17tyvdf45',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'rubyfly9@gmail.com','17tyvdf44',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'nnoky123@gmail.com','18tyvdf14',1);

insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'h3ufobio@163.com','h38g9km19',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'gguioption@163.com','k9killones76',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'uiopiokio@163.com','b98m!@jil(u',1);
insert into wowaccount(acc_id,acc_name,acc_pass,status) values(seq_all.nextval,'bbiiyourbag@163.com','jj33kk**ll111',1);

insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'ctais2k@sina.cn'),seq_all.nextval,'亣眔龘','爱斯特纳','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@hotmail.com'),seq_all.nextval,'鹤鹤六号','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'鹤鹤五号','爱斯特纳','!WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'HUHUHU','爱斯特纳','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'nnoky123@gmail.com'),seq_all.nextval,'鹤鹤四号','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'h3ufobio@163.com'),seq_all.nextval,'奡寗燊','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'gguioption@163.com'),seq_all.nextval,'甯寗翯','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'uiopiokio@163.com'),seq_all.nextval,'掱淼麤','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'bbiiyourbag@163.com'),seq_all.nextval,'曌檙芻','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'爱贝贝熊','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'杀贝贝熊','爱斯特纳','',3);
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
   v_i_char_id INTEGER;
   v_i_item_id INTEGER;
BEGIN
   SELECT char_id
     INTO v_i_char_id
     FROM wowchar
    WHERE char_name = p_char_name;
   SELECT item_id
     INTO v_i_item_id
     FROM items
    WHERE item_name = p_item_name;
   INSERT INTO itemsinbag
      (item_id,
       item_name,
       char_id,
       char_name,
       item_count)
   VALUES
      (v_i_char_id,
       p_char_name,
       v_i_item_id,
       p_item_name,
       p_item_count);
   COMMIT;
END;
/