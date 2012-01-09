using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Globalization;

namespace LazyEvo.Plugins
{
    public class WTFFile
    {
        private const String WTF_FILE_NAME = "\\WTF\\Config.wtf";
        
        public static String errMsg;

        public static bool ChangeWTF(String WOWPath, String AccountName, String RealmName, String CharIdx, String AccountList)
        {
            
            bool isFoundAccountName = false;
            bool isFoundRealmName = false;
            bool isFoundAccountList = false;
            bool isFoundCharIdx = false;

            String WTFFile;

            if (String.IsNullOrEmpty(WOWPath))
            {
                errMsg = "WTFPath is null";
                return false; 
            }

            if (String.IsNullOrEmpty(AccountName)) 
            {
                errMsg = "AccountName is null";
                return false;
            }

            if (String.IsNullOrEmpty(RealmName)) 
            {
                errMsg = "RealmName is null";
                return false;
            }

            if (String.IsNullOrEmpty(CharIdx)) 
            {
                errMsg = "CharIdx is null";
                return false;
            }

            WTFFile = String.Concat(WOWPath , WTF_FILE_NAME);

            if (!File.Exists(WTFFile))
            {
                errMsg = "文件不存在";
                return false;
            }

            String filecontext = "";
            bool isFirstLine = true;
            CompareInfo Compare = CultureInfo.InvariantCulture.CompareInfo;
            try{
                FileStream file = new FileStream(WTFFile, FileMode.Open, FileAccess.Read);
                StreamReader sr = new StreamReader(file, System.Text.Encoding.UTF8);
                while (sr.Peek() >= 0)
                {
                    string newline = sr.ReadLine();

                    if (Compare.IndexOf(newline, "accountname", CompareOptions.IgnoreCase) != -1)
                    {
                        newline = "set accountname \"" + AccountName + "\"";
                        isFoundAccountName = true;
                    }
                    if (Compare.IndexOf(newline, "realmName", CompareOptions.IgnoreCase) != -1)
                    {
                        newline = "set realmName \"" + RealmName + "\"";
                        isFoundRealmName = true;
                    }
                    if (Compare.IndexOf(newline, "lastCharacterIndex", CompareOptions.IgnoreCase) != -1)
                    {
                        newline = "set lastCharacterIndex \"" + CharIdx + "\"";
                        isFoundCharIdx = true;
                    }
                    if (Compare.IndexOf(newline, "accountList", CompareOptions.IgnoreCase) != -1)
                    {
                        isFoundAccountList = true;
                        if (!String.IsNullOrEmpty(AccountList))
                        {
                            newline = "set accountList \"" + AccountList + "\"";
                        }
                        else
                        {
                            newline = "";
                        }
                    }

                    if (isFirstLine)
                    {
                        filecontext = newline;
                    }
                    else
                    {
                        filecontext = filecontext + "\r\n" + newline;
                    }

                    isFirstLine = false;
                }

                if (!isFoundAccountName)
                {
                    filecontext = filecontext + "\r\n" + "set accountname \"" + AccountName + "\"";
                }
                if (!isFoundRealmName)
                {
                    filecontext = filecontext + "\r\n" + "set realmName \"" + RealmName + "\"";
                }
                if (!isFoundAccountList)
                {
                    if (!String.IsNullOrEmpty(AccountList))
                    {
                        filecontext = filecontext + "\r\n" + "set accountList \"" + AccountList + "\"";
                    }
                }
                if (!isFoundCharIdx)
                {
                    filecontext = filecontext + "\r\n" + "set lastCharacterIndex \"" + CharIdx + "\"";
                }

                sr.Close();
                file.Close();

                file = new FileStream(WTFFile, FileMode.Truncate, FileAccess.Write);
                StreamWriter sw = new StreamWriter(file, System.Text.Encoding.UTF8);
                sw.Write(filecontext);
                sw.Flush();
                sw.Close();
                file.Close();
            }
            catch (Exception ex)
            {
                errMsg = ex.ToString();
                return false;
            }
            
            return true;
        }
    }
}
