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

create table spells (
    SPELL_ID         varchar(10)     not null ,
    SPELL_NAME       varchar(98)     not null ,
    primary key (SPELL_ID)
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
   char_name           varchar(98)                       not null ,
   tradeskill          number(1)                         not null ,
   item_name           varchar(98)                       not null ,
   need_item_name1     varchar(98)                       not null ,
   need_item_name2     varchar(98)                       null ,
   constraint pk_charcreation primary key (char_name,tradeskill,item_name)
);
comment on table charcreation is '��������ʲô���������ܺͿ�������ʲô';
comment on column charcreation.tradeskill is '��ҵ����(1-�鱦��2-���ģ�3-���죬4-����5-�÷죬6-��ħ)';


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
-- table maillist  �ʼ��б�
-- -----------------------------------------------------
create table maillist (
   server                     varchar(200)       not null,
   sender_char_name           varchar(200)       not null,              --�ļ��ˣ�ALL�������ڸ÷�������ȫ����ɫ��
   receiver_char_name         varchar(200)       not null,              --�ռ���
   item_name                  varchar(200)       not null,   
   primary key (server,sender_char_name,receiver_char_name,item_name)
);
comment on table maillist is '�ʼ��б�';

-- -----------------------------------------------------
-- table mine_fj  �ֿ��б�
-- -----------------------------------------------------
create table mine_fj (
   item_name                    varchar(200)       not null,
   primary key (item_name)
);
comment on table mine_fj is '�ֿ��б�';

-- -----------------------------------------------------
-- table ahitem �һ�
-- -----------------------------------------------------
create table ahitem (
   server                        varchar(200)                     not null,
   char_name                     varchar(200)                     not null,
   item_name                     varchar(200)                     not null,
   item_minprice                 number(15)        default 0      not null,            -- ÿ����Ʒ����ͼ۸�
   item_maxprice                 number(15)        default 0      not null,            -- ÿ����Ʒ����߼۸�
   item_count                    number(8)         default 0      not null,            -- һ�ιҼ���
   item_stacksize                number(8)         default 0      not null,            -- ÿһ����Ʒ������
   backup_count                  number(8)         default 0      not null,            -- ��������
   constraint pk_ahitem primary key (char_name, item_name)
);
comment on table ahitem is '�һ�';

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



welcomex
 ��ɫ��
 [�鱦�ӹ�: ���֮��������]		+20���� +20��ͨ		59
 [�鱦�ӹ�: ������������]		+20���� +20��ͨ		72
 [�鱦�ӹ�: ���İ�������]		+20���� +20����		72
 ��ɫ��
 [�鱦�ӹ�: �����ξ����]		+20���� +30����		70
 [�鱦�ӹ�: ����֮�ξ����]		+20��ͨ +20����		40
 ��ɫ��
 [�鱦�ӹ�: �𻨺�������]		+30����			80
 [�鱦�ӹ�: ���ܺ�������]		+60����			40

���������
 ��ɫ��
 [�鱦�ӹ�: ���ص�����ʯ]		+40����
 [�鱦�ӹ�: ���������ʯ]		+40�м�
 [�鱦�ӹ�: ��ҫ������ʯ]		+40����
 
 ��ɫ��
 [�鱦�ӹ�: Բ�����꾧ʯ]
 [�鱦�ӹ����ط����꾧ʯ]
 
 ��ɫ��
 [�鱦�ӹ�: ������ħ֮��]		+20���� +20��ͨ
 [�鱦�ӹ�: ͳ����ħ֮��]		+20���� +30����
 [�鱦�ӹ�: �����ߵĶ�ħ֮��]		+20�м� +30����