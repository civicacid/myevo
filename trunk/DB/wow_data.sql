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
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'uiopiokio@163.com'),seq_all.nextval,'������','��˹����','',0);
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
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','Դ�ʿ�ʯ','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','ȼ����ʯ','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','����ʯ��','welcomex');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','������ʯ','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���꾧ʯ','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','��ħ֮��','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','��������','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�ξ����','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','��������','welcomex');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�������ʯ','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','����','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�������ƾ�','���������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','������','��������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','ҹ֮ʯ','��������');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','����ʯ','��������');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���֮��������',   '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','������������',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���İ�������',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�����ξ����',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','����֮�ξ����',   '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�𻨺�������',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���ܺ�������',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���ص�����ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���������ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','��ҫ������ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','���µ�����ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','Բ�����꾧ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�ط����꾧ʯ',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','������ħ֮��',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','ͳ����ħ֮��',     '�տ�');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('��˹����','ALL','�����ߵĶ�ħ֮��', '�տ�');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ը���б�     *************/
insert into mine_fj (item_name) values ('Դ�ʿ�ʯ');
insert into mine_fj (item_name) values ('ȼ����ʯ');
insert into mine_fj (item_name) values ('����ʯ��');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ը���б�     *************/
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'���֮��������', '��������',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'������������'  , '��������',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'���İ�������'  , '��������',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'�����ξ����'  , '�ξ����',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'����֮�ξ����', '�ξ����',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'�𻨺�������'  , '��������',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,'���ܺ�������'  , '��������',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'���ص�����ʯ',     '������ʯ',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'���µ�����ʯ',     '������ʯ',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'���������ʯ',     '������ʯ',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'��ҫ������ʯ',     '������ʯ',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'������ħ֮��',     '��ħ֮��',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'ͳ����ħ֮��',     '��ħ֮��',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'�����ߵĶ�ħ֮��', '��ħ֮��',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'Բ�����꾧ʯ',     '���꾧ʯ',null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('���������',1,'�ط����꾧ʯ',     '���꾧ʯ',null);

-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    ը���б�     *************/
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���ص�����ʯ',10,10,10,10,10);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���µ�����ʯ',10,10,10,10,10);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','���������ʯ',10,10,10,10,10);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','��ҫ������ʯ',10,10,10,10,10);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','������ħ֮��',10,10,10,10,10);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('��˹����','�տ�','ͳ����ħ֮��',10,10,10,10,10);
-----------------------------------------------------------------------------------------------------------------------------------
