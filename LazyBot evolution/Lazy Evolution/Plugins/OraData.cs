using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using LazyLib;
using System.Data;

namespace LazyEvo.Plugins
{
    public class OraData
    {
        private static OracleConnection conn;
        private static bool isConnected;
        private static string connString = "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.26.170)(PORT=1521))(CONNECT_DATA=(SID=elmp)));User Id=wow;Password=wow123;";

        private static void OraConnect()
        {
            
            isConnected = false;
            try
            {
                conn = new OracleConnection(connString);
                conn.Open();
                isConnected = true;
            }
            catch(Exception ex) {
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
                Logging.Write(ex.ToString());
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

    }
}
