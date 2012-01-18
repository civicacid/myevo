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
            if (button6.Text == "副本测试")
            {
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

                string leadername = "爱贝贝熊";

                SpyFB.Init(leadername, inPoint, outPoint, large, small, mapp);
                button6.Text = "停止测试";
                SpyFB.StartFB();
            }
            else
            {
                SpyFB.StopFB();
                button6.Text = "副本测试";
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            textBox1.AppendText(string.Format("当前区域名称：{0}",ObjectManager.MyPlayer.ZoneText));            
        }

        private void button8_Click(object sender, EventArgs e)
        {
            BarMapper.MapBars();
            KeyHelper.LoadKeys();

            Location ff = new Location((float)Convert.ToDouble(-6383.632), (float)Convert.ToDouble(567.3316), (float)Convert.ToDouble(386.609));
            if (!ff.IsFacing())
            {
                ff.Face();
            }
        }

    }
}
