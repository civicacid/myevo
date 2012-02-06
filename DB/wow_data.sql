/**********************************/
/***********    角色信息     *************/
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
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'卖东西的公主','爱斯特纳','!WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'rubyfly9@gmail.com'),seq_all.nextval,'HUHUHU','爱斯特纳','WoW1|!WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'nnoky123@gmail.com'),seq_all.nextval,'鹤鹤四号','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'h3ufobio@163.com'),seq_all.nextval,'奡寗燊','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'gguioption@163.com'),seq_all.nextval,'甯寗翯','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'uiopiokio@163.com'),seq_all.nextval,'掱淼麤','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'bbiiyourbag@163.com'),seq_all.nextval,'曌檙芻','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'爱贝贝熊','爱斯特纳','',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'stefani_wang@163.com'),seq_all.nextval,'杀贝贝熊','爱斯特纳','',3);

insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'最初的联盟','爱斯特纳','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',1);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Welcomex','爱斯特纳','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',2);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'收矿啊','爱斯特纳','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',3);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'碰友','爱斯特纳','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',4);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'七只梅','爱斯特纳','SPYMAN1801|SPYMAN1802|!TYILOVEYH|WoW1|WoW2|',7);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Other','爱斯特纳','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',0);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Spyman','爱斯特纳','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',1);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Onedisk','爱斯特纳','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',2);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'Tyutone','爱斯特纳','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',3);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'伤人无数','爱斯特纳','SPYMAN1801|!SPYMAN1802|TYILOVEYH|WoW1|WoW2|',4);
insert into wowchar(acc_id,char_id,char_name,server,acc_list,char_idx) values ((select acc_id from wowaccount where acc_name = 'spyman1802@gmail.com'),seq_all.nextval,'哗哗的银子','爱斯特纳','SPYMAN1801|SPYMAN1802|TYILOVEYH|WoW1|!WoW2|',0);
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    邮寄列表     *************/
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','源质矿石','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','燃铁矿石','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','黑曜石矿','welcomex');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','地狱炎石','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','琥珀晶石','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','恶魔之眼','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','海洋青玉','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','梦境翡翠','welcomex');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','暗烬黄玉','welcomex');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','泽菲蓝晶石','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','碧玉','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','阿里锡黄晶','最初的联盟');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','红玉髓','爱贝贝熊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','夜之石','爱贝贝熊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','桂榴石','爱贝贝熊');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','娴熟之暗烬黄玉',   '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','机敏暗烬黄玉',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','铭文暗烬黄玉',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','华丽梦境翡翠',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','禅悟之梦境翡翠',   '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','火花海洋青玉',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','致密海洋青玉',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','朴素地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','闪光地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','闪耀地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','精致地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','圆润琥珀晶石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','秘法琥珀晶石',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','纯净恶魔之眼',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','统御恶魔之眼',     '收矿啊');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','防御者的恶魔之眼', '收矿啊');

insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
insert into maillist (server,sender_char_name,receiver_char_name,item_name) values ('爱斯特纳','ALL','','');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    炸矿列表     *************/
insert into mine_fj (item_name) values ('源质矿石');
insert into mine_fj (item_name) values ('燃铁矿石');
insert into mine_fj (item_name) values ('黑曜石矿');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    炸矿列表     *************/
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"娴熟之暗烬黄玉", "暗烬黄玉",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"机敏暗烬黄玉"  , "暗烬黄玉",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"铭文暗烬黄玉"  , "暗烬黄玉",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"华丽梦境翡翠"  , "梦境翡翠",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"禅悟之梦境翡翠", "梦境翡翠",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"火花海洋青玉"  , "海洋青玉",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('welcomex',1,"致密海洋青玉"  , "海洋青玉",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"朴素地狱炎石",     "地狱炎石",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"精致地狱炎石",     "地狱炎石",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"闪光地狱炎石",     "地狱炎石",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"闪耀地狱炎石",     "地狱炎石",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"纯净恶魔之眼",     "恶魔之眼",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"统御恶魔之眼",     "恶魔之眼",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"防御者的恶魔之眼", "恶魔之眼",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"圆润琥珀晶石",     "琥珀晶石",null);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_item_name2) values ('最初的联盟',1,"秘法琥珀晶石",     "琥珀晶石",null);

-----------------------------------------------------------------------------------------------------------------------------------

