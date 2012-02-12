using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;

namespace LazyLib.SPY
{
    public static class OraData
    {
        private static OracleConnection conn;
        private static bool isConnected;
        private static string connString = "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.26.170)(PORT=1521))(CONNECT_DATA=(SID=elmp)));User Id=wow;Password=wow123;";
        private static Thread _thread;

        public static void SetIP(string ipaddr, string sid)
        {
            connString = string.Format("Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST={0})(PORT=1521))(CONNECT_DATA=(SID={1})));User Id=wow;Password=wow123;", ipaddr, sid);
        }

        private static void OraConnect()
        {

            isConnected = false;
            SetIP(LazySettings.DBIP, LazySettings.DBSid);
            try
            {
                conn = new OracleConnection(connString);
                conn.Open();
                isConnected = true;
                KeepConntion();
            }
            catch (Exception ex)
            {
                Logging.Write(ex.ToString());
            }
        }

        private static void OraClose()
        {

            try
            {
                if (isConnected) conn.Close();
                isConnected = false;
            }
            catch (Exception ex)
            {
                Logging.Write(ex.ToString());
            }
        }

        /// <summary>
        /// 通过线程每隔一点时间刷数据库，保持连接
        /// </summary>
        public static void KeepConntion()
        {
            _thread = new Thread(LoopDual);
            _thread.Name = "KeepOracleConnection";
            _thread.IsBackground = true;
            // 设置线程状态为单线程
            try
            {
                _thread.TrySetApartmentState(ApartmentState.STA);
            }
            catch (Exception ex)
            {
                Logging.Write("KeepConntion 启动失败，线程设置出现错误，原因是：" + ex.ToString());
                return;
            }
            _thread.Start();
        }

        public static void LoopDual()
        {
            while (true)
            {
                try
                {
                    if (!isConnected) conn.Open();
                    OracleCommand cmd = new OracleCommand("select 1 from dual", conn);
                    isConnected = true;
                }
                catch
                {
                    isConnected = false;
                    Thread.Sleep(2000);
                    continue;
                }

                Thread.Sleep(60000);
            }
        }

        public static bool execSQLCmd(string sql)
        {
            try
            {
                if (!isConnected) OraConnect();
                OracleCommand cmd = new OracleCommand(sql, conn);
                int rtv = cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                Logging.Write(string.Format("执行SQL语句出现错误，语句是：[{0}]\r\n",sql)+ex.ToString());
                return false;
            }
        }

        public static DataTable execSQL(string sql)
        {
            DataTable dt = new DataTable();
            try
            {
                if (!isConnected) OraConnect();
                OracleDataAdapter oda = new OracleDataAdapter(sql, conn);
                oda.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                Logging.Write(ex.ToString());
                return dt;
            }
        }

        /// <summary>
        /// 从数据库中读取文件内容，并写入磁盘。type = 1 表示地图文件，其他值表示战斗文件。name是关键字
        /// </summary>
        public static bool GetFileFromDB(int file_type, string Name, string Path)
        {
            Logging.Write("[[["+Name+"]]]]");
            Logging.Write(Path);
            FileStream mapfs;
            bool HasRecord = false;
            try
            {
                string sql;
                if (file_type == 1)
                {
                    sql = string.Format("select file_name,file_context from map_file where map_name = '{0}'", Name);
                }
                else
                {
                    sql = string.Format("select file_name,file_context from fight_file where roll_type = '{0}'", Name);
                }

                DataTable dt = execSQL(sql);
                string filename = "";
                string fileContext = "";
                foreach (DataRow dr in dt.Rows)
                {
                    HasRecord = true;
                    filename = dr["file_name"].ToString();
                    fileContext = dr["file_context"].ToString();
                }
                Logging.Write(Path + "\\" + filename);
                if (File.Exists(Path + "\\" + filename))
                {
                    mapfs = new FileStream(Path + "\\" + filename, FileMode.Truncate, FileAccess.Write);
                }
                else
                {
                    if (!Directory.Exists(Path)) Directory.CreateDirectory(Path);
                    mapfs = new FileStream(Path + "\\" + filename, FileMode.CreateNew, FileAccess.Write);
                }
                StreamWriter sw = new StreamWriter(mapfs, System.Text.Encoding.UTF8);
                sw.Write(fileContext);
                sw.Flush();
                sw.Close();
                mapfs.Close();
            }
            catch (Exception ex)
            {
                Logging.Write("SaveFile Error : " + ex.ToString());
                return false;
            }

            if (!HasRecord)
            {
                Logging.Write("SaveFile Error : 没有记录");
                return false;
            }
            return true;
        }

        /// <summary>
        /// 文件写入到 Oracle Blob 字段中。type = 1 表示地图文件，其他值表示战斗文件
        /// </summary>
        public static bool SaveFileToDB(int file_type, string DBKey, string FullFileName)
        {
            FileStream mapfs;
            try
            {
                mapfs = new FileStream(FullFileName, FileMode.Open, FileAccess.Read);
            }
            catch (Exception ex)
            {
                Logging.Write("SaveFileToDB error: " + ex.ToString());
                return false;
            }

            string sql;
            if (file_type == 1)
            {
                //sql = string.Format("select file_context from map_file where map_name = '{0}' for update", DBKey);
                sql = string.Format("update map_file set file_context = :1 where map_name = '{0}'", DBKey);
            }
            else
            {
                //sql = string.Format("select file_context from fight_file where roll_type = '{0}' for update", DBKey);
                sql = string.Format("update fight_file set file_context = :2 where roll_type = '{0}'", DBKey);
            }

            OracleTransaction transaction = null;
            try
            {
                if (!isConnected) OraConnect();
                // 利用事务处理（必须）
                transaction = conn.BeginTransaction();
                OracleCommand oCmd = new OracleCommand(sql, conn);
                OracleParameter param = oCmd.Parameters.Add("1", OracleDbType.Clob, ParameterDirection.Input);

                IdentifyEncoding sinodetector = new IdentifyEncoding();
                FileInfo finfo = new FileInfo(FullFileName);
                StreamReader sr = new StreamReader(mapfs, sinodetector.GetEncoding(sinodetector.GetEncodingName(finfo)));
                string context = sr.ReadToEnd();
                param.Value = context;

                oCmd.ExecuteNonQuery();

                transaction.Commit();

            }
            catch (Exception ex)
            {
                transaction.Rollback();
                Logging.Write("SaveFileToDB error: " + ex.ToString());
                return false;
            }

            return true;

        }
    }
}
