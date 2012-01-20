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
comment on table wowaccount is '�˺�';
comment on column wowaccount.status is '״̬(1-���ã�2-ͣ��)';

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
comment on table wowchar is '��ɫ';

-- -----------------------------------------------------
-- table items
-- -----------------------------------------------------
create table items (
    item_id         varchar(10)     not null ,
    item_name       varchar(98)     not null ,
    item_quality    varchar(98)     not null ,
    primary key (item_id)
);
comment on table items is '��Ʒ���ݿ�';

-- -----------------------------------------------------
-- table spells
-- -----------------------------------------------------
create table spells (
    spell_id         varchar(10)     not null ,
    spell_name       varchar(98)     not null ,
    primary key (spell_id)
);
comment on table spells is '�������ݿ�';

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
comment on table ahdata is 'ahɨ������';

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
comment on table charcreation is '��������ʲô���������ܺͿ�������ʲô';
comment on column charcreation.tradeskill is '��ҵ����(1-�鱦��2-���ģ�3-���죬4-����5-�÷�)';


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
comment on table itemsinbag is '��������Ķ���';

-- -----------------------------------------------------
-- table AHItemGroup �һ���
-- -----------------------------------------------------
create table ahitemgroup (
   group_id                      number(8)                        not null,
   item_id                       varchar(10)                      not null,
   item_name                     varchar(200)                     not null,
   item_minprice                 number(15)        default 0      not null,            -- ÿ����Ʒ����ͼ۸�
   item_maxprice                 number(15)        default 0      not null,            -- ÿ����Ʒ����߼۸�
   item_count                    number(8)         default 0      not null,            -- һ�ιҼ���
   item_stacksize                number(8)         default 0      not null,            -- ÿһ����Ʒ������
   constraint pk_ahitemgroup primary key (group_id, item_id),
   constraint fk_ahitemgroup_item_id foreign key (item_id) references items (item_id)
);
comment on table ahitemgroup is '�һ���';

-- -----------------------------------------------------
-- table charahitem ��ɫ�һ��ƻ�
-- -----------------------------------------------------
create table ahplan (
   char_id                       number(8)                           not null,            --��ɫID
   char_name                     varchar(98)                         not null ,
   group_id                      number(8)                           not null,            --�һ���ID
   begin_time                    date              default sysdate   not null,            --��ʼʱ��
   end_time                      date,                                                    --����ʱ��
   constraint pk_charahitem primary key(char_id, group_id),
   constraint fk_charahitem_char_id foreign key(char_id) references wowchar(char_id)
);
comment on table ahplan is '��ɫ�һ��ƻ�';

-- -----------------------------------------------------
-- table autologin �Զ���¼�ƻ�
-- -----------------------------------------------------
create table autologin (
   autologin_id               number(8)          not null,
   worktime                   date               not null,     -- ����ʱ��
   downtime                   date               not null,     -- ����ʱ��
   char_id                    number(8)          not null,
   char_name                  varchar(98)        not null,
   dowhat                     varchar(200)       not null,     -- worktype#work_id$worktype#work_id$
   primary key (autologin_id),
   constraint fk_autologin_char_id foreign key (char_id) references wowchar (char_id)
);
comment on table autologin is '�Զ���¼�ƻ�';

-- -----------------------------------------------------
-- table autowork_diag_mine  �Զ��ڿ�
-- -----------------------------------------------------
create table autowork_diag_mine (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   profile                    varchar(200)       not null,
   behavior                   varchar(200)       not null,
   primary key (work_id)
);
comment on table autologin is '�Զ��ڿ�';

-- -----------------------------------------------------
-- table autowork_maillist  �ʼ��б�
-- -----------------------------------------------------
create table autowork_maillist (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   item_id                    varchar(200)       not null,
   char_id                    number(8)          not null,
   primary key (work_id)
);
comment on table autowork_maillist is '�ʼ��б�';

-- -----------------------------------------------------
-- table autowork_mine  �ֿ��б�
-- -----------------------------------------------------
create table autowork_mine (
   work_id                    number(8)          not null,
   work_desc                  varchar(200)       not null,
   item_id                    varchar(200)       not null,
   primary key (work_id)
);
comment on table autowork_mine is '�ֿ��б�';

-- -----------------------------------------------------
-- Sequence ��������
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

insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'ctais2k@sina.cn'),seq_all.nextval,'���o��','��˹����','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@hotmail.com'),seq_all.nextval,'�׺�����','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'�׺����','��˹����','!WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'HUHUHU','��˹����','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'nnoky123@gmail.com'),seq_all.nextval,'�׺��ĺ�','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'h3ufobio@163.com'),seq_all.nextval,'�S����','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'gguioption@163.com'),seq_all.nextval,'希��G','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'uiopiokio@163.com'),seq_all.nextval,'�����','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'bbiiyourbag@163.com'),seq_all.nextval,'�יr�c','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'��������','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'ɱ������','��˹����','',3);
-----------------------------------------------------------------------------------------------------------------------------------
-- �����Ʒ
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
-- ���ħ��
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
-- ��ӱ���
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