insert into LazyParameters (bh,nr,ms) values ('1','Y','�Ƿ�lazy����־д�����ݿ�(Y/N)');

/**********************************/
/***********    ��ɫ��Ϣ     *************/
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
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'�������Ĺ���','��˹����','!WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'HUHUHU','��˹����','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'nnoky123@gmail.com'),seq_all.nextval,'�׺��ĺ�','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'h3ufobio@163.com'),seq_all.nextval,'�S����','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'gguioption@163.com'),seq_all.nextval,'希��G','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'uiopiokio@163.com'),seq_all.nextval,'�����','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'bbiiyourbag@163.com'),seq_all.nextval,'�יr�c','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'��������','��˹����','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'ɱ������','��˹����','',3);

insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'���������','��˹����','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',1);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Welcomex','��˹����','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',2);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'�տ�','��˹����','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',3);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'����','��˹����','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',4);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'��ֻ÷','��˹����','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',7);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Other','��˹����','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Spyman','��˹����','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',1);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Onedisk','��˹����','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',2);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Tyutone','��˹����','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',3);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'��������','��˹����','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',4);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'����������','��˹����','SPYMAN1801|SPYMAN1802|TYILOVEYH|WoW1|!WoW2|',0);
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    �ʼ��б�     *************/
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','Դ�ʿ�ʯ','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','ȼ����ʯ','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����ʯ��','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��β��','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','ĺ������','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����֮��','��������');
                                                       
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','������ʯ','���������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���꾧ʯ','���������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ħ֮��','���������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��������','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�ξ����','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��������','Welcomex');
                                                       
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�������ʯ','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����','���������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�������ƾ�','���������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','������','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','ҹ֮ʯ','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����ʯ','��������');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���֮��������',   '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','������������',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���İ�������',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�����ξ����',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����֮�ξ����',   '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�𻨺�������',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���ܺ�������',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���ص�����ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���������ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ҫ������ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','���µ�����ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','Բ�����꾧ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�ط����꾧ʯ',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','������ħ֮��',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','ͳ����ħ֮��',     '�տ�');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','�����ߵĶ�ħ֮��', '�տ�');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','����֮��', '����');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','ǿЧ��羫��', '����');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ȼ����','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ȼ����','ɱ������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ȼ֮��','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ȼ֮ˮ','��������');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('��˹����','ALL','��ȼ֮��','��������');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ը���б�     *************/
insert into mine_fj (item_name) values ('Դ�ʿ�ʯ');
insert into mine_fj (item_name) values ('ȼ����ʯ');
insert into mine_fj (item_name) values ('����ʯ��');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ��ɫ������Ʒ�б�     *************/
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '���֮��������',   '��������');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '������������'  ,   '��������');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '���İ�������'  ,   '��������');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '�����ξ����'  ,   '�ξ����');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '����֮�ξ����',   '�ξ����');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '�𻨺�������'  ,   '��������');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '���ܺ�������'  ,   '��������');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'���ص�����ʯ',     '������ʯ');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'���µ�����ʯ',     '������ʯ');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'���������ʯ',     '������ʯ');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'��ҫ������ʯ',     '������ʯ');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'������ħ֮��',     '��ħ֮��');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'ͳ����ħ֮��',     '��ħ֮��');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'�����ߵĶ�ħ֮��', '��ħ֮��');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'Բ�����꾧ʯ',     '���꾧ʯ');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('���������',1,'�ط����꾧ʯ',     '���꾧ʯ');

insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_count1,need_item_name2,need_count2,disenchant) 
                  values ('���������',1,'����ָ��','����',1,'�鱦ʦ�ĵ���',1,1);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_count1,need_item_name2,need_count2,disenchant) 
                  values ('���������',1,'�������ƾ�׹��','�������ƾ�',2,'�鱦ʦ�ĵ���',1,1);


-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    �ϻ��嵥     *************/
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���ص�����ʯ',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���µ�����ʯ',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���������ʯ',2000000,3000000,8,1,0);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','��ҫ������ʯ',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','������ħ֮��',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','ͳ����ħ֮��',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','�����ߵĶ�ħ֮��',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','Բ�����꾧ʯ',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','�ط����꾧ʯ',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���֮��������',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','������������'  ,100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���İ�������'  ,100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','�����ξ����'  ,50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','����֮�ξ����',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','�𻨺�������'  ,50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���ܺ�������'  ,50000,1000000,8,1,20);

-----------------------------------------------------------------------------------------------------------------------------------


/**********************************/
/***********    ս���ļ�     *************/
insert into fight_file (roll_type,file_name) values ('��³��','��³��.xml');
insert into fight_file (roll_type,file_name) values ('��ʿ','��ʿ.xml');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ��ͼ�ļ�     *************/
insert into map_file (map_name,file_name,mine_list,herb_list) values ('�µ�ķ','�µ�ķ.xml','Դ�ʿ�$��Դ�ʿ�$ȼ������$','��β��');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('������뵺','������뵺.xml','ħ������$�������$���������','ħ��$��¶��$ɽ���$');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('̩�޿�ɭ��','̩�޿�ɭ��.xml','ħ������$�������$���������','ħ��$��ջ�$а���$ج����$');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('���Ӷ�ɽ','���Ӷ�ɽ.xml','����ʯ���','ȼ����');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('����Ͽ��','����Ͽ��.xml','�ܿ���$���ܿ���','���ٺ�$����ޣ$');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    �ƻ�����     *************/
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-10 15:11','yyyy-mm-dd hh24:mi'), 0, 23, 'Welcomex', 'FJKS', '1', 0);
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-15 6:00','yyyy-mm-dd hh24:mi'), 90, 53, '��һ', 'CJ', '1', 0);
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-15 7:45','yyyy-mm-dd hh24:mi'), 90, 54, '���', 'CJ', '1', 0);
-----------------------------------------------------------------------------------------------------------------------------------

insert into WOWZONE (Z_ID, Z_NAME) values ('4922', 'ĺ��ߵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('4815', '�¶�����֮ɭ');
insert into WOWZONE (Z_ID, Z_NAME) values ('5144', '˸�⺣��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5146', '��˿����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4080', '��������˹��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4298', '������֮�أ�Ѫɫ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('25', '��ʯɽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('41', '���С��');
insert into WOWZONE (Z_ID, Z_NAME) values ('46', 'ȼ��ƽԭ');
insert into WOWZONE (Z_ID, Z_NAME) values ('51', '����Ͽ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('139', '������֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('8', '��������');
insert into WOWZONE (Z_ID, Z_NAME) values ('28', '������֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('47', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5287', '�����Ⱥ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('5339', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('11', 'ʪ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('33', '��������');
insert into WOWZONE (Z_ID, Z_NAME) values ('45', '����ϣ�ߵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('10', 'ĺɫɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('267', 'ϣ��˹����������');
insert into WOWZONE (Z_ID, Z_NAME) values ('44', '�༹ɽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('4706', '������˹����');
insert into WOWZONE (Z_ID, Z_NAME) values ('38', '���Ī��');
insert into WOWZONE (Z_ID, Z_NAME) values ('40', '������Ұ');
insert into WOWZONE (Z_ID, Z_NAME) values ('130', '����ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3433', '�Ļ�֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('1', '��Ī��');
insert into WOWZONE (Z_ID, Z_NAME) values ('12', '������ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('85', '����˹���ֵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('1497', '�İ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('1519', '�����');
insert into WOWZONE (Z_ID, Z_NAME) values ('1537', '��¯��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3430', '����ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3487', '���³�');
insert into WOWZONE (Z_ID, Z_NAME) values ('4714', '������˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('4755', '������˹��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5095', '�ж�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5042', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4720', 'ʧ��Ⱥ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4737', '����');
insert into WOWZONE (Z_ID, Z_NAME) values ('5416', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3520', 'Ӱ�¹�');
insert into WOWZONE (Z_ID, Z_NAME) values ('3523', '��շ籩');
insert into WOWZONE (Z_ID, Z_NAME) values ('3522', '����ɽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3518', '�ɸ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('3519', '̩�޿�ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3521', '�޼�����');
insert into WOWZONE (Z_ID, Z_NAME) values ('3483', '������뵺');
insert into WOWZONE (Z_ID, Z_NAME) values ('3703', 'ɳ��˹��');
insert into WOWZONE (Z_ID, Z_NAME) values ('2817', '����ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4197', '��ӵ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('67', '�籩�ͱ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('210', '���ڱ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('4742', '��˹�Ӷ���½��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3711', '���������');
insert into WOWZONE (Z_ID, Z_NAME) values ('66', '����');
insert into WOWZONE (Z_ID, Z_NAME) values ('394', '��������');
insert into WOWZONE (Z_ID, Z_NAME) values ('65', '���ǻ�Ұ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3537', '����̦ԭ');
insert into WOWZONE (Z_ID, Z_NAME) values ('495', '����Ͽ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4395', '����Ȼ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1977', '���������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3805', '�氢��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4945', '��Դ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4950', '����ķ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('5396', '��ά��ʧ��֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5788', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5789', 'ʱ��֮ĩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('5844', 'ĺ������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5035', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5088', '��ʯ֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4809', '����¯');
insert into WOWZONE (Z_ID, Z_NAME) values ('4813', '��¡���');
insert into WOWZONE (Z_ID, Z_NAME) values ('4820', 'ӳ�����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4926', '��ʯ�ҿ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('5004', '��ϫ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('1196', '���ؼӵ�֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4100', '����˹̹��ķ');
insert into WOWZONE (Z_ID, Z_NAME) values ('4228', 'ħ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4272', '�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('4723', '�ھ�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('4264', '��ʯ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4416', '�Ŵ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4415', '����������');
insert into WOWZONE (Z_ID, Z_NAME) values ('4196', '�����¡Ҫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4494', '�������أ��Ŵ�����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4277', '��׿-��³��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4265', 'ħ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('206', '���ؼӵ³Ǳ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('2366', '��ɫ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('3848', '��ħ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4131', 'ħ��ʦƽ̨');
insert into WOWZONE (Z_ID, Z_NAME) values ('3714', '�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3715', '�����ؿ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('3789', '��Ӱ�Թ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('3791', '��̩�˴���');
insert into WOWZONE (Z_ID, Z_NAME) values ('3847', '��̬��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3849', '��Դ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('2367', '��ϣ��˹����������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3790', '�½����Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3792', '������Ĺ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3716', '�İ�����');
insert into WOWZONE (Z_ID, Z_NAME) values ('3717', 'ū��Χ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3713', '��Ѫ��¯');
insert into WOWZONE (Z_ID, Z_NAME) values ('3562', '�������ǽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1583', '��ʯ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('1584', '��ʯ��Ԩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1477', '������������');
insert into WOWZONE (Z_ID, Z_NAME) values ('2017', '˹̹��ķ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1176', '���������');
insert into WOWZONE (Z_ID, Z_NAME) values ('2557', '����֮�');
insert into WOWZONE (Z_ID, Z_NAME) values ('722', '�굶�ߵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('2057', 'ͨ��ѧԺ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1337', '�´���');
insert into WOWZONE (Z_ID, Z_NAME) values ('2100', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('491', '�굶����');
insert into WOWZONE (Z_ID, Z_NAME) values ('796', 'Ѫɫ�޵�Ժ');
insert into WOWZONE (Z_ID, Z_NAME) values ('721', 'ŵĪ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('717', '����');
insert into WOWZONE (Z_ID, Z_NAME) values ('719', '�ڰ���Ԩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('209', 'Ӱ���Ǳ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('718', '������Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1581', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('2437', 'ŭ���ѹ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('5094', '����Ѫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5334', 'ĺ�Ɽ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5600', '����������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5638', '��������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5892', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('2159', '���ݿ�ϣ�ǵĳ�Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3456', '�ɿ�����˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('4273', '�¶Ŷ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('4493', '����ʯʥ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4500', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4603', '��������ı���');
insert into WOWZONE (Z_ID, Z_NAME) values ('4722', 'ʮ�־�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('4812', '���ڱ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('4987', '����ʥ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3457', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3606', '���Ӷ���');
insert into WOWZONE (Z_ID, Z_NAME) values ('3607', '�������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3618', '��³���ĳ�Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3836', '��ɪ��ٵĳ�Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3842', '�籩Ҫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3845', '�籩Ҫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3923', '��³���ĳ�Ѩ');
insert into WOWZONE (Z_ID, Z_NAME) values ('3959', '�ڰ����');
insert into WOWZONE (Z_ID, Z_NAME) values ('4075', '̫��֮���ߵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('2677', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('2717', '�ۻ�֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('3428', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3429', '����������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5723', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('5034', '�µ�ķ');
insert into WOWZONE (Z_ID, Z_NAME) values ('616', '���Ӷ�ɽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('1377', 'ϣ����˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('490', '�����廷��ɽ');
insert into WOWZONE (Z_ID, Z_NAME) values ('618', '��Ȫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('361', '�����ɭ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('440', '������˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('400', 'ǧ��ʯ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('15', '��������');
insert into WOWZONE (Z_ID, Z_NAME) values ('357', '����˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('405', '����֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('4709', '��ƶ�֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('406', 'ʯצɽ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('331', '�ҹ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('493', '�¹��ֵ�');
insert into WOWZONE (Z_ID, Z_NAME) values ('16', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('17', '��ƶ�֮��');
insert into WOWZONE (Z_ID, Z_NAME) values ('148', '�ں���');
insert into WOWZONE (Z_ID, Z_NAME) values ('3525', '��Ѫ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('14', '��¡����');
insert into WOWZONE (Z_ID, Z_NAME) values ('141', '̩��ϣ��');
insert into WOWZONE (Z_ID, Z_NAME) values ('215', 'Ī����');
insert into WOWZONE (Z_ID, Z_NAME) values ('1638', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('1657', '������˹');
insert into WOWZONE (Z_ID, Z_NAME) values ('3524', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('3557', '������');
insert into WOWZONE (Z_ID, Z_NAME) values ('5695', '����������������');
