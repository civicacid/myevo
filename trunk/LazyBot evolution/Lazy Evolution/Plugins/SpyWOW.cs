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
using System.Runtime.InteropServices;

using LazyLib;
using LazyLib.Helpers;
using LazyLib.Wow;
using LazyEvo.LFlyingEngine;
using LazyEvo.PVEBehavior;
using LazyEvo.PVEBehavior.Behavior;
using LazyEvo.LFlyingEngine.Helpers;
using LazyEvo.Public;
using LazyEvo.Forms;
using LazyLib.Helpers.Mail;

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

                    // 时间到了，Kill Process
                    if (iHour == StopHour && iMin == StopMin && ps == ProcStatus.Working)
                    {
                        Logging.Write("时间到，设置关闭标志");
                        shutdown = true;
                    }

                    if (shutdown)
                    {
                        if (LazyEvo.Forms.Helpers.LazyForms.MainForm.Text.ToLower().Equals("navigating"))
                        {
                            LazyHelpers.StopAll("时间到了，Kill Process");
                            Thread.Sleep(1000);
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
                process.WaitForInputIdle();
                return true;
            }
        }

        public void QuitWOW()
        {
            KeyHelper.SendLuaOverChat("/exit");
        }
    }

    // WOW 数据相关
    public static class WOWAll
    {
        //public static DataTable 
        [DllImport("user32.dll")]
        private static extern int SetForegroundWindow(IntPtr Hwnd);

        public static void SetForGround()
        {
            IntPtr hwnd = Memory.WindowHandle;
            if (hwnd.ToInt32() > 0)
            {
                SetForegroundWindow(hwnd);
            }
        }
        
        public static List<WoWAccount> WoWAccountList;

        private static void Query(string sql)
        {
            try
            {
                OraData.execSQLCmd(sql);
            }
            catch (Exception ex)
            {
                Logging.Write(string.Format("执行SQL【{0}】时发生错误：",sql) + ex.ToString());
            }
        }

        private static DataTable GetTableData(string Table)
        {
            DataTable dt = new DataTable();
            try{
                dt = OraData.execSQL("select * from " + Table);
                return dt;
            }catch(Exception ex){
                Logging.Write("获取表数据时发生错误：" + ex.ToString());
                return dt;
            }
        }

        public static List<WoWAccount> AllWOWAccount;
        public static void LoadData()
        {
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

                        //ListWoWC.Add(SingleWOWChar);
                    }
                    SingleWOWAccount.Char = ListWoWC;
                    ListWoWA.Add(SingleWOWAccount);
                }

                AllWOWAccount = ListWoWA;
            }
            catch
            { AllWOWAccount = null; }

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
        private const string LUA_RUNNING_STRING = "Begin";
        private const string LUA_SUCCESS_STRING = "Success";
        private const char SPLIT_CHAR = '$';

        // 获取消息框文字
        public static string GetInfoFromFrame()
        {
            while (InterfaceHelper.GetFrames.Count == 0)
            {
                Thread.Sleep(100);
            }
            Frame InfoFrame = InterfaceHelper.GetFrameByName("frmTest");
            if (InfoFrame == null)
            {
                Logging.Write("没有启动插件？？？");
                return null;
            }
            string info = InfoFrame.GetChildObject("frmTestText").GetInfoText;
            return info;
        }

        // 获取返回值内容
        public static string GetFrameRtv()
        {
            const string TAG_NEXT_PAGE = "【MORE】";

            string rtv, resultString;
            int count;

            
            // 发送取结果的命令
            KeyHelper.SendLuaOverChat("/script SendResult(1)");
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(10);
            }

            // 取得返回值（注意排错）
            resultString = GetInfoFromFrame();
            if (resultString == null) return null;
            if (resultString.IndexOf("错误") > 0)
            {
                Logging.Write("获取信息错误: " + resultString);
                return null;
            }

            // 检查其中是否有下一页的标记，没有就直接返回
            if (resultString.IndexOf(TAG_NEXT_PAGE) == -1)
            {
                rtv = resultString;
                return rtv;
            }

            // 有，就循环读，直到没有下一页标记，然后拼结果
            rtv = resultString;
            count = 2;
            while (true)
            {
                KeyHelper.SendLuaOverChat("/script SendResult(" + Convert.ToString(count) + ")");
                while (GetInfoFromFrame() == LUA_RUNNING_STRING)
                {
                    Thread.Sleep(10);
                } 
                resultString = GetInfoFromFrame();
                if (resultString.IndexOf("错误") > 0)
                {
                    Logging.Write("获取信息错误: " + resultString);
                    return null;
                }
                if (resultString.IndexOf(TAG_NEXT_PAGE) > 0)
                {
                    break;
                }

                rtv = rtv + resultString;
                count++;
            }
            rtv = rtv + resultString.Substring(TAG_NEXT_PAGE.Length + 1);
            return rtv;
        }

        // 获知背包物品内容
        public static Dictionary<string, int> lua_GetBagInfo()
        {
            Dictionary<string, int> bag;
            int MaxReTryCount = 5;
            int ReTryCount = 0;

            // 调用lua，收集背包物品信息
            KeyHelper.SendLuaOverChat("/script ScanBag()");
            ReTryCount = 0;
            bag = null;
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(100);
                ReTryCount++;
                if (ReTryCount > MaxReTryCount)
                {
                    Logging.Write("[GetBagInfo]超过Retry次数");
                    return bag;
                }
            }
            if (GetInfoFromFrame() != null)
            {
                if (GetInfoFromFrame().IndexOf("错误") > 0)
                {
                    Logging.Write("获取信息错误");
                    return bag;
                }
            }

            string rtv = GetFrameRtv();
            if (rtv != null)
            {
                bag = new Dictionary<string, int>();
                string[] split = rtv.Split(SPLIT_CHAR);
                for (int iLoop = 0; iLoop < split.Length - 1; iLoop++)
                {
                    if (iLoop % 2 == 0)
                    {
                        bag.Add(split[iLoop], Convert.ToInt16(split[iLoop+1]));
                    }
                }
            }
            return bag;
        }

        // 获知邮箱物品内容
        public static Dictionary<string, int> lua_GetInboxInfo()
        {
            Dictionary<string, int> inbox;
            int MaxReTryCount = 5;
            int ReTryCount = 0;

            // 调用lua，收集背包物品信息
            KeyHelper.SendLuaOverChat("/script ScanInbox()");
            ReTryCount = 0;
            inbox = null;
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(100);
                ReTryCount++;
                if (ReTryCount > MaxReTryCount)
                {
                    Logging.Write("[GetBagInfo]超过Retry次数");
                    return inbox;
                }
            }
            if (GetInfoFromFrame() != null)
            {
                if (GetInfoFromFrame().IndexOf("错误") > 0)
                {
                    Logging.Write("获取信息错误");
                    return inbox;
                }
            }

            string rtv = GetFrameRtv();
            if (rtv != null)
            {
                inbox = new Dictionary<string, int>();
                string[] split = rtv.Split(SPLIT_CHAR);
                for (int iLoop = 0; iLoop < split.Length - 1; iLoop++)
                {
                    if (iLoop % 2 == 0)
                    {
                        inbox.Add(split[iLoop], Convert.ToInt16(split[iLoop + 1]));
                    }
                }
            }
            return inbox;
        }

        // 给人发邮件
        public static bool lua_SendItemByName(string receiver , string itemname)
        {
            if (!MailFrame.Open)
            {
                Logging.Write("邮箱没开！！！");
                return false;
            }
            MailFrame.ClickInboxTab();
            Thread.Sleep(500);
            MailFrame.ClickSendMailTab();
            Thread.Sleep(500); 
            while (true)
            {
                if (MailFrame.CurrentTabIsSendMail) break;
                MailFrame.ClickSendMailTab();
                Thread.Sleep(500); 
            }
            Thread.Sleep(500);
            KeyLowHelper.PressKey(MicrosoftVirtualKeys.Escape);
            KeyLowHelper.ReleaseKey(MicrosoftVirtualKeys.Escape);
            Thread.Sleep(500);
            return ExecSimpleLua(string.Format("/script SendItemByName(\"{0}\",\"{1}\")", receiver, itemname));
        }
        
        // 获取邮件
        public static bool lua_GetMAILAsItem(string ItemName, int ItemCount)
        {
            if (!MailFrame.Open)
            {
                Logging.Write("邮箱没开！！！");
                return false;
            }
            MailFrame.ClickInboxTab();
            Thread.Sleep(500);
            while (true)
            {
                if (MailFrame.CurrentTabIsInbox) break;
                MailFrame.ClickInboxTab();
                Thread.Sleep(500);
            }
            return ExecSimpleLua(string.Format("/script GetMAILAsItem(\"{0}\",{1})", ItemName, ItemCount));
        }

        // 重新整理背包-整合背包，需要插件辅助
        public static void lua_RepackBag()
        {
            KeyHelper.SendLuaOverChat("/script ArkInventory.Restack()");
        }

        // 搜索AH
        public static Dictionary<string, string> lua_AHSearchDoor(string itemname)
        {
            Dictionary<string, string> result;
            int MaxReTryCount = 20;
            int ReTryCount = 0;

            // 调用lua，收集背包物品信息
            KeyHelper.SendLuaOverChat(string.Format("/script AHSearchDoor(\"{0}\")",itemname));
            ReTryCount = 0;
            result = null;
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(100);
                ReTryCount++;
                if (ReTryCount > MaxReTryCount)
                {
                    Logging.Write("[GetBagInfo]超过Retry次数");
                    return result;
                }
            }
            if (GetInfoFromFrame().IndexOf("错误") > 0)
            {
                Logging.Write("获取信息错误");
                return result;
            }

            string rtv = GetFrameRtv();
            if (rtv != null)
            {
                result = new Dictionary<string, string>();
                string[] split = rtv.Split('#');
                result.Add("SELLER", split[0]);
                result.Add("PRIZE", split[1]);
            }
            return result;
        }

        // 取消所有的低于指定价格的拍卖
        public static bool lua_CancelAll(string ItemName, int SinglePrize)
        {
            while (true)
            {
                KeyHelper.SendLuaOverChat(string.Format("/script CancelAH(\"{0}\",{1})", ItemName, Convert.ToString(SinglePrize)));
                while (GetInfoFromFrame() == LUA_RUNNING_STRING)
                {
                    Thread.Sleep(10);
                }
                string resultString = GetInfoFromFrame();
                if (resultString.IndexOf("错误") > 0)
                {
                    Logging.Write("获取信息错误: " + resultString);
                    return false;
                }
                if (resultString.Contains("NO")) break;
            }
            return true;
        }

        // 拍卖物品
        public static bool lua_StartAuction(string ItemName, int SinglePrize, int StackSize, int NumStack)
        {
            return ExecSimpleLua(string.Format("/script AHPostItemDoor(\"{0}\",{1},{2},{3})", ItemName, SinglePrize, StackSize, NumStack));
        }

        // 运行没有返回值的LUA命令
        public static bool ExecSimpleLua(string LuaCmd)
        {
            // 发送取结果的命令
            KeyHelper.SendLuaOverChat(LuaCmd);
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(10);
            }

            // 取得返回值（注意排错）
            string resultString = GetInfoFromFrame();
            if (resultString.Contains("错误"))
            {
                Logging.Write("获取信息错误: " + resultString);
                return false;
            }

            return true;
        }

        // 获取frmData显示值，分解后得到指定物品在背包和邮箱中的数量
        public static bool lua_SetDispCountItemName(string ItemName)
        {
            return ExecSimpleLua(string.Format("/script SetDisplayItemName({0})", ItemName));
        }
        public static Dictionary<string, int> GetDispCountItemCount()
        {
            Dictionary<string, int> ItemCount = new Dictionary<string, int>();
            ItemCount.Add("BAG",0);
            ItemCount.Add("MAIL", 0);
            while (InterfaceHelper.GetFrames.Count == 0)
            {
                Thread.Sleep(100);
            }
            Frame InfoFrame = InterfaceHelper.GetFrameByName("frmData");
            if (InfoFrame == null) return ItemCount;
            string info = InfoFrame.GetChildObject("frmDataText").GetInfoText;
            if (string.IsNullOrWhiteSpace(info)) return ItemCount;
            string[] split = info.Split(SPLIT_CHAR);
            ItemCount["BAG"] = Convert.ToInt16(split[0]);        //背包
            ItemCount["MAIL"] = Convert.ToInt16(split[1]);        //邮件
            return ItemCount;
        }
    }

    public static class SpyTradeSkill
    {
        //是不是正在分解
        public static bool IsProspecting()
        {
            return (ObjectManager.MyPlayer.CastingId == 31252);
        }

        public static bool SendMain(Dictionary<string, string> MailList, DBLogger logger)
        {
            if (MailList.Count == 0)
            {
                logger.Add("邮件列表为空");
                return true;
            }
            Dictionary<string, int> bag = SpyFrame.lua_GetBagInfo();
            if (bag.Count == 0)
            {
                logger.Add("背包内容为空");
                return true;
            }

            logger.Add("整理背包");
            SpyFrame.lua_RepackBag();
            Thread.Sleep(5000);

            logger.Add("开始发送邮件");
            foreach (KeyValuePair<string, string> mail in MailList)
            {
                logger.Add(string.Format("开始发送{0}到{1}",mail.Key,mail.Value));
                if (bag.ContainsKey(mail.Key))
                {
                    if (!SpyFrame.lua_SendItemByName(mail.Value, mail.Key))
                    {
                        logger.Add(string.Format("发{0}给{1}，失败了", mail.Value, mail.Key));
                        return false;
                    }
                }
                else
                {
                    logger.Add(string.Format("背包中没有{0}", mail.Key));
                }
            }
            return true;
        }
    }

    public class DBLogger
    {
        private List<string> logger;
        private string toAppend;
        public DBLogger(string AppendMessage)
        {
            logger = new List<string>();
            toAppend = AppendMessage;
        }

        public void Add(string msg)
        {
            logger.Add("[" + DateTime.Now.ToString("YYYY-MM-DD HH:mm:ss") + "]<" + toAppend + ">" + msg);
        }

        public void output()
        {
            foreach (string msg in logger)
            {
                Logging.Write(msg);
            }
        }

        public void clear()
        {
            logger.Clear();
        }

        public void UpdateDB()
        {
            // 启动一个线程，更新数据库的日志信息
            clear();
        }
    }

    // 分解矿+邮寄
    public static class SpyMineAndMail
    {
        public static List<string> Mines;                                 //待分解清单
        public static Dictionary<string, string> MailList;                //发货列表
        public static DBLogger logger = new DBLogger("拿取邮件+分矿+邮寄");

        public static void GoGo()
        {
            DoAction();
            logger.output();
        }

        public static void DoAction()
        {
            int CountJump = 0;
            foreach (string DoingMine in Mines)
            {
                if (!SpyFrame.lua_SetDispCountItemName(DoingMine))
                {
                    logger.Add("在执行SetDispCountItemName时出错，矿：" + DoingMine);
                    return;
                }
                Dictionary<string, int> MineCount = SpyFrame.GetDispCountItemCount();
                /** 检查背包里面有没有矿，有就炸，没有再查邮箱，从邮箱拿，直到没有矿 **/
                if (MineCount["BAG"] == 0 && MineCount["MAIL"] == 0)
                {
                    logger.Add("包里面没有(或者是都炸完了)  " + DoingMine);
                    continue;
                }
                while (MineCount["BAG"] > 0 || MineCount["MAIL"] > 0)
                {
                    // 邮箱里面有矿，取矿出来
                    if (MineCount["MAIL"] > 0)
                    {
                        logger.Add("从邮箱里面拿  " + DoingMine);
                        if (!SpyFrame.lua_GetMAILAsItem(DoingMine, 100000))
                        {
                            logger.Add("从邮箱里面拿  " + DoingMine + " 失败");
                            return;
                        }
                    }

                    MineCount = SpyFrame.GetDispCountItemCount();

                    // 分解矿，直到包空间小于1和背包里面没有矿
                    while (MineCount["BAG"] > 0 && Inventory.FreeBagSlots <= 1)
                    {
                        CountJump++;
                        if (CountJump == 10)
                        {
                            // jump一下，防止AFK
                            CountJump = 0;
                            logger.Add("jump一下，防止AFK");
                            MoveHelper.Jump();
                            Thread.Sleep(5000);
                        }
                        // 分解石头 , 分解宏要放在4这个上面
                        logger.Add("炸矿");
                        KeyLowHelper.PressKey(MicrosoftVirtualKeys.key4);
                        KeyLowHelper.ReleaseKey(MicrosoftVirtualKeys.key4);
                        Thread.Sleep(500);
                        while (ObjectManager.MyPlayer.IsCasting)
                        {
                            Thread.Sleep(100);
                        }
                        // 等待2秒，取分解的东西到背包
                        Thread.Sleep(2000);
                        MineCount = SpyFrame.GetDispCountItemCount();
                    }

                    // 当包里面还有矿的时候，可能是背包满了，这时候启动邮寄
                    if (Inventory.FreeBagSlots <= 1)
                    {
                        // 发邮件
                        logger.Add("发邮件");
                        if (!SpyTradeSkill.SendMain(MailList, logger)) return;
                    }
                    MineCount = SpyFrame.GetDispCountItemCount();

                    // 邮寄完，背包还是满，就退出
                    if (Inventory.FreeBagSlots <= 1)
                    {
                        logger.Add("邮寄完，背包还是满");
                        return;
                    }
                }
            }
            return;
        }
    }

    public static class SpyAH
    {
        public static DBLogger logger = new DBLogger("拿取邮件+找到拍卖师+AH上货");
        public static DataTable Items = new DataTable();

        /********              需要设置的内容                 ******************/
        // 邮箱点
        public static Location LocMailbox = new Location(1, 1, 1);
        // AH拍卖师点
        public static Location LocAHer = new Location(1, 1, 1);
        public static string AHerName = "";

        public static void init()
        {
            //Items.PrimaryKey
            Items.Columns.Add("item_name", System.Type.GetType("System.String"));
            Items.Columns.Add("item_minprice", System.Type.GetType("System.Int32"));
            Items.Columns.Add("item_maxprice", System.Type.GetType("System.Int32"));
            Items.Columns.Add("item_count", System.Type.GetType("System.Int32"));
            Items.Columns.Add("item_stacksize", System.Type.GetType("System.Int32"));
            DataColumn[] pk = new DataColumn[1];
            pk[0] = Items.Columns["item_id"];
            Items.PrimaryKey = pk;
            //DataRow dr = dt.NewRow();
            //dr["column0"] = "AX";
            //dr["column1"] = true;
        }

        public static void gogo()
        {
            DoAction();
            logger.output();
        }

        public static bool DoAction()
        {
            // 跑到邮箱点
            logger.Add("跑到邮箱点");
            if (!MoveHelper.MoveToLoc(LocMailbox, 5))
            {
                logger.Add("跑到邮箱点出错");
                return false;
            }

            // 打开邮箱
            logger.Add("打开邮箱");
            if (!MailManager.TargetMailBox())
            {
                logger.Add("打开邮箱出错");
                return false;
            }

            // 遍历物品，保证背包中有足够的拍卖品。这里要注意背包空间
            logger.Add("遍历 待拍卖物品列表 ");
            foreach (DataRow dr in Items.Rows)
            {
                logger.Add("检查背包剩余空间");
                if (Inventory.FreeBagSlots <= 1){
                    logger.Add("检查背包剩余空间为1，不能继续");
                    return false;
                }
                string mine = dr["item_name"].ToString();
                logger.Add("处理拍卖对象 " + mine);
                if (!SpyFrame.lua_SetDispCountItemName(mine))
                {
                    logger.Add("在执行SetDispCountItemName时出错，矿：" + mine);
                    return false;
                }
                Thread.Sleep(500);
                logger.Add("通过lua获知物品在背包和邮箱中的数量");
                if (!SpyFrame.lua_SetDispCountItemName(mine))
                {
                    logger.Add("在执行SetDispCountItemName时出错，矿：" + mine);
                    return false;
                }
                Thread.Sleep(500);
                Dictionary<string, int> MineCount = SpyFrame.GetDispCountItemCount();
                logger.Add(string.Format("物品{0}在背包中的数量为{1}，在邮箱中的数量为：{2}", mine, MineCount["BAG"], MineCount["MAIL"]));
                int WantCount = (int)dr["item_name"] * (int)dr["item_stacksize"] > MineCount["BAG"]
                                ? (int)dr["item_name"] * (int)dr["item_stacksize"] - MineCount["BAG"]
                                : 0
                                ;
                // 拿邮件(LUA)
                logger.Add(string.Format("从邮箱中拿{0}个{1}",WantCount,mine));
                if (!SpyFrame.lua_GetMAILAsItem(mine, WantCount))
                {
                    logger.Add("从邮箱里面拿  " + mine + " 失败");
                    return false;
                }
                Thread.Sleep(1000);
            }

            // 跑到拍卖师身边
            logger.Add("跑到拍卖师身边");
            if (!MoveHelper.MoveToLoc(LocAHer, 5))
            {
                logger.Add("跑到拍卖师身边出错");
                return false;
            }
            // 找到拍卖师，打开拍卖界面
            logger.Add(string.Format("定位拍卖师：{0}", AHerName));
            bool found = false;
            foreach (PUnit unit in ObjectManager.GetUnits)
            {
                if (unit.Name.Equals(AHerName) && unit.Location.DistanceToSelf2D < 5)
                {
                    unit.Location.Face();
                    unit.Interact();
                    found = true;
                }
            }
            if (!found)
            {
                logger.Add(string.Format("没找到名字是{0}的拍卖师", AHerName));
                return false;
            }
            Thread.Sleep(2000);
            
            // 上货。 遍历待拍卖物品，扫描物品最低价格，最低价格不低于起拍价格，就上架
            logger.Add(string.Format("开始上货"));
            foreach (DataRow dr in Items.Rows)
            {
                // 扫描最低价格
                string ahitem = dr["item_name"].ToString();
                logger.Add(string.Format("扫描物品{0]的最低价格", ahitem));
                Dictionary<string, string> scanresult = SpyFrame.lua_AHSearchDoor(ahitem);
                if (scanresult == null)
                {
                    logger.Add(string.Format("获取物品{0]的最低价格出现错误，返回值为NULL", ahitem));
                    return false;
                }
                logger.Add(string.Format("物品{0}的最低价格是{1]，由{2}出价", ahitem, scanresult["PRIZE"], scanresult["SELLER"]));

                // 计算最低价格，准备上货
                if (scanresult["SELLER"].Equals(ObjectManager.MyPlayer.Name))
                {
                    logger.Add(string.Format("价格最低的就是我自己，所以不用上货"));
                    continue;
                }

                int prize, minprize, maxprize;
                maxprize = (int)(dr["item_maxprice"]);
                minprize = (int)(dr["item_minprice"]);

                // 如果目前出价低于心里价位，不出货
                if (Convert.ToInt32(scanresult["PRIZE"]) < minprize)
                {
                    logger.Add(string.Format("{0}出价低过心里价位{1}，暂时不出货"));
                    continue;
                }

                if (scanresult["SELLER"].Equals("NOBODY"))
                {

                    logger.Add(string.Format("拍卖场没有人卖{0}，将按照数据库中记录的最高价格{1}上货", ahitem, maxprize));
                    prize = maxprize;
                }
                else
                {
                    prize = Convert.ToInt32(scanresult["PRIZE"]) - 1;
                    logger.Add(string.Format("进过计算，物品{0}将按照单价{1}上架", ahitem, prize));
                    // 取消拍卖物品
                    logger.Add(string.Format("取消AH中单价低于{0}的{1}", prize, ahitem));
                    if (!SpyFrame.lua_CancelAll(ahitem, prize))
                    {
                        logger.Add(string.Format("取消AH出错"));
                        return false;
                    }
                }
                // 上货
                int StackSize = (int)(dr["item_stacksize"]);
                int StackCount = (int)(dr["item_count"]);
                logger.Add(string.Format("开始拍卖单价为{0}的“{1}”{2}堆，每堆{3}个", prize, ahitem, StackSize, StackCount));
                if (!SpyFrame.lua_StartAuction(ahitem, prize, StackSize, StackCount))
                {
                    logger.Add(string.Format("拍卖失败"));
                    return false;
                }
            }
            // 
            return true;
        }
    }
}
