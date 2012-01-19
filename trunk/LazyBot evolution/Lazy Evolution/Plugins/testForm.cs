using System;
using System.IO;
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
using LazyLib.ActionBar;

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
            Dictionary<string, int> hhh = SpyFrame.lua_GetBagInfo();
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
            DataRow dr = SpyAH.Items.NewRow();
            dr["item_name"] = "统御恶魔之眼";
            dr["item_minprice"] = 10 * 100 * 100;
            dr["item_maxprice"] = 140 * 100 * 100;
            dr["item_count"] = 3;
            dr["item_stacksize"] = 1;
            SpyAH.Items.Rows.Add(dr);
            SpyAH.gogo();

        }

        private void button5_Click(object sender, EventArgs e)
        {
            textBox1.AppendText("小号 " + ObjectManager.MyPlayer.Name +
                                string.Format(" 的当前坐标是：[{0}]，属于Step{1}",
                                ObjectManager.MyPlayer.Location.ToString(),
                                Convert.ToString(Step.Value) + "\r\n"
                ));
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLeader.Text)) return;
            foreach (PUnit unit in ObjectManager.GetUnits)
            {
                if (unit.Name.Equals(txtLeader.Text))
                {
                    textBox1.AppendText("大号 " + unit.Name + string.Format(" 的当前坐标是：[{0}]，属于Step{1}",
                                unit.Location.ToString(),
                                Convert.ToString(Step.Value)) + "\r\n"
                                );
                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            Dictionary<string, string> MailList;                //发货列表

            MailList = new Dictionary<string, string>();
            MailList.Add("朴素地狱炎石", "收矿啊");
            MailList.Add("精致地狱炎石", "收矿啊");
            MailList.Add("闪光地狱炎石", "收矿啊");
            MailList.Add("闪耀地狱炎石", "收矿啊");
            MailList.Add("纯净恶魔之眼", "收矿啊");
            MailList.Add("统御恶魔之眼", "收矿啊");

            Dictionary<string, int> CreationList = new Dictionary<string, int>();
            CreationList.Add("朴素地狱炎石", 5);
            CreationList.Add("精致地狱炎石", 20);
            CreationList.Add("闪光地狱炎石", 5);
            CreationList.Add("闪耀地狱炎石", 5);
            CreationList.Add("纯净恶魔之眼", 5);
            CreationList.Add("统御恶魔之眼", 5);

            Dictionary<string, string> CreationMap = new Dictionary<string, string>();
            CreationMap.Add("朴素地狱炎石", "地狱炎石");
            CreationMap.Add("精致地狱炎石", "地狱炎石");
            CreationMap.Add("闪光地狱炎石", "地狱炎石");
            CreationMap.Add("闪耀地狱炎石", "地狱炎石");
            CreationMap.Add("纯净恶魔之眼", "恶魔之眼");
            CreationMap.Add("统御恶魔之眼", "恶魔之眼");

            SpyZBJG.logger.clear();
            SpyZBJG.MailList = MailList;
            SpyZBJG.CreationList = CreationList;
            SpyZBJG.CreationMap = CreationMap;
            SpyZBJG.GoGo();
        }
    }
}
