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
