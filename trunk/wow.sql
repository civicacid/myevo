 create schema if not exists wow;
use wow;

-- -----------------------------------------------------
-- table wowaccount
-- -----------------------------------------------------
create table if not exists wowaccount (
    acc_id          int(11)         not null auto_increment ,
    acc_name        varchar(98)     not null ,
    acc_pass        varchar(98)     not null ,
    status          int(1)          not null default '1' comment '1-可用，2-停用' ,
    primary key (acc_id) ,
    unique index acc_name_unique (acc_name asc)
)
comment = 'wow账号';

-- -----------------------------------------------------
-- table wowchar
-- -----------------------------------------------------
create table if not exists wowchar (
    char_id         int(11)         not null auto_increment ,
    acc_id          int(11)         not null ,
    char_name       varchar(98)     not null ,
    server          varchar(98)     not null ,
    acc_list        varchar(98)     not null ,
    char_idx        int(11)         not null ,
    primary key (char_id) ,
    constraint fk_acc_id foreign key (acc_id ) references wowaccount (acc_id)
)
comment = 'wow角色';

-- -----------------------------------------------------
-- table items
-- -----------------------------------------------------
create table if not exists items (
    item_id         varchar(10)     not null ,
    item_name       varchar(98)     not null ,
    item_quality    varchar(98)     not null ,
    primary key (item_id)
)
comment = '物品数据库';

-- -----------------------------------------------------
-- table ahdata
-- -----------------------------------------------------
create table if not exists ahdata (
    idahdata        int(11)         not null auto_increment,
    item_id         varchar(10)     not null ,
    bid             int(11)         not null,
    buyout          int(11)         null,
    seller          varchar(98)     not null ,
    scantime        datetime        not null ,
    primary key (idahdata) ,
    constraint fk_item foreign key (item_id) references items (item_id)
)
comment = 'ah扫描数据';

-- -----------------------------------------------------
-- table charcreation
-- -----------------------------------------------------
create table if not exists charcreation (
    char_id         int(11)         not null ,
    tradeskill      int(1)          not null comment '1-珠宝，2-铭文，3-锻造，4-炼金，5-裁缝' ,
    item_id         varchar(10)     not null ,
    primary key (char_id)
)
comment = '人物能做什么，包括技能和可以制造什么。';


-- -----------------------------------------------------
-- table itemsinbag
-- -----------------------------------------------------
create table if not exists itemsinbag (
    item_id         varchar(10)     not null ,
    char_id         int(11)         not null ,
    item_count      int(11)         not null ,
    last_scan_time  datetime        not null ,
    primary key (item_id) ,
    constraint fk_item_id foreign key (item_id) references items (item_id) ,
    constraint fk_char_id foreign key (char_id) references wowchar (char_id)
)
comment = '背包里面的东西';

-- -----------------------------------------------------
-- table charahitem 角色挂货计划
-- -----------------------------------------------------
-- create table if not exists charahitem (
--    plan_id         int(11)         not null,
--    status          int(1)          not null default '1' comment '1-可用，2-不可用',
--    begin_time,
--    end_time,
--    group_id,
--)
-- comment = '角色挂货计划';
--
-- -----------------------------------------------------
-- table autologin 自动登录计划
-- -----------------------------------------------------
create table if not exists autologin (
    autologin_id    int(11)         not null auto_increment,
    starttime       datetime        not null,
    endtime         datetime        not null,
    char_id         int(11)         not null,
    profile         varchar(200)    not null,
    behavior        varchar(200)    not null,
    primary key (autologin_id),
    constraint fk_char_id foreign key (char_id) references wowchar (char_id)
)
comment = '自动登录计划';








-----------------------------------------------------------------------------------------------------------------------------------
insert into wowaccount(acc_name,acc_pass,acc_list,status) values('ctais2k@sina.cn','ctais!1@2oracle',1);
insert into wowaccount(acc_name,acc_pass,acc_list,status) values('spyman1802@gmail.com','2008bjsat',1);
insert into wowaccount(acc_name,acc_pass,acc_list,status) values('stefani_wang@163.com','wow1!1erwin81',1);

insert into wowchar(acc_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name like 'cta%'),'亣眔龘','爱斯特纳','WoW1|!WoW2|',0)

insert into 