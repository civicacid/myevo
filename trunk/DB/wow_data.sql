insert into LazyParameters (bh,nr,ms) values ('1','Y','是否将lazy的日志写入数据库(Y/N)');

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
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','源质矿石','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','燃铁矿石','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','黑曜石矿','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','鞭尾草','爱贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','暮光茉莉','爱贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','心灵之花','爱贝贝熊');
                                                       
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','地狱炎石','最初的联盟');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','琥珀晶石','最初的联盟');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','恶魔之眼','最初的联盟');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','海洋青玉','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','梦境翡翠','Welcomex');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','暗烬黄玉','Welcomex');
                                                       
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','泽菲蓝晶石','爱贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','碧玉','最初的联盟');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','阿里锡黄晶','最初的联盟');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','红玉髓','爱贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','夜之石','爱贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','桂榴石','爱贝贝熊');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','娴熟之暗烬黄玉',   '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','机敏暗烬黄玉',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','铭文暗烬黄玉',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','华丽梦境翡翠',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','禅悟之梦境翡翠',   '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','火花海洋青玉',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','致密海洋青玉',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','朴素地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','闪光地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','闪耀地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','精致地狱炎石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','圆润琥珀晶石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','秘法琥珀晶石',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','纯净恶魔之眼',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','统御恶魔之眼',     '收矿啊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','防御者的恶魔之眼', '收矿啊');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','催眠之尘', '碰友');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','强效天界精华', '碰友');

insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','动燃空气','伤人无数');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','动燃生命','杀贝贝熊');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','动燃之火','伤人无数');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','动燃之水','伤人无数');
insert into maillist (server,sender_char_name,item_name,receiver_char_name) values ('爱斯特纳','ALL','动燃之土','伤人无数');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    炸矿列表     *************/
insert into mine_fj (item_name) values ('源质矿石');
insert into mine_fj (item_name) values ('燃铁矿石');
insert into mine_fj (item_name) values ('黑曜石矿');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    角色制作物品列表     *************/
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '娴熟之暗烬黄玉',   '暗烬黄玉');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '机敏暗烬黄玉'  ,   '暗烬黄玉');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '铭文暗烬黄玉'  ,   '暗烬黄玉');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '华丽梦境翡翠'  ,   '梦境翡翠');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '禅悟之梦境翡翠',   '梦境翡翠');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '火花海洋青玉'  ,   '海洋青玉');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('Welcomex',1,  '致密海洋青玉'  ,   '海洋青玉');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'朴素地狱炎石',     '地狱炎石');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'精致地狱炎石',     '地狱炎石');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'闪光地狱炎石',     '地狱炎石');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'闪耀地狱炎石',     '地狱炎石');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'纯净恶魔之眼',     '恶魔之眼');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'统御恶魔之眼',     '恶魔之眼');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'防御者的恶魔之眼', '恶魔之眼');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'圆润琥珀晶石',     '琥珀晶石');
insert into charcreation (char_name,tradeskill,item_name,need_item_name1) values ('最初的联盟',1,'秘法琥珀晶石',     '琥珀晶石');

insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_count1,need_item_name2,need_count2,disenchant) 
                  values ('最初的联盟',1,'碧玉指环','碧玉',1,'珠宝师的底座',1,1);
insert into charcreation (char_name,tradeskill,item_name,need_item_name1,need_count1,need_item_name2,need_count2,disenchant) 
                  values ('最初的联盟',1,'阿里锡黄晶坠饰','阿里锡黄晶',2,'珠宝师的底座',1,1);


-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    上货清单     *************/
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','朴素地狱炎石',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','精致地狱炎石',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','闪光地狱炎石',2000000,3000000,8,1,0);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','闪耀地狱炎石',2000000,3000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','纯净恶魔之眼',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','统御恶魔之眼',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','防御者的恶魔之眼',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','圆润琥珀晶石',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','秘法琥珀晶石',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','娴熟之暗烬黄玉',100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','机敏暗烬黄玉'  ,100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','铭文暗烬黄玉'  ,100000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','华丽梦境翡翠'  ,50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','禅悟之梦境翡翠',50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','火花海洋青玉'  ,50000,1000000,8,1,20);
insert into ahitem (server,char_name,item_name,item_minprice,item_maxprice,item_count,item_stacksize,backup_count) values ('爱斯特纳','收矿啊','致密海洋青玉'  ,50000,1000000,8,1,20);

-----------------------------------------------------------------------------------------------------------------------------------


/**********************************/
/***********    战斗文件     *************/
insert into fight_file (roll_type,file_name) values ('德鲁伊','德鲁伊.xml');
insert into fight_file (roll_type,file_name) values ('骑士','骑士.xml');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    地图文件     *************/
insert into map_file (map_name,file_name,mine_list,herb_list) values ('奥丹姆','奥丹姆.xml','源质矿$富源质矿$燃铁矿脉$','鞭尾草');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('地狱火半岛','地狱火半岛.xml','魔铁矿脉$精金矿脉$富精金矿脉','魔草$梦露花$山鼠草$');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('泰罗卡森林','泰罗卡森林.xml','魔铁矿脉$精金矿脉$富精金矿脉','魔草$虚空花$邪雾草$噩梦藤$');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('海加尔山','海加尔山.xml','黑曜石碎块','燃烬草');
insert into map_file (map_name,file_name,mine_list,herb_list) values ('嚎风峡湾','嚎风峡湾.xml','钴矿脉$富钴矿脉','虎百合$金苜蓿$');
-----------------------------------------------------------------------------------------------------------------------------------

/**********************************/
/***********    计划任务     *************/
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-10 15:11','yyyy-mm-dd hh24:mi'), 0, 23, 'Welcomex', 'FJKS', '1', 0);
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-15 6:00','yyyy-mm-dd hh24:mi'), 90, 53, '矿一', 'CJ', '1', 0);
insert into autologin (starttime, runtime, char_id, char_name, dowhat, machineid, everyday)
               values (to_date('2012-2-15 7:45','yyyy-mm-dd hh24:mi'), 90, 54, '矿二', 'CJ', '1', 0);
-----------------------------------------------------------------------------------------------------------------------------------

insert into WOWZONE (Z_ID, Z_NAME) values ('4922', '暮光高地');
insert into WOWZONE (Z_ID, Z_NAME) values ('4815', '柯尔普萨之森');
insert into WOWZONE (Z_ID, Z_NAME) values ('5144', '烁光海床');
insert into WOWZONE (Z_ID, Z_NAME) values ('5146', '瓦丝琪尔');
insert into WOWZONE (Z_ID, Z_NAME) values ('4080', '奎尔丹纳斯岛');
insert into WOWZONE (Z_ID, Z_NAME) values ('4', '诅咒之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('4298', '东瘟疫之地：血色领地');
insert into WOWZONE (Z_ID, Z_NAME) values ('25', '黑石山');
insert into WOWZONE (Z_ID, Z_NAME) values ('41', '逆风小径');
insert into WOWZONE (Z_ID, Z_NAME) values ('46', '燃烧平原');
insert into WOWZONE (Z_ID, Z_NAME) values ('51', '灼热峡谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('139', '东瘟疫之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('3', '荒芜之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('8', '悲伤沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('28', '西瘟疫之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('47', '辛特兰');
insert into WOWZONE (Z_ID, Z_NAME) values ('5287', '荆棘谷海角');
insert into WOWZONE (Z_ID, Z_NAME) values ('5339', '荆棘谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('11', '湿地');
insert into WOWZONE (Z_ID, Z_NAME) values ('33', '北荆棘谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('45', '阿拉希高地');
insert into WOWZONE (Z_ID, Z_NAME) values ('10', '暮色森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('267', '希尔斯布莱德丘陵');
insert into WOWZONE (Z_ID, Z_NAME) values ('44', '赤脊山');
insert into WOWZONE (Z_ID, Z_NAME) values ('4706', '吉尔尼斯废墟');
insert into WOWZONE (Z_ID, Z_NAME) values ('38', '洛克莫丹');
insert into WOWZONE (Z_ID, Z_NAME) values ('40', '西部荒野');
insert into WOWZONE (Z_ID, Z_NAME) values ('130', '银松森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('3433', '幽魂之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('1', '丹莫罗');
insert into WOWZONE (Z_ID, Z_NAME) values ('12', '艾尔文森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('85', '提瑞斯法林地');
insert into WOWZONE (Z_ID, Z_NAME) values ('1497', '幽暗城');
insert into WOWZONE (Z_ID, Z_NAME) values ('1519', '暴风城');
insert into WOWZONE (Z_ID, Z_NAME) values ('1537', '铁炉堡');
insert into WOWZONE (Z_ID, Z_NAME) values ('3430', '永歌森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('3487', '银月城');
insert into WOWZONE (Z_ID, Z_NAME) values ('4714', '吉尔尼斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('4755', '吉尔尼斯城');
insert into WOWZONE (Z_ID, Z_NAME) values ('5095', '托尔巴拉德');
insert into WOWZONE (Z_ID, Z_NAME) values ('5042', '深岩之洲');
insert into WOWZONE (Z_ID, Z_NAME) values ('4720', '失落群岛');
insert into WOWZONE (Z_ID, Z_NAME) values ('4737', '科赞');
insert into WOWZONE (Z_ID, Z_NAME) values ('5416', '大漩涡');
insert into WOWZONE (Z_ID, Z_NAME) values ('3520', '影月谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('3523', '虚空风暴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3522', '刀锋山');
insert into WOWZONE (Z_ID, Z_NAME) values ('3518', '纳格兰');
insert into WOWZONE (Z_ID, Z_NAME) values ('3519', '泰罗卡森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('3521', '赞加沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('3483', '地狱火半岛');
insert into WOWZONE (Z_ID, Z_NAME) values ('3703', '沙塔斯城');
insert into WOWZONE (Z_ID, Z_NAME) values ('2817', '晶歌森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('4197', '冬拥湖');
insert into WOWZONE (Z_ID, Z_NAME) values ('67', '风暴峭壁');
insert into WOWZONE (Z_ID, Z_NAME) values ('210', '冰冠冰川');
insert into WOWZONE (Z_ID, Z_NAME) values ('4742', '洛斯加尔登陆点');
insert into WOWZONE (Z_ID, Z_NAME) values ('3711', '索拉查盆地');
insert into WOWZONE (Z_ID, Z_NAME) values ('66', '祖达克');
insert into WOWZONE (Z_ID, Z_NAME) values ('394', '灰熊丘陵');
insert into WOWZONE (Z_ID, Z_NAME) values ('65', '龙骨荒野');
insert into WOWZONE (Z_ID, Z_NAME) values ('3537', '北风苔原');
insert into WOWZONE (Z_ID, Z_NAME) values ('495', '嚎风峡湾');
insert into WOWZONE (Z_ID, Z_NAME) values ('4395', '达拉然');
insert into WOWZONE (Z_ID, Z_NAME) values ('1977', '祖尔格拉布');
insert into WOWZONE (Z_ID, Z_NAME) values ('3805', '祖阿曼');
insert into WOWZONE (Z_ID, Z_NAME) values ('4945', '起源大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('4950', '格瑞姆巴托');
insert into WOWZONE (Z_ID, Z_NAME) values ('5396', '托维尔失落之城');
insert into WOWZONE (Z_ID, Z_NAME) values ('5788', '永恒之井');
insert into WOWZONE (Z_ID, Z_NAME) values ('5789', '时光之末');
insert into WOWZONE (Z_ID, Z_NAME) values ('5844', '暮光审判');
insert into WOWZONE (Z_ID, Z_NAME) values ('5035', '旋云之巅');
insert into WOWZONE (Z_ID, Z_NAME) values ('5088', '巨石之核');
insert into WOWZONE (Z_ID, Z_NAME) values ('4809', '灵魂洪炉');
insert into WOWZONE (Z_ID, Z_NAME) values ('4813', '萨隆矿坑');
insert into WOWZONE (Z_ID, Z_NAME) values ('4820', '映像大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('4926', '黑石岩窟');
insert into WOWZONE (Z_ID, Z_NAME) values ('5004', '潮汐王座');
insert into WOWZONE (Z_ID, Z_NAME) values ('1196', '乌特加德之巅');
insert into WOWZONE (Z_ID, Z_NAME) values ('4100', '净化斯坦索姆');
insert into WOWZONE (Z_ID, Z_NAME) values ('4228', '魔环');
insert into WOWZONE (Z_ID, Z_NAME) values ('4272', '闪电大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('4723', '冠军的试炼');
insert into WOWZONE (Z_ID, Z_NAME) values ('4264', '岩石大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('4416', '古达克');
insert into WOWZONE (Z_ID, Z_NAME) values ('4415', '紫罗兰监狱');
insert into WOWZONE (Z_ID, Z_NAME) values ('4196', '达克萨隆要塞');
insert into WOWZONE (Z_ID, Z_NAME) values ('4494', '安卡赫特：古代王国');
insert into WOWZONE (Z_ID, Z_NAME) values ('4277', '艾卓-尼鲁布');
insert into WOWZONE (Z_ID, Z_NAME) values ('4265', '魔枢');
insert into WOWZONE (Z_ID, Z_NAME) values ('206', '乌特加德城堡');
insert into WOWZONE (Z_ID, Z_NAME) values ('2366', '黑色沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('3848', '禁魔监狱');
insert into WOWZONE (Z_ID, Z_NAME) values ('4131', '魔导师平台');
insert into WOWZONE (Z_ID, Z_NAME) values ('3714', '破碎大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('3715', '蒸汽地窟');
insert into WOWZONE (Z_ID, Z_NAME) values ('3789', '暗影迷宫');
insert into WOWZONE (Z_ID, Z_NAME) values ('3791', '塞泰克大厅');
insert into WOWZONE (Z_ID, Z_NAME) values ('3847', '生态船');
insert into WOWZONE (Z_ID, Z_NAME) values ('3849', '能源舰');
insert into WOWZONE (Z_ID, Z_NAME) values ('2367', '旧希尔斯布莱德丘陵');
insert into WOWZONE (Z_ID, Z_NAME) values ('3790', '奥金尼地穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3792', '法力陵墓');
insert into WOWZONE (Z_ID, Z_NAME) values ('3716', '幽暗沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('3717', '奴隶围栏');
insert into WOWZONE (Z_ID, Z_NAME) values ('3713', '鲜血熔炉');
insert into WOWZONE (Z_ID, Z_NAME) values ('3562', '地狱火城墙');
insert into WOWZONE (Z_ID, Z_NAME) values ('1583', '黑石塔');
insert into WOWZONE (Z_ID, Z_NAME) values ('1584', '黑石深渊');
insert into WOWZONE (Z_ID, Z_NAME) values ('1477', '阿塔哈卡神庙');
insert into WOWZONE (Z_ID, Z_NAME) values ('2017', '斯坦索姆');
insert into WOWZONE (Z_ID, Z_NAME) values ('1176', '祖尔法拉克');
insert into WOWZONE (Z_ID, Z_NAME) values ('2557', '厄运之槌');
insert into WOWZONE (Z_ID, Z_NAME) values ('722', '剃刀高地');
insert into WOWZONE (Z_ID, Z_NAME) values ('2057', '通灵学院');
insert into WOWZONE (Z_ID, Z_NAME) values ('1337', '奥达曼');
insert into WOWZONE (Z_ID, Z_NAME) values ('2100', '玛拉顿');
insert into WOWZONE (Z_ID, Z_NAME) values ('491', '剃刀沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('796', '血色修道院');
insert into WOWZONE (Z_ID, Z_NAME) values ('721', '诺莫瑞根');
insert into WOWZONE (Z_ID, Z_NAME) values ('717', '监狱');
insert into WOWZONE (Z_ID, Z_NAME) values ('719', '黑暗深渊');
insert into WOWZONE (Z_ID, Z_NAME) values ('209', '影牙城堡');
insert into WOWZONE (Z_ID, Z_NAME) values ('718', '哀嚎洞穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('1581', '死亡矿井');
insert into WOWZONE (Z_ID, Z_NAME) values ('2437', '怒焰裂谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('5094', '黑翼血环');
insert into WOWZONE (Z_ID, Z_NAME) values ('5334', '暮光堡垒');
insert into WOWZONE (Z_ID, Z_NAME) values ('5600', '巴拉丁监狱');
insert into WOWZONE (Z_ID, Z_NAME) values ('5638', '风神王座');
insert into WOWZONE (Z_ID, Z_NAME) values ('5892', '巨龙之魂');
insert into WOWZONE (Z_ID, Z_NAME) values ('2159', '奥妮克希亚的巢穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3456', '纳克萨玛斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('4273', '奥杜尔');
insert into WOWZONE (Z_ID, Z_NAME) values ('4493', '黑曜石圣殿');
insert into WOWZONE (Z_ID, Z_NAME) values ('4500', '永恒之眼');
insert into WOWZONE (Z_ID, Z_NAME) values ('4603', '阿尔卡冯的宝库');
insert into WOWZONE (Z_ID, Z_NAME) values ('4722', '十字军的试炼');
insert into WOWZONE (Z_ID, Z_NAME) values ('4812', '冰冠堡垒');
insert into WOWZONE (Z_ID, Z_NAME) values ('4987', '红玉圣殿');
insert into WOWZONE (Z_ID, Z_NAME) values ('3457', '卡拉赞');
insert into WOWZONE (Z_ID, Z_NAME) values ('3606', '海加尔峰');
insert into WOWZONE (Z_ID, Z_NAME) values ('3607', '毒蛇神殿');
insert into WOWZONE (Z_ID, Z_NAME) values ('3618', '格鲁尔的巢穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3836', '玛瑟里顿的巢穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3842', '风暴要塞');
insert into WOWZONE (Z_ID, Z_NAME) values ('3845', '风暴要塞');
insert into WOWZONE (Z_ID, Z_NAME) values ('3923', '格鲁尔的巢穴');
insert into WOWZONE (Z_ID, Z_NAME) values ('3959', '黑暗神殿');
insert into WOWZONE (Z_ID, Z_NAME) values ('4075', '太阳之井高地');
insert into WOWZONE (Z_ID, Z_NAME) values ('2677', '黑翼之巢');
insert into WOWZONE (Z_ID, Z_NAME) values ('2717', '熔火之心');
insert into WOWZONE (Z_ID, Z_NAME) values ('3428', '安其拉');
insert into WOWZONE (Z_ID, Z_NAME) values ('3429', '安其拉废墟');
insert into WOWZONE (Z_ID, Z_NAME) values ('5723', '火焰之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('5034', '奥丹姆');
insert into WOWZONE (Z_ID, Z_NAME) values ('616', '海加尔山');
insert into WOWZONE (Z_ID, Z_NAME) values ('1377', '希利苏斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('490', '安戈洛环形山');
insert into WOWZONE (Z_ID, Z_NAME) values ('618', '冬泉谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('361', '费伍德森林');
insert into WOWZONE (Z_ID, Z_NAME) values ('440', '塔纳利斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('400', '千针石林');
insert into WOWZONE (Z_ID, Z_NAME) values ('15', '尘泥沼泽');
insert into WOWZONE (Z_ID, Z_NAME) values ('357', '菲拉斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('405', '凄凉之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('4709', '南贫瘠之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('406', '石爪山脉');
insert into WOWZONE (Z_ID, Z_NAME) values ('331', '灰谷');
insert into WOWZONE (Z_ID, Z_NAME) values ('493', '月光林地');
insert into WOWZONE (Z_ID, Z_NAME) values ('16', '艾萨拉');
insert into WOWZONE (Z_ID, Z_NAME) values ('17', '北贫瘠之地');
insert into WOWZONE (Z_ID, Z_NAME) values ('148', '黑海岸');
insert into WOWZONE (Z_ID, Z_NAME) values ('3525', '秘血岛');
insert into WOWZONE (Z_ID, Z_NAME) values ('14', '杜隆塔尔');
insert into WOWZONE (Z_ID, Z_NAME) values ('141', '泰达希尔');
insert into WOWZONE (Z_ID, Z_NAME) values ('215', '莫高雷');
insert into WOWZONE (Z_ID, Z_NAME) values ('1638', '雷霆崖');
insert into WOWZONE (Z_ID, Z_NAME) values ('1657', '达纳苏斯');
insert into WOWZONE (Z_ID, Z_NAME) values ('3524', '秘蓝岛');
insert into WOWZONE (Z_ID, Z_NAME) values ('3557', '埃索达');
insert into WOWZONE (Z_ID, Z_NAME) values ('5695', '安其拉：堕落王国');
