using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using LazyLib.Wow;

namespace LazyLib.SPY
{
    public static class SpyDB
    {
        public static string IsWriteLazy
        {
            get { return GetParam("1"); }
        }

        /// <summary>保存char背包信息</summary>
        public static void SaveInfo_Bag(Dictionary<string, int> bag)
        {
            if (bag == null) return;
            foreach (KeyValuePair<string, int> item in bag)
            {
                string sql = string.Format("begin add_bag('{0}','{1}',{2}); end;", ObjectManager.MyPlayer.Name, item.Key, item.Value);
                Logging.Write(sql);
                if (!OraData.execSQLCmd(sql))
                {
                    Logging.Write(string.Format("处理{0}时，出现错误", sql));
                }
            }
        }

        // 获取角色背包信息
        public static Dictionary<string, int> GetCharBagInfo(string CharName)
        {
            Dictionary<string, int> result = new Dictionary<string, int>();
            DataTable dt;

            string sql = string.Format("select item_name,item_count from itemsinbag where char_name='{0}'", CharName);
            Logging.Write(sql);
            dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("处理{0}时，出现错误", sql));
                return null;
            }
            foreach (DataRow dr in dt.Rows)
            {
                result.Add(dr[0].ToString(), Convert.ToInt32(dr[1]));
            }
            return result;
        }

        // 获取角色列表
        public static Dictionary<string, string> GetChars()
        {
            Dictionary<string, string> chars = new Dictionary<string, string>();
            DataTable dt;

            string sql = "select char_id,char_name from wowchar";
            Logging.Write(sql);
            dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("处理{0}时，出现错误", sql));
                return chars;
            }

            chars.Clear();
            foreach (DataRow dr in dt.Rows)
            {
                chars.Add(dr["char_id"].ToString(), dr["char_name"].ToString());
            }
            return chars;
        }

        // 获取角色登陆信息
        public static Dictionary<string, string> GetCharLoginInfo(string charID)
        {
            Dictionary<string, string> chars = new Dictionary<string, string>();
            DataTable dt;

            if (string.IsNullOrWhiteSpace(charID))
            {
                Logging.Write("输入为空");
                return chars;
            }
            string sql = string.Format("select char_name,server,char_idx,acc_list,acc_name,acc_pass from v_login_info where char_id={0}", charID);
            dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("处理{0}时，出现错误", sql));
                return chars;
            }

            chars.Clear();
            foreach (DataRow dr in dt.Rows)
            {
                chars.Add("AccountName", dr["acc_name"].ToString());
                chars.Add("AccountPass", dr["acc_pass"].ToString());
                chars.Add("RealmName", dr["server"].ToString());
                chars.Add("CharIdx", dr["char_idx"].ToString());
                chars.Add("AccountList", dr["acc_list"].ToString());
            }
            return chars;
        }

        public static Dictionary<string, string> GetMailList()
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            string sql = string.Format("select receiver_char_name,item_name from maillist where sender_char_name='{0}' or (sender_char_name='ALL' and server=(select server from wowchar where char_name='{0}'))", ObjectManager.MyPlayer.Name);
            DataTable dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("GetMailList处理{0}时，出现错误", sql));
                return null;
            }

            result.Clear();
            foreach (DataRow dr in dt.Rows)
            {
                // 收件人是自己的话，跳过
                if (dr[0].ToString().ToUpper().Equals(ObjectManager.MyPlayer.Name.ToUpper())) continue;
                result.Add(dr[1].ToString(), dr[0].ToString());
            }
            return result;
        }

        public static DataTable GetAHList()
        {
            DataTable ahitems;

            string sql = string.Format("select item_name,item_minprice,item_maxprice,item_count,item_stacksize from ahitem where char_name='{0}'", ObjectManager.MyPlayer.Name);
            ahitems = OraData.execSQL(sql);
            if (ahitems.Columns.Count == 0)
            {
                Logging.Write(string.Format("GetAHList处理{0}时，出现错误", sql));
                return ahitems;
            }
            return ahitems;
        }

        public static List<string> GetMineList()
        {
            List<string> result = new List<string>();
            string sql = string.Format("select item_name from mine_fj");
            DataTable dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("GetMineList处理{0}时，出现错误", sql));
                return null;
            }

            foreach (DataRow dr in dt.Rows)
            {
                result.Add(dr[0].ToString());
            }
            return result;
        }

        public static Dictionary<string, string> GetCreationMap_ZBJG()
        {
            Dictionary<string, string> result = new Dictionary<string, string>();
            foreach (DataRow dr in GetCreationMap(1).Rows)
            {
                result.Add(dr[0].ToString(), dr[1].ToString());
            }
            return result;
        }

        public static DataTable GetCreationMap(int sk)
        {
            //商业技能(1-珠宝，2-铭文，3-锻造，4-炼金，5-裁缝，6-附魔)'
            string sql = string.Format("select item_name,need_item_name1,need_count1,need_item_name2,need_count2,disenchant from charcreation where char_name='{0}' and tradeskill={1}", ObjectManager.MyPlayer.Name, sk);
            DataTable dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("GetMineList处理{0}时，出现错误", sql));
                return null;
            }

            return dt;
        }

        public static Dictionary<string, int> GetAHLessItem()
        {
            Dictionary<string, int> result = new Dictionary<string, int>();
            string sql = "";
            sql += "WITH server_ahinfo AS";
            sql += " (SELECT char_name, item_name, backup_count";
            sql += "    FROM ahitem";
            sql += "   WHERE server = (SELECT server FROM wowchar WHERE char_name = '" + ObjectManager.MyPlayer.Name + "'))";
            sql += "SELECT req_item.item_name, req_item.backup_count - nvl(avi_item.item_count,0)";
            sql += "  FROM (SELECT item_name, backup_count FROM server_ahinfo) req_item,";
            sql += "       (SELECT item_name, item_count FROM itemsinbag WHERE char_name IN (SELECT char_name FROM server_ahinfo)) avi_item";
            sql += " WHERE req_item.item_name = avi_item.item_name(+) AND req_item.backup_count > nvl(avi_item.item_count,0)";

            DataTable dt = OraData.execSQL(sql);
            if (dt.Columns.Count == 0)
            {
                Logging.Write(string.Format("GetLessItem处理{0}时，出现错误", sql));
                return null;
            }
            foreach (DataRow dr in dt.Rows)
            {
                result.Add(dr[0].ToString(), Convert.ToInt32(dr[1]));
            }
            return result;
        }

        /// <summary>
        /// 向数据库写入附加日志信息
        /// </summary>
        /// <param name="LogType">日志类型</param>
        /// <param name="LogText">日志内容</param>
        public static void WriteLog(string LogType, string LogText)
        {
            if (string.IsNullOrWhiteSpace(LogType)) return;
            if (string.IsNullOrWhiteSpace(LogText)) return;
            OraData.execSQLCmd(string.Format("insert into wowlog (logtype,logtext) values ('{0}','{1}')", LogType.Replace("'", "''"), LogText.Replace("'", "''")));
        }

        /// <summary>
        /// 向数据库写Lazy的日志信息
        /// </summary>
        /// <param name="LogText">日志内容</param>
        public static void WriteLazyLog(string LogText)
        {
            //if (!IsWriteLazy.Equals("Y")) return;
            if (string.IsNullOrWhiteSpace(LogText)) return;

            string role_name = "";
            if (string.IsNullOrWhiteSpace(ObjectManager.MyPlayer.Name)) 
                role_name = "系统"; 
            else 
                role_name = ObjectManager.MyPlayer.Name;

            OraData.execSQLCmd(string.Format("insert into lazylog (char_name,logtext) values ('{0}','{1}')", role_name, LogText.Replace("'", "''")));
        }

        public static void SaveAhInfo(string seller, string item, int prize)
        {
            if (string.IsNullOrWhiteSpace(seller)) return;
            if (string.IsNullOrWhiteSpace(item)) return;
            OraData.execSQLCmd(string.Format("begin add_ahinfo('{0}','{1}','{2}',{3}); end;", ObjectManager.MyPlayer.Name, seller, item, prize));
        }

        public static DataTable GetJob(string MachineID)
        {
            string sql = string.Format("select runtime,char_id,dowhat from autologin where ((to_char(starttime,'hh24mi') = to_char(sysdate,'hh24mi') and everyday = 1) or to_char(starttime,'yyyymmddhh24mi') = to_char(sysdate,'yyyymmddhh24mi')) and machineid = '{0}'", MachineID);
            return OraData.execSQL(sql);
        }

        /// <summary>
        /// 获取地图对应的采集列表（第一个是矿，第二个是草药）
        /// </summary>
        public static List<string> GetMapCollect(string MapName)
        {
            List<string> result = new List<string>();
            string sql = string.Format("select mine_list,herb_list from map_file where map_name='{0}'", MapName);
            try
            {
                DataTable dt = OraData.execSQL(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(dr[0].ToString());
                    result.Add(dr[1].ToString());
                }
            }
            catch (Exception ex)
            {
                Logging.Write("GetMapCollect Error: " + ex.ToString());
                return null;
            }

            return result;
        }

        public static string GetParam(string Param)
        {
            string rtv = "", sql = "";
            sql = string.Format("select nr from LazyParameters where bh='{0}'", Param);
            try
            {
                DataTable dt = OraData.execSQL(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    rtv = dr[0].ToString();
                }
            }
            catch (Exception)
            {
                return null;
            }
            return rtv;
        }

        /// <summary>
        /// 获取地图列表
        /// </summary>
        public static List<string> GetMapList()
        {
            List<string> result = new List<string>();

            string sql = string.Format("select map_name from map_file");
            try
            {
                DataTable dt = OraData.execSQL(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(dr[0].ToString());
                }
            }
            catch (Exception ex)
            {
                Logging.Write("GetMapList Error: " + ex.ToString());
                return null;
            }
            return result;
        }

        /// <summary>
        /// 获取战斗列表
        /// </summary>
        public static List<string> GetFightList()
        {
            List<string> result = new List<string>();

            string sql = string.Format("select roll_type from fight_file");
            try
            {
                DataTable dt = OraData.execSQL(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    result.Add(dr[0].ToString());
                }
            }
            catch (Exception ex)
            {
                Logging.Write("GetFightList Error: " + ex.ToString());
                return null;
            }
            return result;
        }

        public static DataTable GetLianJin()
        {
            DataTable dt;
            string sql = string.Format("select itemname,needitem,havecd from lianjin where itemname in (select itemname from char_lianjin where char_name = '{0}') order by havecd desc", ObjectManager.MyPlayer.Name);
            try
            {
                dt = OraData.execSQL(sql);
            }
            catch (Exception ex)
            {
                Logging.Write("GetLianJin Error: " + ex.ToString());
                return null;
            }
            return dt;
        }

    }
}
