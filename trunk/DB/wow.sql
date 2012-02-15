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
    acc_list        varchar(98)     null ,
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
comment on table ahdata is 'ahɨ������';

-- -----------------------------------------------------
-- table charcreation
-- -----------------------------------------------------
create table charcreation (
   char_name           varchar(98)                       not null ,
   tradeskill          number(1)                         not null ,
   item_name           varchar(98)                       not null ,        -- ������Ʒ����
   need_item_name1     varchar(98)                       not null ,        -- ԭ��һ
   need_count1         number(1)                         null ,            -- ��Ҫ��ԭ������
   need_item_name2     varchar(98)                       null ,            -- ԭ�϶�
   need_count2         number(1)                         null ,            -- ��Ҫ��ԭ������
   disenchant          number(1)                         null ,            -- �Ƿ�ֽ�
   constraint pk_charcreation primary key (char_name,tradeskill,item_name)
);
comment on table charcreation is '��������ʲô���������ܺͿ�������ʲô';
comment on column charcreation.tradeskill is '��ҵ����(1-�鱦��2-���ģ�3-���죬4-����5-�÷죬6-��ħ)';


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
comment on table itemsinbag is '��������Ķ���';

-- -----------------------------------------------------
-- table autologin �Զ���¼�ƻ�
-- -----------------------------------------------------
create table autologin (
   starttime                  date               not null,                 -- ����ʱ��
   runtime                    number(8)          default 0 null,           -- ����ʱ�䣬����
   char_id                    number(8)          not null,
   char_name                  varchar(98)        null,
   dowhat                     varchar(200)       not null,                 -- CJ|ZBJG|AH|FJKS  (�ɼ�|�鱦�ӹ�|AH����|�ֽ��ʯ)
   machineid                  varchar(200)       not null,                 -- ������ʾ
   everyday                   number(1)          default 0 null,           -- �Ƿ�ÿ��ִ��(1--��,0--��)
   primary key (machineid,starttime,char_name)
);
comment on table autologin is '�Զ���¼�ƻ�';

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
-- table wowlog ��־
-- -----------------------------------------------------
create table wowlog (
   logtype                       varchar(100)                        not null,
   logtext                       varchar(1000)                       not null,
   logtime                       date              default sysdate   not null
);
comment on table wowlog is '��־';

-- -----------------------------------------------------
-- table lazylog ��־
-- -----------------------------------------------------
create table lazylog (
   char_name                     varchar(100)                        not null,
   logtext                       varchar(1000)                       not null,
   logtime                       date              default sysdate   not null
);
comment on table lazylog is '��־';

-- -----------------------------------------------------
-- table LazyParameters ����
-- -----------------------------------------------------
create table lazyparameters (
   bh                     varchar(100)                        not null,
   ms                     varchar(100)                        not null,
   nr                     varchar(1000)                       not null,
   constraint pk_param primary key (bh)
);
comment on table lazyparameters is '���ò���';


-- -----------------------------------------------------
-- table fight_file  ս����ɫ�ļ�
-- -----------------------------------------------------
create table fight_file (
   roll_type               varchar(100)            not null,
   file_name               varchar(100)            not null,
   file_context            clob                    null,
   constraint pk_fight primary key (roll_type)
);
create unique index uk_fight_file on fight_file(file_name);
comment on table fight_file is 'ս����ɫ�ļ�';

-- -----------------------------------------------------
-- table map_file  ��ͼ�ļ�
-- -----------------------------------------------------
create table map_file (
   map_name                varchar(100)            not null,
   file_name               varchar(100)            not null,
   file_context            clob                    null,
   mine_list               varchar(100)            null,                         -- �ɿ��б���$�ָ�
   herb_list               varchar(100)            null,                         -- ��ҩ�б���$�ָ�
   constraint pk_map primary key (map_name)
);
create unique index uk_map_file on map_file(file_name);
comment on table map_file is '��ͼ�ļ�';

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