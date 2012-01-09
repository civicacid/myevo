using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.Threading;
using System.Windows.Forms;
using System.Data.SQLite;
using System.Data;

using LazyLib;
using LazyLib.Helpers;
using LazyLib.Wow;
using LazyEvo.LFlyingEngine;
using LazyEvo.PVEBehavior;
using LazyEvo.PVEBehavior.Behavior;
using LazyEvo.LFlyingEngine.Helpers;
using LazyEvo.Public;
using LazyEvo.Forms;

namespace LazyEvo.Plugins
{
    public class SpyWOW
    {
        private Thread _AutoLogin;
        public bool AutoRunning;

        private Thread _RunCheck;
        public bool RunCheck;

        public bool Success;
        private Process WOWProc;
        public string WOWAccName;
        public string WOWCharName;

        enum ProcStatus { 
            Start,
            Logining,
            Login_OK,
            Login_Fail,
            Working,
            Wait_Command,
            Stop
        };
        private ProcStatus ps;
        public int StartHour;
        public int StartMin;
        public int StopHour;
        public int StopMin;

        public void StartProc()
        {
            if (_RunCheck == null || !_RunCheck.IsAlive)
            {
                _RunCheck = new Thread(ProcCheck);
                //_RunCheck.Name = "AutoLogin";
                _RunCheck.IsBackground = true;
                _RunCheck.Start();
                ps = ProcStatus.Start;
            }
        }

        public void StopProc()
        {
            //AutoRunning = false;
            _RunCheck.Abort();
            _RunCheck = null;
        }

        public void ProcCheck()
        {
            int iHour;
            int iMin ;
            bool shutdown = false;

            Ticker ff = new Ticker(10000);

            while (true)
            { 
                if (ff.IsReady){
                    ff.Reset();
                    iHour = System.DateTime.Now.Hour;
                    iMin = System.DateTime.Now.Minute;

                    if (iHour == StartHour && iMin == StartMin && ps == ProcStatus.Start)
                    {
                        Logging.Write("开始登录");
                        ps = ProcStatus.Logining;
                        WOWProc = null;
                        StartAuto();
                    }
                    // 检查登录情况
                    if (iHour == StartHour && iMin == StartMin+10 && ps == ProcStatus.Logining)
                    {
                        Logging.Write("自动登录没有完成，需要强行关闭客户端");
                        StopAuto();

                        LazyHelpers.StopAll("自动登录没有完成，需要强行关闭客户端");
                        Thread.Sleep(1000);
                        try
                        {
                            WOWProc.Kill();
                        }
                        catch { };
                        // 自动登录失败，就不继续角色了
                        ps = ProcStatus.Login_Fail;
                        StopProc();

                    }

                    // 登录完成，读取地图和角色文件也完成，启动Bot
                    if (ps == ProcStatus.Login_OK)
                    {
                        Thread.Sleep(1000);
                        LazyHelpers.StartBotting();
                        ps = ProcStatus.Working;
                    }

                    // 自动停止发生后，关闭WOW
                    if (ps == ProcStatus.Working && !LazyLib.FSM.Engine.Running)
                    {
                        Logging.Write("自动停止发生后，关闭WOW");
                        if (WOWProc != null)
                        {
                            try
                            {
                                WOWProc.Kill();
                            }
                            catch { };
                        }
                        ps = ProcStatus.Start;
                    }

                    // 时间到了，Kill Processwanjia
                    if (iHour == StopHour && iMin == StopMin && ps == ProcStatus.Working)
                    {
                        Logging.Write("时间到，设置关闭标记");
                        shutdown = true;
                    }

                    if (shutdown)
                    {
                        Logging.Write("关闭WOW。。。 【" + LazyEvo.Forms.Helpers.LazyForms.MainForm.Text.ToLower()+"】");
                        if (LazyEvo.Forms.Helpers.LazyForms.MainForm.Text.ToLower().Equals("navigating"))
                        {
                            Logging.Write("检测到关闭标志，关闭WOW");
                            LazyHelpers.StopAll("时间到了，Kill Process");
                            if (WOWProc != null)
                            {
                                try
                                {
                                    WOWProc.Kill();
                                }
                                catch { };
                            }
                            ps = ProcStatus.Start;
                            shutdown = false;
                        }
                    }
                }
            }
        }

        public void StartAuto()
        {
            if (_AutoLogin == null || !_AutoLogin.IsAlive)
            {
                _AutoLogin = new Thread(AutoLogin);
                _AutoLogin.Name = "AutoLogin";
                _AutoLogin.IsBackground = true;
                _AutoLogin.Start();
            }
        }

        public void StopAuto()
        {
            if (_AutoLogin.IsAlive)
            {
                AutoRunning = false;
                _AutoLogin.Abort();
                _AutoLogin = null;
            }
        }

        private void AutoLogin()
        {
            string Accountloginloginbutton = "AccountLoginLoginButton";
            string Accountloginpasswordedit = "AccountLoginPasswordEdit";
            string Charselectenterworldbutton = "CharSelectEnterWorldButton";

            string WOWPath = LazySettings.WOWPath;
            string AccountName = LazySettings.WOWAccName;
            string AccountPass = LazySettings.WOWAccPass;
            string RealmName = LazySettings.WOWServer;
            string CharIdx = LazySettings.WOWCharIdx;
            string AccountList = LazySettings.WOWCharList;

            //读取数据库中记录，提取登录角色需要的数据
            //if (!WOWAll.IsOpen)
            //{
            //    WOWAll.Open();
            //}
            //if (!WOWAll.IsOpen)
            //{
            //    Logging.Write("数据库不能正常打开" + "\r\n" + RunWOW.errMsg);
            //    StopAuto();
            //    return;
            //}
            //WOWAll.LoadData();
            //if (WOWAll.AllWOWAccount.Exists(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == WOWAccName); }))
            //{
            //    WOWAll.WoWAccount SelectedWa = WOWAll.AllWOWAccount.Find(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == WOWAccName); });
            //    AccountName = SelectedWa.AccountName;
            //    AccountPass = SelectedWa.AccountPass;
            //    AccountList = SelectedWa.CharList;
            //    if (SelectedWa.Char.Exists(delegate(WOWAll.WoWChar wc) { return (wc.CharName == WOWCharName); }))
            //    {
            //        WOWAll.WoWChar SelectWc = SelectedWa.Char.Find(delegate(WOWAll.WoWChar wc) { return (wc.CharName == WOWCharName); });
            //        RealmName = SelectWc.Server;
            //        CharIdx = Convert.ToString(SelectWc.CharIndex);
            //    }
            //    else
            //    {
            //        Logging.Write(string.Format("角色【{0}】找不到", WOWCharName) + "\r\n" + RunWOW.errMsg);
            //        StopAuto();
            //        return;
            //    }
            //}
            //else
            //{
            //    Logging.Write(string.Format("账户【{0}】找不到", WOWAccName) + "\r\n" + RunWOW.errMsg);
            //    StopAuto();
            //    return;
            //}

            int RetryCount = 0;
            const int MAX_RETRY_COUNT = 5;

            AutoRunning = true;
            Success = false;

            if (!WTFFile.ChangeWTF(WOWPath, AccountName, RealmName, CharIdx, AccountList))
            {
                Logging.Write("修改WTF文件时，发生错误！！" + "\r\n" + RunWOW.errMsg);
                StopAuto();
                return;
            }

            if (!RunWOW.RunWow(WOWPath))
            {
                Logging.Write("不能成功运行WOW！！" + "\r\n" + RunWOW.errMsg);
                StopAuto();
                return;
            }
            Thread.Sleep(5000);

            Process[] _wowProc = Process.GetProcessesByName("Wow");

            while (_wowProc.Length <= 0)
            {
                RetryCount += 1;
                if (RetryCount > MAX_RETRY_COUNT) break;

                Thread.Sleep(5000);
            }

            if (!Memory.OpenProcess(_wowProc[0].Id))
            {
                Logging.Write("不能访问WOW进程！！");
                StopAuto();
                return;
            }

            WOWProc = _wowProc[0];

            InterfaceHelper.ReloadFrames();
            while (InterfaceHelper.GetFrames.Count <= 5)
            {
                Thread.Sleep(5000);
                InterfaceHelper.ReloadFrames();
            }

            InterfaceHelper.GetFrameByName(Accountloginpasswordedit).LeftClick();
            Thread.Sleep(1000);
            InterfaceHelper.GetFrameByName(Accountloginpasswordedit).SetEditBoxText(AccountPass);
            Thread.Sleep(1500);
            InterfaceHelper.GetFrameByName(Accountloginloginbutton).LeftClick();
            Thread.Sleep(10000);
            InterfaceHelper.GetFrameByName(Charselectenterworldbutton).LeftClick();
            Thread.Sleep(7000);
            while (!ObjectManager.InGame)
            {
                Thread.Sleep(1000);
            }

            ObjectManager.Initialize(_wowProc[0].Id);

            var executableFileInfo = new FileInfo(Application.ExecutablePath);
            string executableDirectoryName = executableFileInfo.DirectoryName;
            string ourDirectory = executableDirectoryName;

            //调用Profile
            FlyingProfile hh = new FlyingProfile();
            hh.LoadFile(LazySettings.MapFile);
            FlyingEngine.CurrentProfile = hh;

            //调用Behavior
            var pIniManager = new IniManager(ourDirectory + PveBehaviorSettings.SettingsName);
            pIniManager.IniWriteValue("Config", "LoadedBeharvior", LazySettings.FightFile);

            Success = true;
            ps = ProcStatus.Login_OK;
            Logging.Write("Login OK!!");
            StopAuto();
            return;
        }

        public class RunWOW
        {
            public static String errMsg;

            public static bool RunWow(String WOWPath)
            {
                if (String.IsNullOrEmpty(WOWPath))
                {
                    errMsg = "WOWPath is null";
                    return false;
                }

                String exeFilePath = WOWPath + "\\Wow.exe";
                Process process = new Process();
                process.StartInfo.FileName = exeFilePath;
                process.Start();
                return true;
            }
        }

        public void QuitWOW()
        {
            KeyHelper.ChatboxSendText("/exit");
        }
    }

    public static class WOWAll
    {
        public static List<WoWAccount> WoWAccountList;
        public static bool DBError = false;

        private static readonly SQLiteConnection Db = new SQLiteConnection("Data Source=d:\\account.db3");
        public static bool IsOpen { get; private set; }

        public static void Open()
        {
            IsOpen = true;
            Db.Open();
            CreateTable();
        }

        public static void Close()
        {
            IsOpen = false;
            Db.Close();
        }

        private static void Query(string sql)
        {
            SQLiteCommand query = Db.CreateCommand();
            query.CommandText = sql;
            query.ExecuteNonQuery();
        }

        private static void CreateTable()
        {
            Query("CREATE TABLE IF NOT EXISTS wowpath (path VARCHAR(255) UNIQUE);");
            Query("CREATE TABLE IF NOT EXISTS wowaccount (acc_name VARCHAR(255) UNIQUE, acc_pass VARCHAR(255), acc_list VARCHAR(255));");
            Query("CREATE TABLE IF NOT EXISTS wowchar (acc_name VARCHAR(255), char_name varchar(200) unique, server varchar(200), char_idx integer, fight varchar(200), mappath varchar(200));");
        }

        private static DataRow QueryFetchRow(string sql)
        {
            SQLiteCommand query = Db.CreateCommand();
            query.CommandText = sql;

            SQLiteDataAdapter da = new SQLiteDataAdapter(query);
            DataTable dt = new DataTable();
            try
            {
                dt.BeginLoadData();
                da.Fill(dt);
                dt.EndLoadData();
            }
            catch (Exception ex) { Logging.Write("Exception in QueryFetchRow: " + ex); }
            finally { da.Dispose(); }
            return dt.Rows.Cast<DataRow>().FirstOrDefault();

            /*
             * example usage:
            DataRow data = new DataRow();
            row = QueryFetchRow("SELECT * FROM items WHERE id = 1");
            Logging.Write("row: " + row["item_id"].ToString() + " " + row["item_name"].ToString() + "\n");
            */
        }

        private static DataTable GetTableData(string Table)
        {
            SQLiteCommand query = Db.CreateCommand();
            query.CommandText = "select * from " + Table;

            SQLiteDataAdapter da = new SQLiteDataAdapter(query);
            DataTable dt = new DataTable();
            try
            {
                dt.BeginLoadData();
                da.Fill(dt);
                dt.EndLoadData();
            }
            catch (Exception ex) { Logging.Write("Exception in GetTableData: " + ex); }
            finally { da.Dispose(); }

            return dt;
        }

        public static string WOWPath;
        public static List<WoWAccount> AllWOWAccount;
        public static void LoadData()
        {
            // 读取WOW Path
            try
            {
                DataTable PathData = GetTableData("wowpath");
                foreach (DataRow PathRow in PathData.Rows){
                    WOWPath = PathRow["path"].ToString();
                }
                
            }
            catch
            {
                WOWPath = null;
            }
            
            // 读取Account
            try
            {
                DataTable DTWOWAccount = GetTableData("wowaccount");
                DataTable DTWOWChar = GetTableData("wowchar");

                WoWAccount SingleWOWAccount;
                WoWChar SingleWOWChar;
                List<WoWAccount> ListWoWA = new List<WoWAccount>();
                
                foreach (DataRow DRWOWAccount in DTWOWAccount.Rows)
                {
                    
                    SingleWOWAccount.AccountName = DRWOWAccount["acc_name"].ToString();
                    SingleWOWAccount.AccountPass = DRWOWAccount["acc_pass"].ToString();
                    SingleWOWAccount.CharList = DRWOWAccount["acc_list"].ToString();

                    List<WoWChar> ListWoWC = new List<WoWChar>();
                    foreach (DataRow DRWOWChar in DTWOWChar.Select("acc_name='" + SingleWOWAccount.AccountName+"'"))
                    {
                        SingleWOWChar.CharName = DRWOWChar["char_name"].ToString();
                        SingleWOWChar.Server = DRWOWChar["server"].ToString();
                        SingleWOWChar.CharIndex = Convert.ToInt32(DRWOWChar["char_idx"].ToString());
                        SingleWOWChar.Fight = DRWOWChar["fight"].ToString();
                        SingleWOWChar.MapPath = DRWOWChar["mappath"].ToString();

                        ListWoWC.Add(SingleWOWChar);
                    }
                    SingleWOWAccount.Char = ListWoWC;
                    ListWoWA.Add(SingleWOWAccount);
                }

                AllWOWAccount = ListWoWA;
            }
            catch
            { AllWOWAccount = null; }

        }

        public static void UpdateWOWPath(string WPath)
        {
            Query(String.Format("update wowpath set path = '{0}'", WPath));
        }

        public static void UpdateWOWAccount(String ChangeAccName, String ChangeAccPass, String ChangeAccList)
        {
            string sql;
            sql = string.Format("update wowaccount set acc_pass='{0}', acc_list='{1}' where acc_name='{2}'", 
                                ChangeAccPass, ChangeAccList, ChangeAccName);
            Query(sql);
        }

        public static void UpdateWOWChar(String AccName, String CharName, String Server, int CharIdx)
        {
            string sql;
            sql = string.Format("update wowchar set server='{0}', char_idx={1} where acc_name='{2}' and char_name='{3}'", 
                                Server, Convert.ToString(CharIdx), AccName, CharName);
            Query(sql);
        }
        
        public static void NewWOWAccount(String ChangeAccName, String ChangeAccPass, String ChangeAccList)
        {
            string sql;
            sql = string.Format("insert into wowaccount values ('{0}','{1}','{2}')", ChangeAccName, ChangeAccPass, ChangeAccList);
            Query(sql);
        }

        public static void NewWOWChar(String AccName, String CharName, String Server, int CharIdx)
        {
            string sql;
            sql = string.Format("insert into wowchar values ('{0}','{1}','{2}',{3})", AccName, CharName, Server, Convert.ToString(CharIdx));
            Query(sql);
        }

        public static void DelWOWAccount(String ChangeAccName)
        {
            string sql;
            sql = string.Format("delete from wowchar where acc_name='{0}';delete from wowaccount where acc_name='{0}'; ", ChangeAccName);
            Query(sql);
        }

        public static void DelWOWChar(String AccName, String CharName)
        {
            string sql;
            sql = string.Format("delete from wowchar where acc_name='{0}' and char_name='{1}'", AccName, CharName);
            Query(sql);
        }

        public struct WoWAccount
        {
            public String AccountName;
            public String AccountPass;
            public String CharList;
            public List<WoWChar> Char;
        }

        public struct WoWChar
        {
            public String CharName;
            public String Server;
            public int CharIndex;
            public String Fight;
            public String MapPath;
        }
    }

    public class SpyFrame
    {
        // 获取消息框文字
        public static string GetInfoFromFrame()
        {
            Frame InfoFrame = InterfaceHelper.GetFrameByName("frmTest");
            string info = InfoFrame.GetChildObject("frmTestText").GetText;
            return info;
        }

        // 获知背包物品内容
        public static bool GetBagInfo()
        {
            // 调用lua，收集背包物品信息
            KeyHelper.ChatboxSendText("/script ScanBag()");
            while (GetInfoFromFrame() == "正在执行")
            {
                Thread.Sleep(100);
            }

            // 调用lua，发送数据
            Dictionary<string, int> BagInfo = new Dictionary<string, int>();
            int iCount = 1;
            while (true)
            {
                KeyHelper.ChatboxSendText("/script ScanBagShow(" + Convert.ToString(iCount) + ")");
                while (GetInfoFromFrame() == "正在执行")
                {
                    Thread.Sleep(100);
                }
                if (GetInfoFromFrame().IndexOf("错误") > 0)
                {
                    Logging.Write("获取信息错误");
                    return false;
                }

                string info = GetInfoFromFrame();
                string[] split = info.Split('#');
                BagInfo.Add(split[1], Convert.ToInt16(split[2]));
                Logging.Write(split[1] + split[2]);
                iCount++;
                if (Convert.ToInt16(split[0]) == Convert.ToInt16(split[3]))
                {
                    return true;
                }
            }
            

        }
    }
}
