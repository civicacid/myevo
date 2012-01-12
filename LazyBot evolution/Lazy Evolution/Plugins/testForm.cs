using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using LazyLib.Wow;
using LazyLib.Helpers;
using LazyLib;
using LazyLib.Helpers.Mail;

namespace LazyEvo.Plugins
{
    public partial class testForm : Form
    {
        public testForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Dictionary<string,int> hhh = SpyFrame.lua_GetBagInfo();
            dataGridView1.DataSource = hhh.ToList();
            //dataGridView1.bin
            dataGridView1.Refresh();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            List<string> Mines;                                 //待分解清单
            Dictionary<string, string> MailList;                //发货列表
            DBLogger logger = new DBLogger("拿取邮件+分矿+邮寄");

            MailList = new Dictionary<string, string>();
            MailList.Add("地狱炎石", "最初的联盟");
            MailList.Add("琥珀晶石", "最初的联盟");
            MailList.Add("恶魔之眼", "最初的联盟");
            MailList.Add("泽菲蓝晶石", "最初的联盟");
            MailList.Add("碧玉", "最初的联盟");
            MailList.Add("阿里锡黄晶", "最初的联盟");
            MailList.Add("红玉髓", "杀贝贝熊");

            Mines = new List<string>();
            Mines.Add("源质矿石");
            Mines.Add("燃铁矿石");

            // 打开邮箱
            //if (!MailManager.TargetMailBox())
            // 分解和邮寄
            SpyMineAndMail.logger.clear();
            SpyMineAndMail.MailList = MailList;
            SpyMineAndMail.Mines = Mines;
            SpyMineAndMail.GoGo();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SpyAH.init();
            
        }
    }
}
