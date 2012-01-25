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
using LazyLib.ActionBar;

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

        enum ProcStatus
        {
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
            int iMin;
            bool shutdown = false;

            //Ticker ff = new Ticker(10000);

            while (true)
            {
                //if (ff.IsReady)
                //{
                //    ff.Reset();
                if (LazyLib.FSM.Engine.Running) ps = ProcStatus.Working;

                Thread.Sleep(10000);

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
                if (iHour == StartHour && iMin == StartMin + 10 && ps == ProcStatus.Logining)
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
                        SpyDB.SaveInfo_Bag(SpyFrame.lua_GetBagInfo());
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

                //}
            }
        }

        public void StartAuto()
        {
            if (_AutoLogin == null || !_AutoLogin.IsAlive)
            {
                _AutoLogin = new Thread(AutoLogin);
                _AutoLogin.Name = "AutoLogin";
                _AutoLogin.IsBackground = true;
                SetParaByINI();
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

        private string WOWPath;
        private string AccountName;
        private string AccountPass;
        private string RealmName;
        private string CharIdx;
        private string AccountList;

        private void SetParaByINI()
        {
            WOWPath = LazySettings.WOWPath;
            AccountName = LazySettings.WOWAccName;
            AccountPass = LazySettings.WOWAccPass;
            RealmName = LazySettings.WOWServer;
            CharIdx = LazySettings.WOWCharIdx;
            AccountList = LazySettings.WOWCharList;
        }

        private void AutoLogin()
        {
            string Accountloginloginbutton = "AccountLoginLoginButton";
            string Accountloginpasswordedit = "AccountLoginPasswordEdit";
            string Charselectenterworldbutton = "CharSelectEnterWorldButton";

            int RetryCount = 0;
            const int MAX_RETRY_COUNT = 5;

            AutoRunning = true;
            Success = false;

            if (!WTFFile.ChangeWTF(WOWPath, AccountName, RealmName, CharIdx, AccountList))
            {
                Logging.Write("修改WTF文件时，发生错误！！" + "\r\n" + WTFFile.errMsg);
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
            ObjectManager.MyPlayer.Account = AccountName;
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
    }

    public static class SpyAutoLogin
    {
        private static string WOWPath;
        private static string AccountName;
        private static string AccountPass;
        private static string RealmName;
        private static string CharIdx;
        private static string AccountList;

        private static Thread _AutoLogin;

        public static bool IsOK;
        public static Process WOW_P;

        public static void initme(string _aname, string _apass, string _realname, string _charidx, string _alist)
        {
            LazySettings.LoadSettings();
            WOWPath = LazySettings.WOWPath;
            IsOK = false;

            if (string.IsNullOrWhiteSpace(_aname))
            {
                Logging.Write("参数【_aname】为空");
                return;
            }
            if (string.IsNullOrWhiteSpace(_apass))
            {
                Logging.Write("参数【_apass】为空");
                return;
            }
            if (string.IsNullOrWhiteSpace(_realname))
            {
                Logging.Write("参数【_realname】为空");
                return;
            }
            if (string.IsNullOrWhiteSpace(_charidx))
            {
                Logging.Write("参数【_charidx】为空");
                return;
            }

            AccountName = _aname;
            AccountPass = _apass;
            RealmName = _realname;
            CharIdx = _charidx;
            AccountList = _alist;

            // 修改WTF文件
            if (!WTFFile.ChangeWTF(WOWPath, AccountName, RealmName, CharIdx, AccountList))
            {
                Logging.Write("修改WTF文件时，发生错误！！\r\n" + WTFFile.errMsg);
                return;
            }
        }

        public static void start()
        {
            if (_AutoLogin == null || !_AutoLogin.IsAlive)
            {
                _AutoLogin = new Thread(gogo);
                _AutoLogin.Name = "AutoLoginWOW";
                _AutoLogin.IsBackground = true;
                _AutoLogin.Start();
                Logging.Write("AutoLoginWOW开始了。。。。。");
            }
        }

        public static void stop()
        {
            if (_AutoLogin == null) return;
            if (_AutoLogin.IsAlive)
            {
                _AutoLogin.Abort();
                _AutoLogin = null;
            }
        }

        private static void gogo()
        {
            RunWow();

            if (!Memory.OpenProcess(WOW_P.Id))
            {
                Logging.Write("不能访问WOW进程！！");
                stop();
                return;
            }

            InterfaceHelper.ReloadFrames();
            while (InterfaceHelper.GetFrames.Count == 0)
            {
                Thread.Sleep(500);
                InterfaceHelper.ReloadFrames();
            }

            InterfaceHelper.GetFrameByName("AccountLoginPasswordEdit").LeftClick();
            Thread.Sleep(1000);
            InterfaceHelper.GetFrameByName("AccountLoginPasswordEdit").SetEditBoxText(AccountPass);
            Thread.Sleep(1500);
            InterfaceHelper.GetFrameByName("AccountLoginLoginButton").LeftClick();
            Thread.Sleep(10000);
            InterfaceHelper.GetFrameByName("CharSelectEnterWorldButton").LeftClick();
            Thread.Sleep(7000);
            while (!ObjectManager.InGame)
            {
                Thread.Sleep(100);
            }
            IsOK = true;
            //stop();
        }

        private static void RunWow()
        {
            String exeFilePath = WOWPath + "\\Wow.exe";
            WOW_P = new Process();
            WOW_P.StartInfo.FileName = exeFilePath;
            WOW_P.Start();
            while (!WOW_P.WaitForInputIdle()) { Thread.Sleep(100); };
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
                Logging.Write(string.Format("执行SQL【{0}】时发生错误：", sql) + ex.ToString());
            }
        }

        private static DataTable GetTableData(string Table)
        {
            DataTable dt = new DataTable();
            try
            {
                dt = OraData.execSQL("select * from " + Table);
                return dt;
            }
            catch (Exception ex)
            {
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
                    foreach (DataRow DRWOWChar in DTWOWChar.Select("acc_name='" + SingleWOWAccount.AccountName + "'"))
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
            if (string.IsNullOrWhiteSpace(resultString)) return null;
            if (resultString.Contains("错误"))
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
                        bag.Add(split[iLoop], Convert.ToInt16(split[iLoop + 1]));
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
        public static bool lua_SendItemByName(string receiver, string itemname)
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
            if (!ExecSimpleLua(string.Format("/script SendItemByName(\"{0}\",\"{1}\")", receiver, itemname))) return false;
            MailFrame.ClickInboxTab();
            return true;
        }

        // 获取邮件
        public static bool lua_GetMAILAsItem(string ItemName, int ItemCount)
        {
            return lua_GetMAILAsItem(ItemName, ItemCount, 0);
        }

        public static bool lua_GetMAILAsItem(string ItemName, int ItemCount, int StackSize) //itemcount指的是，一次拿几堆
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
            if (StackSize == 0)
                return ExecSimpleLua(string.Format("/script GetMAILAsItem(\"{0}\",{1})", ItemName, ItemCount));
            else
                return ExecSimpleLua(string.Format("/script GetMAILAsItemFull(\"{0}\",{1},{2})", ItemName, ItemCount, StackSize));
        }

        public static void lua_GetAllMail()
        {
            ExecSimpleLua("/script GetAllMailDoor()");
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

            // 调用lua，收集背包物品信息
            KeyHelper.SendLuaOverChat(string.Format("/script AHSearchDoor(\"{0}\",1)", itemname));

            result = null;
            while (GetInfoFromFrame() == LUA_RUNNING_STRING)
            {
                Thread.Sleep(100);
            }

            string rtv = GetInfoFromFrame();
            if (rtv.Contains("错误"))
            {
                Logging.Write("获取信息错误");
                return result;
            }


            if (!string.IsNullOrWhiteSpace(rtv))
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
            if (ExecSimpleLua("/click AuctionFrameTab3"))
            {
                return ExecSimpleLua(string.Format("/script AHPostItemDoor(\"{0}\",{1},{2},{3})", ItemName, SinglePrize, StackSize, NumStack));
            }
            else
                return false;
        }

        // 运行没有返回值的LUA命令
        public static bool ExecSimpleLua(string LuaCmd)
        {
            if (MailFrame.CurrentTabIsSendMail) MailFrame.ClickInboxTab();
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
            return ExecSimpleLua(string.Format("/script SetDisplayItemName(\"{0}\")", ItemName));
        }

        public static bool lua_TradeSkillDO(string ItemName)
        {
            return ExecSimpleLua(string.Format("/script TradeSkillDO(\"{0}\")", ItemName));
        }

        public static bool OpenProfession(string pName)
        {
            while (InterfaceHelper.GetFrames.Count == 0)
            {
                Thread.Sleep(100);
            }
            Frame InfoFrame = InterfaceHelper.GetFrameByName("SpellbookMicroButton");
            InfoFrame.LeftClick();
            Thread.Sleep(500);
            InfoFrame = InterfaceHelper.GetFrameByName("SpellBookFrameTabButton2");
            InfoFrame.LeftClick();
            Thread.Sleep(500);
            return true;
        }

        public static Dictionary<string, int> GetDispCountItemCount()
        {
            Dictionary<string, int> ItemCount = new Dictionary<string, int>();
            ItemCount.Add("BAG", 0);
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
                logger.Add(string.Format("开始发送{0}到{1}", mail.Key, mail.Value));
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

        public static bool DoItems(string item)
        {
            return SpyFrame.lua_TradeSkillDO(item);
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
            logger.Add("[" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "]<" + toAppend + ">" + msg);
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

    //珠宝加工
    public static class SpyZBJG
    {
        public static Dictionary<string, int> CreationList;                 //制作列表(产品：数量)
        public static Dictionary<string, string> CreationMap;               //对照关系(产品：原料)
        public static Dictionary<string, string> MailList;                  //发货列表
        public static DBLogger logger = new DBLogger("珠宝加工+邮寄");

        public static void GoGo()
        {
            BarMapper.MapBars();
            KeyHelper.LoadKeys();
            DoAction();
            logger.output();
        }

        public static void DoAction()
        {
            // 打开邮箱
            if (!MailManager.TargetMailBox())
            {
                logger.Add("任务附近没有邮箱，失败啊。。。");
                return;
            }

            int CountJump = 0;
            foreach (KeyValuePair<string, int> Creation in CreationList)
            {
                string ToDoWhat = Creation.Key;
                int ToDoCount = Creation.Value;
                Dictionary<string, string> subMailList = new Dictionary<string, string>();
                subMailList.Add(ToDoWhat, MailList[ToDoWhat]);

                if (!SpyFrame.lua_SetDispCountItemName(CreationMap[ToDoWhat]))
                {
                    logger.Add(string.Format("在执行SetDispCountItemName时出错，需要制作{0}的原料{1}", ToDoWhat, CreationMap[ToDoWhat]));
                    return;
                }
                Thread.Sleep(1000);
                Dictionary<string, int> ItemCount = SpyFrame.GetDispCountItemCount();
                if (ItemCount["BAG"] == 0 && ItemCount["MAIL"] == 0)
                {
                    logger.Add(string.Format("在邮箱和背包中都没有找到{0}的原料{1}，跳过这个", ToDoWhat, CreationMap[ToDoWhat]));
                    continue;
                }
                int GetItemFromMail = 0;
                if (ItemCount["BAG"] + ItemCount["MAIL"] > ToDoCount)           //原料足够
                {
                    if (ItemCount["BAG"] > ToDoCount)
                        GetItemFromMail = 0;
                    else
                        GetItemFromMail = ToDoCount - ItemCount["BAG"];
                }
                else                                                            //原料不够
                {
                    GetItemFromMail = ItemCount["MAIL"];
                }

                if (Inventory.FreeBagSlots < 3)
                {
                    logger.Add(string.Format("背包空间应该大于3，否则无法进行"));
                    return;
                }

                int HasDone = 0;
                while (HasDone < ToDoCount)
                {
                    // 包剩余空间少于2，就开始邮寄
                    if (Inventory.FreeBagSlots <= 2)
                    {
                        // 发邮件
                        logger.Add("发邮件");
                        if (!SpyTradeSkill.SendMain(subMailList, logger)) return;
                    }
                    ItemCount = SpyFrame.GetDispCountItemCount();
                    if (ItemCount["BAG"] == 0 && ItemCount["MAIL"] == 0) break;
                    // 当前包有没有原料，有就做，没有就拿，拿的时候判断包空间，如果空间足够，就一次拿完
                    if (ItemCount["BAG"] > 0)
                    {
                        // 打开界面
                        bool ZB_frame;
                        try
                        {
                            ZB_frame = InterfaceHelper.GetFrameByName("TradeSkillFrame").IsVisible;
                        }
                        catch
                        {
                            ZB_frame = false;
                        }

                        if (!ZB_frame)
                        {
                            BarSpell gg = BarMapper.GetSpellByName("珠宝加工");
                            gg.CastSpell();
                        }
                        // 做东西
                        if (!SpyTradeSkill.DoItems(ToDoWhat))
                        {
                            logger.Add(string.Format("做{0}时出现错误", ToDoWhat));
                            return;
                        }
                        Thread.Sleep(100);
                        while (ObjectManager.MyPlayer.IsCasting)
                        {
                            Thread.Sleep(100);
                        }
                        HasDone += 1;
                        CountJump++;
                        if (CountJump == 10)
                        {
                            // jump一下，防止AFK
                            CountJump = 0;
                            logger.Add("jump一下，防止AFK");
                            KeyHelper.SendKey("Space");
                            Thread.Sleep(5000);
                        }
                    }
                    else
                    {
                        logger.Add(string.Format("从邮箱里面拿{0}的原料{1}", ToDoWhat, CreationMap[ToDoWhat]));
                        int GetItemCount = 0;
                        GetItemCount = ((Inventory.FreeBagSlots - 3) * 20 - HasDone > 0 ? ToDoCount - HasDone : (Inventory.FreeBagSlots - 3) * 20);
                        if (!SpyFrame.lua_GetMAILAsItem(CreationMap[ToDoWhat], GetItemCount, 0))
                        {
                            logger.Add(string.Format("从邮箱里面拿{0}的原料{1}失败", ToDoWhat, CreationMap[ToDoWhat]));
                            return;
                        }
                    }
                }
                // 发邮件
                logger.Add(string.Format("东西做完，发邮件"));
                if (!SpyTradeSkill.SendMain(subMailList, logger)) return;
            }
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
            BarMapper.MapBars();
            KeyHelper.LoadKeys();
            DoAction();
            logger.output();
        }

        public static void DoAction()
        {
            // 打开邮箱
            if (!MailManager.TargetMailBox())
            {
                logger.Add("任务附近没有邮箱，失败啊。。。");
                return;
            }

            int CountJump = 0;
            foreach (string DoingMine in Mines)
            {
                if (!SpyFrame.lua_SetDispCountItemName(DoingMine))
                {
                    logger.Add("在执行SetDispCountItemName时出错，矿：" + DoingMine);
                    return;
                }
                Thread.Sleep(1000);
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
                        if (!SpyFrame.lua_GetMAILAsItem(DoingMine, 100000, 20))
                        {
                            logger.Add("从邮箱里面拿  " + DoingMine + " 失败");
                            return;
                        }
                    }

                    Thread.Sleep(1000);
                    MineCount = SpyFrame.GetDispCountItemCount();

                    // 分解矿，直到包空间小于1和背包里面没有矿
                    while (MineCount["BAG"] > 0 && Inventory.FreeBagSlots > 1)
                    {
                        CountJump++;
                        if (CountJump == 10)
                        {
                            // jump一下，防止AFK
                            CountJump = 0;
                            logger.Add("jump一下，防止AFK");
                            KeyLowHelper.PressKey(MicrosoftVirtualKeys.Space);
                            KeyLowHelper.ReleaseKey(MicrosoftVirtualKeys.Space);
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
                    Thread.Sleep(1000);
                    MineCount = SpyFrame.GetDispCountItemCount();

                    // 邮寄完，背包还是满，就退出
                    if (Inventory.FreeBagSlots <= 1)
                    {
                        logger.Add("邮寄完，背包还是满");
                        return;
                    }
                }
            }
            logger.Add("矿都处理完了，发邮件");
            if (!SpyTradeSkill.SendMain(MailList, logger)) return;
            return;
        }
    }

    public static class SpyAH
    {
        public static DBLogger logger = new DBLogger("拿取邮件+找到拍卖师+AH上货");
        public static DataTable Items = new DataTable();

        /********              需要设置的内容                 ******************/
        // 邮箱点
        public static Location LocMailbox = new Location((float)Convert.ToDouble(-2039.034), (float)Convert.ToDouble(5351.313), (float)Convert.ToDouble(-9.351171));

        // 中间节点
        public static Location LocMid = new Location((float)Convert.ToDouble(-2014.044), (float)Convert.ToDouble(5364.521), (float)Convert.ToDouble(-9.351171));

        // AH拍卖师点
        public static Location LocAHer = new Location((float)Convert.ToDouble(-2023.114), (float)Convert.ToDouble(5388.722), (float)Convert.ToDouble(-8.289739));

        public static string AHerName = "拍卖师卡拉伦";

        public static void init()
        {
            // 从数据库表读取拍卖列表(ahitem)
            Items = SpyDB.GetAHList();
            //Items.PrimaryKey
            //Items.Columns.Add("item_name", System.Type.GetType("System.String"));
            //Items.Columns.Add("item_minprice", System.Type.GetType("System.Int32"));
            //Items.Columns.Add("item_maxprice", System.Type.GetType("System.Int32"));
            //Items.Columns.Add("item_count", System.Type.GetType("System.Int32"));
            //Items.Columns.Add("item_stacksize", System.Type.GetType("System.Int32"));
            //DataColumn[] pk = new DataColumn[1];
            //pk[0] = Items.Columns["item_name"];
            //Items.PrimaryKey = pk;
            //DataRow dr = dt.NewRow();
            //dr["column0"] = "AX";
            //dr["column1"] = true;
        }

        public static void gogo()
        {
            BarMapper.MapBars();
            KeyHelper.LoadKeys();
            DoAction();
            logger.output();
        }

        public static bool DoAction()
        {
            // 跑到邮箱点（计算到中间节点的距离和到邮箱的距离，选择路径）
            logger.Add("跑到邮箱点");

            if (LocMailbox.DistanceToSelf2D > LocMid.DistanceToSelf2D)
            {
                logger.Add("在靠近AHer这边，先跑到中间节点，然后去邮箱那边");
                if (!MoveHelper.MoveToLoc(LocMid, 2))
                {
                    logger.Add("跑到中间节点");
                    return false;
                }
            }

            if (!MoveHelper.MoveToLoc(LocMailbox, 2))
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

            //// 遍历物品，保证背包中有足够的拍卖品。这里要注意背包空间
            //logger.Add("遍历 待拍卖物品列表 ");
            //foreach (DataRow dr in Items.Rows)
            //{
            //    logger.Add("检查背包剩余空间");
            //    if (Inventory.FreeBagSlots <= 1)
            //    {
            //        logger.Add("检查背包剩余空间为1，不能继续");
            //        return false;
            //    }
            //    string AHSellItem = dr["item_name"].ToString();
            //    logger.Add("通过lua获知物品在背包和邮箱中的数量");
            //    if (!SpyFrame.lua_SetDispCountItemName(AHSellItem))
            //    {
            //        logger.Add("在执行SetDispCountItemName时出错，物品：" + AHSellItem);
            //        return false;
            //    }
            //    Thread.Sleep(500);
            //    Dictionary<string, int> MineCount = SpyFrame.GetDispCountItemCount();
            //    logger.Add(string.Format("物品{0}在背包中的数量为{1}，在邮箱中的数量为：{2}", AHSellItem, MineCount["BAG"], MineCount["MAIL"]));
            //    if (MineCount["BAG"] == 0 && MineCount["MAIL"] == 0) continue;
            //    //int WantCount = (int)dr["item_count"] * (int)dr["item_stacksize"] > MineCount["BAG"]
            //    //                ? (int)dr["item_count"] * (int)dr["item_stacksize"] - MineCount["BAG"]
            //    //                : 0
            //    //                ;
            //    //if (WantCount == 0) continue;
            //    //// 拿邮件(LUA)
            //    //logger.Add(string.Format("从邮箱中拿{0}个{1}", WantCount, mine));

            //    // 全拿东西，不考虑包包大小
            //    if (MineCount["MAIL"] > 0)
            //    {
            //        if (!SpyFrame.lua_GetMAILAsItem(AHSellItem, 100000))
            //        {
            //            logger.Add("从邮箱里面拿  " + AHSellItem + " 失败");
            //            return false;
            //        }
            //    }
            //    Thread.Sleep(1000);
            //}
            // 邮箱东西全拿
            SpyFrame.lua_GetAllMail();
            Thread.Sleep(2000);

            // 跑到邮箱点
            logger.Add("跑到中间节点");
            if (!MoveHelper.MoveToLoc(LocMid, 2))
            {
                logger.Add("跑到中间节点");
                return false;
            }

            // 跑到拍卖师身边
            logger.Add("跑到拍卖师身边");
            if (!MoveHelper.MoveToLoc(LocAHer, 2))
            {
                logger.Add("跑到拍卖师身边出错");
                return false;
            }
            // 找到拍卖师，打开拍卖界面
            logger.Add(string.Format("定位拍卖师：{0}", AHerName));
            PUnit aher = new PUnit(0);
            bool found = false;
            foreach (PUnit unit in ObjectManager.GetUnits)
            {
                if (unit.Name.Equals(AHerName) && unit.Location.DistanceToSelf2D < 5)
                {
                    //unit.Location.Face();
                    //unit.TargetFriend();
                    //unit.Interact();
                    aher = unit;
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                logger.Add(string.Format("没找到名字是{0}的拍卖师", AHerName));
                return false;
            }
            KeyHelper.SendLuaOverChat("/target " + AHerName);
            Thread.Sleep(500);
            if (!ObjectManager.MyPlayer.Target.Name.Equals(AHerName))
            {
                logger.Add(string.Format("没有命中拍卖师的目标"));
                return false;
            }
            aher.Location.Face();
            aher.InteractWithTarget();

            Thread.Sleep(2000);

            // 上货。 遍历待拍卖物品，扫描物品最低价格，最低价格不低于起拍价格，就上架
            logger.Add(string.Format("开始上货"));
            foreach (DataRow dr in Items.Rows)
            {
                // 扫描最低价格
                string ahitem = dr["item_name"].ToString();
                logger.Add(string.Format("扫描物品[{0}]的最低价格", ahitem));
                Dictionary<string, string> scanresult = SpyFrame.lua_AHSearchDoor(ahitem);
                if (scanresult == null)
                {
                    logger.Add(string.Format("获取物品[{0}]的最低价格出现错误，返回值为NULL", ahitem));
                    return false;
                }
                logger.Add(string.Format("物品[{0}]的最低价格是[{1}]，由[{2}]出价", ahitem, scanresult["PRIZE"], scanresult["SELLER"]));

                // 计算最低价格，准备上货
                if (scanresult["SELLER"].Equals(ObjectManager.MyPlayer.Name))
                {
                    logger.Add(string.Format("价格最低的就是我自己，所以不用上货"));
                    continue;
                }

                int prize, minprize, maxprize;
                maxprize = Convert.ToInt32(dr["item_maxprice"]);
                minprize = Convert.ToInt32(dr["item_minprice"]);

                // 如果目前出价低于心里价位，不出货
                if (Convert.ToInt32(scanresult["PRIZE"]) < minprize)
                {
                    logger.Add(string.Format("[{0}]出价低过心里价位[{1}]，暂时不出货", scanresult["PRIZE"], minprize));
                    continue;
                }

                if (scanresult["SELLER"].Equals("NOBODY"))
                {

                    logger.Add(string.Format("拍卖场没有人卖[{0}]，将按照数据库中记录的最高价格[{1}]上货", ahitem, maxprize));
                    prize = maxprize;
                }
                else
                {
                    if (maxprize < Convert.ToInt32(scanresult["PRIZE"]))
                        prize = maxprize;
                    else
                        prize = Convert.ToInt32(scanresult["PRIZE"]) - 1;
                    logger.Add(string.Format("进过计算，物品[{0}]将按照单价[{1}]上架", ahitem, prize));
                    // 取消拍卖物品
                    logger.Add(string.Format("取消AH中单价低于[{0}]的[{1}]", prize, ahitem));
                    if (!SpyFrame.lua_CancelAll(ahitem, prize))
                    {
                        logger.Add(string.Format("取消AH出错"));
                        return false;
                    }
                }
                // 上货
                int StackSize = (int)(dr["item_stacksize"]);
                int StackCount = (int)(dr["item_count"]);
                logger.Add(string.Format("开始拍卖单价为[{0}]的“{1}”[{2}]堆，每堆[{3}]个", prize, ahitem, StackCount, StackSize));
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

    public static class SpyFB
    {
        public static PPlayer leader;
        private static PPlayerSelf me = ObjectManager.MyPlayer;
        public static Location FBEntry;                             // 副本入口
        public static Location FBExit;                              // 副本出口

        public static Dictionary<int, Location> LeaderInFB;         // Step，坐标
        public static Dictionary<int, Location> memInFB;            // 路径编号，坐标
        public static Dictionary<int, int> MapOverLeaderAndMem;     // 小号路径编号，大号step

        public static string FBEndPass = "OKOK";
        public static string FBInPass = "ININ";
        private static string LeaderName = "";

        private static int Scope = 5;
        private static int LastLeaderStep;

        private static Thread _Thread;
        private static DBStatus FBStatus;
        private static ActionStatus _Action;

        enum DBStatus
        {
            In_EntryChecking,           //入口检查，确定是否可以开始
            In_LeaderInScopeCheck,      //检查Leader有没有到达预定地点
            In_Running,                 //小号进行本阶段的跑路
            In_CheckIsOut,              //等待大号发出暗语，准备往回跑
            InOut_GoOut,
            Out_Exiting,                //正在退出副本，读条状态
            Out_ExitDone,               //读条结束
            Out_following,              //正在跟随大号
            In_Entering,                //正在进入副本，读条状态
            In_AlreadyEnter             //进入副本
        }

        enum ActionStatus
        {
            Nothing,
            OutFB,
            InFB
        }

        public static bool Init(string _leadername, Location _fbin, Location _fbout, Dictionary<int, Location> _lloc, Dictionary<int, Location> _path, Dictionary<int, int> _map)
        {
            LastLeaderStep = 0;
            FBStatus = DBStatus.In_EntryChecking;
            _Action = ActionStatus.Nothing;
            LeaderName = _leadername;
            if (!SetLeader()) return false;
            FBEntry = _fbin;
            FBExit = _fbout;
            LeaderInFB = _lloc;
            memInFB = _path;
            MapOverLeaderAndMem = _map;
            return true;
        }

        public static void StartFB()
        {
            BarMapper.MapBars();
            KeyHelper.LoadKeys();

            if (_Thread == null || !_Thread.IsAlive)
            {
                _Thread = new Thread(gogo);
                _Thread.Name = "FB";
                _Thread.IsBackground = true;
                _Thread.Start();
                Logging.Write("开始了。。。。。");
            }
        }

        public static void StopFB()
        {
            _Thread.Abort();
            _Thread = null;
        }

        private static void gogo()
        {
            Dictionary<int, Location> nowpath = new Dictionary<int, Location>();
            while (true)
            {
                switch (FBStatus)
                {
                    case DBStatus.In_EntryChecking:
                        while (!SetLeader()) ;
                        if (CanStart())
                        {
                            LastLeaderStep = 0;
                            FBStatus = DBStatus.In_LeaderInScopeCheck;
                            Logging.Write("检查大号是不是在范围内");
                        }
                        break;

                    case DBStatus.In_LeaderInScopeCheck:
                        if (IsLeaderInScope())
                        {
                            nowpath = GetMemPath();
                            FBStatus = DBStatus.In_Running;
                            Logging.Write(string.Format("第{0}次跑路。。。。", LastLeaderStep + 1));
                        }
                        break;

                    case DBStatus.In_Running:
                        if (MeGoGo(nowpath))
                        {
                            if (LastLeaderStep == LeaderInFB.Keys.Max())
                            {
                                FBStatus = DBStatus.In_CheckIsOut;
                                Logging.Write(string.Format("等待大号暗语，准备出本"));
                            }
                            else
                            {
                                FBStatus = DBStatus.In_LeaderInScopeCheck;
                            }
                            LastLeaderStep++;
                        }
                        break;
                    case DBStatus.In_CheckIsOut:
                        if (_Action == ActionStatus.OutFB)
                        {
                            Logging.Write(string.Format("收到暗语，出本！！！"));
                            MeGoGo(GetMemOutPath());

                            //出副本
                            Thread.Sleep(200);
                            FBExit.Face();
                            KeyHelper.PressKey("Up");
                            while (ObjectManager.InGame) Thread.Sleep(100);
                            KeyHelper.ReleaseKey("Up");
                            Thread.Sleep(2000);
                            while (!ObjectManager.InGame) Thread.Sleep(100);
                            _Action = ActionStatus.Nothing;
                            Logging.Write(string.Format("出来了，等待暗语，准备进本"));
                            FBStatus = DBStatus.Out_ExitDone;
                        }
                        break;
                    case DBStatus.Out_ExitDone:
                        if (_Action == ActionStatus.InFB)
                        {
                            FBStatus = DBStatus.Out_following;
                            _Action = ActionStatus.Nothing;
                        }
                        break;
                    case DBStatus.Out_following:
                        Logging.Write(string.Format("进本！！！"));
                        FBEntry.Face();
                        KeyHelper.PressKey("Up");
                        while (ObjectManager.InGame) Thread.Sleep(100);
                        KeyHelper.ReleaseKey("Up");
                        Thread.Sleep(2000);
                        while (!ObjectManager.InGame) Thread.Sleep(100);
                        Logging.Write(string.Format("又开始了。。。。。"));
                        FBStatus = DBStatus.In_EntryChecking;
                        break;

                }
                Thread.Sleep(100);
            }
        }

        private static bool SetLeader()
        {
            foreach (PPlayer unit in ObjectManager.GetPlayers)
            {
                if (unit.Name.Equals(LeaderName))
                {
                    leader = unit;
                    return true;
                }
            }
            return false;
        }

        // 是否能开始
        private static bool CanStart()
        {
            // 要求2个人都在副本区域内才能开始
            if (leader.Name.Equals(LeaderName))
                return true;
            else
                return false;
        }

        private static bool IsLeaderInScope()
        {
            //if (!LeaderInFB.ContainsKey(LastLeaderStep)) return false;
            double dd = leader.Location.DistanceFromXY(LeaderInFB[LastLeaderStep]);
            if (dd < Scope)
            {
                return true;
            }
            return false;
        }

        // 获取路点地图
        private static Dictionary<int, Location> GetMemPath()
        {
            Dictionary<int, Location> path = new Dictionary<int, Location>();

            foreach (KeyValuePair<int, int> mm in MapOverLeaderAndMem)
            //foreach (KeyValuePair<int, Location> mm in memInFB)
            {
                if (mm.Value == LastLeaderStep)
                {
                    path.Add(mm.Key, memInFB[mm.Key]);
                }
            }
            var tmppath = from pair in path orderby pair.Key select pair;
            //path.Clear();
            Dictionary<int, Location> path1 = new Dictionary<int, Location>();
            //return (Dictionary<int, Location>)path1;
            foreach (KeyValuePair<int, Location> dd in tmppath)
            {
                path1.Add(dd.Key, dd.Value);
            }
            return path1;
        }

        // 出副本地图
        private static Dictionary<int, Location> GetMemOutPath()
        {
            Dictionary<int, Location> path = new Dictionary<int, Location>();
            var tmppath = from pair in memInFB orderby pair.Key descending select pair;
            foreach (KeyValuePair<int, Location> dd in tmppath)
            {
                path.Add(dd.Key, dd.Value);
            }
            return path;
        }

        // 根据路点跑
        private static bool MeGoGo(Dictionary<int, Location> path)
        {
            Ticker StuckTimer = new Ticker(300000); //5 min
            Ticker _stuckTimer = new Ticker(3000);
            foreach (KeyValuePair<int, Location> dest in path)
            {
                Location _destination = dest.Value;
                double _stopDistance = 1;

                int stuck = 0;
                double destinationDistance = _destination.DistanceToSelf2D;
                while (destinationDistance > _stopDistance)
                {
                    destinationDistance = _destination.DistanceToSelf2D;
                    if (LazyEvo.LGrindEngine.Helpers.Stuck.IsStuck && _stuckTimer.IsReady)
                    {
                        LazyEvo.LGrindEngine.Helpers.Unstuck.TryUnstuck();
                        _stuckTimer.Reset();
                        stuck++;
                    }
                    if (StuckTimer.IsReady)
                    {
                        stuck = 0;
                    }
                    if (stuck > 6)
                    {
                        // Stuck more than 6 times in 5 min 卡壳在5分钟之内，超过6次
                        MoveHelper.ReleaseKeys();
                        return false;
                    }
                    if (destinationDistance > _stopDistance)
                    {
                        if (!_destination.IsFacing(0.2f))
                        {
                            _destination.Face();
                        }
                        KeyHelper.PressKey("Up");
                    }
                    else
                    {
                        MoveHelper.ReleaseKeys();
                    }
                    Thread.Sleep(10);
                }
            }
            return true;

        }

        // 看看传过来的信息里面，包不包含暗语，做一个翻译，设置相应状态
        public static void CheckPassword(string msg)
        {
            if (msg.ToUpper().Contains(LeaderName) && msg.ToUpper().Contains(FBEndPass))
            {
                _Action = ActionStatus.OutFB;
                return;
            }
            if (msg.ToUpper().Contains(LeaderName) && msg.ToUpper().Contains(FBInPass))
            {
                _Action = ActionStatus.InFB;
                return;
            }
        }


        /******************************************
         * 根据法术名字获得动作条
         *  BarSpell gg = BarMapper.GetSpellByName("");
         *  gg.CastSpell();
         *  
         *  BarMapper.MapBars();
         *  KeyHelper.LoadKeys();
         * ****************************************/

        public static void XSXDY_MD(string DaHao)                   //墓地——血色
        {
            if (string.IsNullOrWhiteSpace(DaHao))
            {
                Logging.Write("没提供大号的名字");
                return;
            }
            Dictionary<int, Location> small = new Dictionary<int, Location>();
            Dictionary<int, Location> large = new Dictionary<int, Location>();
            Dictionary<int, int> mapp = new Dictionary<int, int>();

            large.Add(0, new Location((float)Convert.ToDouble(1703.884), (float)Convert.ToDouble(1097.721), (float)Convert.ToDouble(6.820244)));
            large.Add(1, new Location((float)Convert.ToDouble(1797.786), (float)Convert.ToDouble(1167.898), (float)Convert.ToDouble(6.820681)));
            large.Add(2, new Location((float)Convert.ToDouble(1797.543), (float)Convert.ToDouble(1390.579), (float)Convert.ToDouble(21.0289)));

            small.Add(0, new Location((float)Convert.ToDouble(1687.463), (float)Convert.ToDouble(1052.708), (float)Convert.ToDouble(18.6773)));
            small.Add(1, new Location((float)Convert.ToDouble(1702.782), (float)Convert.ToDouble(1053.758), (float)Convert.ToDouble(18.49206)));
            small.Add(2, new Location((float)Convert.ToDouble(1702.369), (float)Convert.ToDouble(1098.05), (float)Convert.ToDouble(6.820761)));

            small.Add(3, new Location((float)Convert.ToDouble(1710.781), (float)Convert.ToDouble(1097.89), (float)Convert.ToDouble(6.820291)));
            small.Add(4, new Location((float)Convert.ToDouble(1732.834), (float)Convert.ToDouble(1097.47), (float)Convert.ToDouble(6.820291)));
            small.Add(5, new Location((float)Convert.ToDouble(1755.895), (float)Convert.ToDouble(1097.032), (float)Convert.ToDouble(6.820291)));
            small.Add(6, new Location((float)Convert.ToDouble(1758.96), (float)Convert.ToDouble(1108.889), (float)Convert.ToDouble(7.490634)));
            small.Add(7, new Location((float)Convert.ToDouble(1759.459), (float)Convert.ToDouble(1140.953), (float)Convert.ToDouble(7.490634)));
            small.Add(8, new Location((float)Convert.ToDouble(1781.824), (float)Convert.ToDouble(1147.978), (float)Convert.ToDouble(7.490634)));
            small.Add(9, new Location((float)Convert.ToDouble(1783.685), (float)Convert.ToDouble(1167.668), (float)Convert.ToDouble(6.82066)));
            small.Add(10, new Location((float)Convert.ToDouble(1797.073), (float)Convert.ToDouble(1167.381), (float)Convert.ToDouble(6.82066)));

            small.Add(11, new Location((float)Convert.ToDouble(1797.499), (float)Convert.ToDouble(1173.833), (float)Convert.ToDouble(6.82066)));
            small.Add(12, new Location((float)Convert.ToDouble(1796.883), (float)Convert.ToDouble(1204.196), (float)Convert.ToDouble(18.49159)));
            small.Add(13, new Location((float)Convert.ToDouble(1797.17), (float)Convert.ToDouble(1223.217), (float)Convert.ToDouble(18.19079)));
            small.Add(14, new Location((float)Convert.ToDouble(1796.428), (float)Convert.ToDouble(1259.853), (float)Convert.ToDouble(18.39784)));
            small.Add(15, new Location((float)Convert.ToDouble(1795.763), (float)Convert.ToDouble(1292.662), (float)Convert.ToDouble(18.58248)));
            small.Add(16, new Location((float)Convert.ToDouble(1797.835), (float)Convert.ToDouble(1309.065), (float)Convert.ToDouble(18.67566)));
            small.Add(17, new Location((float)Convert.ToDouble(1788.97), (float)Convert.ToDouble(1322.456), (float)Convert.ToDouble(18.90245)));
            small.Add(18, new Location((float)Convert.ToDouble(1794.272), (float)Convert.ToDouble(1352.333), (float)Convert.ToDouble(18.88878)));
            small.Add(19, new Location((float)Convert.ToDouble(1797.968), (float)Convert.ToDouble(1390.656), (float)Convert.ToDouble(21.06569)));

            mapp.Add(0, 0);
            mapp.Add(1, 0);
            mapp.Add(2, 0);
            mapp.Add(3, 1);
            mapp.Add(4, 1);
            mapp.Add(5, 1);
            mapp.Add(6, 1);
            mapp.Add(7, 1);
            mapp.Add(8, 1);
            mapp.Add(9, 1);
            mapp.Add(10, 1);
            mapp.Add(11, 2);
            mapp.Add(12, 2);
            mapp.Add(13, 2);
            mapp.Add(14, 2);
            mapp.Add(15, 2);
            mapp.Add(16, 2);
            mapp.Add(17, 2);
            mapp.Add(18, 2);
            mapp.Add(19, 2);

            Location inPoint = new Location((float)Convert.ToDouble(2915.34), (float)Convert.ToDouble(-771.58), (float)Convert.ToDouble(160.333));
            Location outPoint = new Location((float)Convert.ToDouble(1687.27), (float)Convert.ToDouble(1020.09), (float)Convert.ToDouble(18.6773));

            SpyFB.Init(DaHao, inPoint, outPoint, large, small, mapp);
            SpyFB.StartFB();
        }

        public static void XSXDY_TSG(string DaHao)              //图书馆-血色
        {
            if (string.IsNullOrWhiteSpace(DaHao))
            {
                Logging.Write("没提供大号的名字");
                return;
            }
            Dictionary<int, Location> small = new Dictionary<int, Location>();
            Dictionary<int, Location> large = new Dictionary<int, Location>();
            Dictionary<int, int> mapp = new Dictionary<int, int>();

            large.Add(0, new Location((float)Convert.ToDouble(874.6886), (float)Convert.ToDouble(1399.048), (float)Convert.ToDouble(18.00647)));
            large.Add(1, new Location((float)Convert.ToDouble(974.805), (float)Convert.ToDouble(1379.996), (float)Convert.ToDouble(21.97392)));
            large.Add(2, new Location((float)Convert.ToDouble(1065.205), (float)Convert.ToDouble(1398.764), (float)Convert.ToDouble(30.76385)));

            small.Add(0, new Location((float)Convert.ToDouble(853.2313), (float)Convert.ToDouble(1322.512), (float)Convert.ToDouble(18.67164)));
            small.Add(1, new Location((float)Convert.ToDouble(870.9263), (float)Convert.ToDouble(1322.137), (float)Convert.ToDouble(18.00613)));
            small.Add(2, new Location((float)Convert.ToDouble(870.5344), (float)Convert.ToDouble(1338.765), (float)Convert.ToDouble(18.00613)));
            small.Add(3, new Location((float)Convert.ToDouble(870.0039), (float)Convert.ToDouble(1361.277), (float)Convert.ToDouble(18.00613)));
            small.Add(4, new Location((float)Convert.ToDouble(869.5035), (float)Convert.ToDouble(1382.509), (float)Convert.ToDouble(18.00613)));

            small.Add(5, new Location((float)Convert.ToDouble(869.079), (float)Convert.ToDouble(1400.522), (float)Convert.ToDouble(18.00613)));
            small.Add(6, new Location((float)Convert.ToDouble(881.2842), (float)Convert.ToDouble(1399.369), (float)Convert.ToDouble(18.67652)));
            small.Add(7, new Location((float)Convert.ToDouble(891.8546), (float)Convert.ToDouble(1399.188), (float)Convert.ToDouble(18.6765)));
            small.Add(8, new Location((float)Convert.ToDouble(909.7885), (float)Convert.ToDouble(1399.16), (float)Convert.ToDouble(18.02418)));
            small.Add(9, new Location((float)Convert.ToDouble(910.191), (float)Convert.ToDouble(1376.08), (float)Convert.ToDouble(17.99018)));
            small.Add(10, new Location((float)Convert.ToDouble(944.8943), (float)Convert.ToDouble(1377.826), (float)Convert.ToDouble(18.02216)));
            small.Add(11, new Location((float)Convert.ToDouble(972.0721), (float)Convert.ToDouble(1379.498), (float)Convert.ToDouble(20.64153)));

            small.Add(12, new Location((float)Convert.ToDouble(985.4244), (float)Convert.ToDouble(1379.664), (float)Convert.ToDouble(24.29541)));
            small.Add(13, new Location((float)Convert.ToDouble(986.4362), (float)Convert.ToDouble(1363.739), (float)Convert.ToDouble(27.2986)));
            small.Add(14, new Location((float)Convert.ToDouble(1012.446), (float)Convert.ToDouble(1364.28), (float)Convert.ToDouble(27.30698)));
            small.Add(15, new Location((float)Convert.ToDouble(1049.201), (float)Convert.ToDouble(1393.344), (float)Convert.ToDouble(27.30282)));


            mapp.Add(0, 0);
            mapp.Add(1, 0);
            mapp.Add(2, 0);
            mapp.Add(3, 0);
            mapp.Add(4, 0);
            mapp.Add(5, 1);
            mapp.Add(6, 1);
            mapp.Add(7, 1);
            mapp.Add(8, 1);
            mapp.Add(9, 1);
            mapp.Add(10, 1);
            mapp.Add(11, 1);
            mapp.Add(12, 2);
            mapp.Add(13, 2);
            mapp.Add(14, 2);
            mapp.Add(15, 2);

            Location inPoint = new Location((float)Convert.ToDouble(2926.667), (float)Convert.ToDouble(-813.0659), (float)Convert.ToDouble(160.327));
            Location outPoint = new Location((float)Convert.ToDouble(859.032), (float)Convert.ToDouble(1306.221), (float)Convert.ToDouble(18.67159));

            SpyFB.Init(DaHao, inPoint, outPoint, large, small, mapp);
            SpyFB.StartFB();
        }

        public static void STSM_For(string DaHao)              //STSM-前门
        {
            if (string.IsNullOrWhiteSpace(DaHao))
            {
                Logging.Write("没提供大号的名字");
                return;
            }
            Dictionary<int, Location> small = new Dictionary<int, Location>();
            Dictionary<int, Location> large = new Dictionary<int, Location>();
            Dictionary<int, int> mapp = new Dictionary<int, int>();

            large.Add(0, new Location((float)Convert.ToDouble(3552.746), (float)Convert.ToDouble(-3390.129), (float)Convert.ToDouble(133.6904)));
            large.Add(1, new Location((float)Convert.ToDouble(3634.392), (float)Convert.ToDouble(-3335.104), (float)Convert.ToDouble(123.8209)));
            large.Add(2, new Location((float)Convert.ToDouble(3694.374), (float)Convert.ToDouble(-3252.993), (float)Convert.ToDouble(126.9459)));
            large.Add(3, new Location((float)Convert.ToDouble(3647.75), (float)Convert.ToDouble(-3123.231), (float)Convert.ToDouble(134.7812)));
            large.Add(4, new Location((float)Convert.ToDouble(3577.48), (float)Convert.ToDouble(-3065.235), (float)Convert.ToDouble(135.6654)));

            small.Add(0, new Location((float)Convert.ToDouble(3394.787), (float)Convert.ToDouble(-3378.851), (float)Convert.ToDouble(142.7063)));
            small.Add(1, new Location((float)Convert.ToDouble(3458.428), (float)Convert.ToDouble(-3380.6), (float)Convert.ToDouble(139.2054)));
            small.Add(2, new Location((float)Convert.ToDouble(3548.421), (float)Convert.ToDouble(-3383.074), (float)Convert.ToDouble(132.8665)));
            small.Add(3, new Location((float)Convert.ToDouble(3549.881), (float)Convert.ToDouble(-3331.992), (float)Convert.ToDouble(129.3269)));
            small.Add(4, new Location((float)Convert.ToDouble(3582.671), (float)Convert.ToDouble(-3335.25), (float)Convert.ToDouble(127.8763)));
            small.Add(5, new Location((float)Convert.ToDouble(3625.19), (float)Convert.ToDouble(-3335.013), (float)Convert.ToDouble(122.9529)));
            small.Add(6, new Location((float)Convert.ToDouble(3656.602), (float)Convert.ToDouble(-3334.31), (float)Convert.ToDouble(123.6646)));
            small.Add(7, new Location((float)Convert.ToDouble(3687.047), (float)Convert.ToDouble(-3289.592), (float)Convert.ToDouble(128.2343)));
            small.Add(8, new Location((float)Convert.ToDouble(3695.337), (float)Convert.ToDouble(-3254.503), (float)Convert.ToDouble(127.0161)));
            small.Add(9, new Location((float)Convert.ToDouble(3680.442), (float)Convert.ToDouble(-3215.124), (float)Convert.ToDouble(127.1871)));
            small.Add(10, new Location((float)Convert.ToDouble(3673.885), (float)Convert.ToDouble(-3193.536), (float)Convert.ToDouble(126.2168)));
            small.Add(11, new Location((float)Convert.ToDouble(3670.725), (float)Convert.ToDouble(-3172.513), (float)Convert.ToDouble(126.4293)));
            small.Add(12, new Location((float)Convert.ToDouble(3639.522), (float)Convert.ToDouble(-3128.482), (float)Convert.ToDouble(134.7796)));
            small.Add(13, new Location((float)Convert.ToDouble(3652.425), (float)Convert.ToDouble(-3119.892), (float)Convert.ToDouble(134.7803)));
            small.Add(14, new Location((float)Convert.ToDouble(3642.929), (float)Convert.ToDouble(-3106.38), (float)Convert.ToDouble(134.1169)));
            small.Add(15, new Location((float)Convert.ToDouble(3654.825), (float)Convert.ToDouble(-3098.323), (float)Convert.ToDouble(134.1169)));
            small.Add(16, new Location((float)Convert.ToDouble(3641.787), (float)Convert.ToDouble(-3080.266), (float)Convert.ToDouble(134.121)));
            small.Add(17, new Location((float)Convert.ToDouble(3606.12), (float)Convert.ToDouble(-3105.424), (float)Convert.ToDouble(134.121)));
            small.Add(18, new Location((float)Convert.ToDouble(3580.596), (float)Convert.ToDouble(-3069.592), (float)Convert.ToDouble(135.6633)));

            mapp.Add(0, 0);
            mapp.Add(1, 0);
            mapp.Add(2, 0);
            mapp.Add(3, 1);
            mapp.Add(4, 1);
            mapp.Add(5, 1);
            mapp.Add(6, 2);
            mapp.Add(7, 2);
            mapp.Add(8, 2);
            mapp.Add(9, 3);
            mapp.Add(10, 3);
            mapp.Add(11, 3);
            mapp.Add(12, 3);
            mapp.Add(13, 3);
            mapp.Add(14, 4);
            mapp.Add(15, 4);
            mapp.Add(16, 4);
            mapp.Add(17, 4);
            mapp.Add(18, 4);

            Location inPoint = new Location((float)Convert.ToDouble(3392.912), (float)Convert.ToDouble(-3304.423), (float)Convert.ToDouble(142.2488));
            Location outPoint = new Location((float)Convert.ToDouble(3392.055), (float)Convert.ToDouble(-3496.787), (float)Convert.ToDouble(143.07));

            SpyFB.Init(DaHao, inPoint, outPoint, large, small, mapp);
            SpyFB.StartFB();
        }
    }

    public static class SpyData
    {
        public static void GetAllItem()
        {
            for (int iloop = 1; iloop < 100000; iloop++)
            {
                Logging.Write(string.Format("正在处理{0}........", Convert.ToString(iloop)));
                Dictionary<string, string> hhh = WowHeadData.GetWowHeadItem(iloop);
                if (hhh != null)
                {
                    string name = hhh["name"];
                    string quality = hhh["quality"];
                    if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(quality))
                    {
                        name = name.Replace("'", "''");
                        string sql = string.Format("begin add_item('{0}','{1}','{2}'); end;", Convert.ToString(iloop), name, quality);
                        Logging.Write(sql);
                        if (!OraData.execSQLCmd(sql))
                        {
                            Logging.Write(string.Format("处理{0}时，出现错误", Convert.ToString(iloop)));
                        }
                    }
                }
            }
        }
        public static void GetAllSpell()
        {
            for (int iloop = 1; iloop < 100000; iloop++)
            {
                Logging.Write(string.Format("正在处理{0}........", Convert.ToString(iloop)));
                string name = WowHeadData.GetWowHeadSpell(iloop);
                if (name != null)
                {
                    if (!string.IsNullOrEmpty(name))
                    {
                        name = name.Replace("'", "''");
                        string sql = string.Format("begin add_spell('{0}','{1}'); end;", Convert.ToString(iloop), name);
                        Logging.Write(sql);
                        if (!OraData.execSQLCmd(sql))
                        {
                            Logging.Write(string.Format("处理{0}时，出现错误", Convert.ToString(iloop)));
                        }
                    }
                }
            }
        }
    }

    public static class SpyDB
    {
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

            foreach (DataRow dr in dt.Rows)
            {
                chars.Add(dr["char_id"].ToString(), dr["char_name"].ToString());
            }
            return chars;
        }

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
            return result;
        }

        public static DataTable GetAHList()
        {
            DataTable ahitems;
            string sql = "select * from ahitem";
            ahitems = OraData.execSQL(sql);
            if (ahitems.Columns.Count == 0)
            {
                Logging.Write(string.Format("处理{0}时，出现错误", sql));
                return ahitems;
            }
            return ahitems;
        }
    }

}