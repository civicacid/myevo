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
using System.Diagnostics;
using LazyLib.Wow;
using LazyLib.Helpers;
using LazyLib;
using LazyLib.Helpers.Mail;
using LazyLib.ActionBar;
using LazyLib.SPY;

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
            SpyMineAndMail.initme();
            SpyMineAndMail.start();
            //while (true)
            //{
            //    Thread.Sleep(1000);
            //    if (!SpyMineAndMail.RUNNING) break;
            //}
            MessageBox.Show("OK");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (SpyAH.Items.Columns.Count == 0)
            {
                //"拍卖师卡拉伦"
                SpyAH.initme();
            }
            SpyAH.gogo();
            MessageBox.Show("结束");
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textBox2.Text)) textBox2.Text = "0";
            textBox1.AppendText("小号 " + ObjectManager.MyPlayer.Name +
                                string.Format(" 的当前坐标是：[{0}]，属于Step{1}，small.Add({2}, new Location((float)Convert.ToDouble({3}), (float)Convert.ToDouble({4}), (float)Convert.ToDouble({5})));",
                                ObjectManager.MyPlayer.Location.ToString(),
                                Convert.ToString(Step.Value),
                                textBox2.Text,
                                Convert.ToString(ObjectManager.MyPlayer.Location.X),
                                Convert.ToString(ObjectManager.MyPlayer.Location.Y),
                                Convert.ToString(ObjectManager.MyPlayer.Location.Z)
                ) + "\r\n");
            textBox2.Text = Convert.ToString(Convert.ToInt32(textBox2.Text) + 1);
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
            if (SpyZBJG.initme()) SpyZBJG.start();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            //SpyDB.SaveInfo_Bag(SpyFrame.lua_GetBagInfo());
            Logging.Write("asdasd");
        }

        private void button8_Click(object sender, EventArgs e)
        {

            BarMapper.MapBars();
            KeyHelper.LoadKeys();


            string BossName = "看门者克里克希尔";
            List<string> EmName = new List<string>();
            EmName.Add("看守者纳尔伊");
            EmName.Add("看守者加什拉");
            EmName.Add("看守者希尔希克");
            List<int> MyBadBuff = new List<int>();
            MyBadBuff.Add(52087);   // 蛛网裹体
            MyBadBuff.Add(52086);   // 蛛网裹体

            while (ObjectManager.MyPlayer.IsAlive)
            {
                // 循环开始
                PUnit boss = new PUnit(0);
                Dictionary<string, PUnit> em = new Dictionary<string, PUnit>();

                // 加buff
                if (!ObjectManager.MyPlayer.HasBuff("钢皮合剂")) KeyHelper.SendLuaOverChat("/use 钢皮合剂");
                if (!ObjectManager.MyPlayer.HasBuff("坚韧")) KeyHelper.SendLuaOverChat("/use 坚韧符文卷轴 II");

                // 找到怪的地址
                int FoundCount = 0;
                em.Clear();
                foreach (PUnit uu in ObjectManager.GetUnits)
                {
                    if (uu.Name.Equals(BossName))
                    {
                        boss = uu;
                        FoundCount++;
                        continue;
                    }
                    foreach (string ename in EmName)
                    {
                        if (uu.Name.Equals(ename))
                        {
                            em.Add(ename, uu);
                            FoundCount++;
                            continue;
                        }
                    }
                }

                if (FoundCount < 4)
                {
                    Logging.Write("找不到怪了");
                    return;
                }

                // 面对boss
                boss.Face();

                // 开机能
                if (!ObjectManager.MyPlayer.HasBuff("野性印记")) BarMapper.CastSpell("野性印记");
                if (!ObjectManager.MyPlayer.HasBuff("猎豹形态")) BarMapper.CastSpell("猎豹形态");
                Thread.Sleep(1000);

                // 定位一个
                foreach (string ename in EmName)
                {
                    PUnit emUnit = em[ename];
                    while (!emUnit.TargetGUID.Equals(ObjectManager.MyPlayer.GUID))
                    {
                        KeyHelper.SendLuaOverChat("/target " + ename);
                        BarMapper.CastSpell("精灵之火（野性）");
                        Thread.Sleep(100);
                    }
                    Thread.Sleep(1000);

                    // 等待怪过来
                    while (emUnit.Location.DistanceToSelf2D > 5) { };
                    emUnit.Location.Face();

                    // 杀，直到怪死
                    int count = 0;
                    while (emUnit.IsAlive)
                    {
                        Thread.Sleep(100);
                        if (ObjectManager.MyPlayer.IsCasting) { continue; }

                        //调整朝向
                        if (!emUnit.Location.IsFacing(0.3f)) emUnit.Location.Face();

                        //Logging.Write("Count is " + count.ToString());

                        // 检查自己的buff
                        while (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) { };

                        // 猛虎之怒
                        if (BarMapper.IsSpellReadyByName("猛虎之怒"))
                        {
                            BarMapper.CastSpell("猛虎之怒");
                            Thread.Sleep(100);
                            continue;
                        }

                        // 树皮术
                        if (BarMapper.IsSpellReadyByName("树皮术"))
                        {
                            BarMapper.CastSpell("树皮术");
                            Thread.Sleep(100);
                            continue;
                        }

                        // 凶猛撕咬--终结技
                        if (count == 4 && BarMapper.IsSpellReadyByName("凶猛撕咬"))
                        {
                            BarMapper.CastSpell("凶猛撕咬");
                            Thread.Sleep(100);
                            count = 0;
                            continue;
                        }

                        // 裂伤
                        if (BarMapper.IsSpellReadyByName("裂伤") && !emUnit.HasBuff("裂伤"))
                        {
                            BarMapper.CastSpell("裂伤");
                            Thread.Sleep(100);
                            count++;
                            continue;
                        }

                        // 斜掠
                        if (BarMapper.IsSpellReadyByName("斜掠"))
                        {
                            BarMapper.CastSpell("斜掠");
                            count++;
                            Thread.Sleep(100);
                            continue;
                        }

                        if (ObjectManager.MyPlayer.IsDead) return;
                    }
                }

                while (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) { };

                // 一直横扫，直到全死
                while (true)
                {
                    if (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) continue;
                    if (BarMapper.IsSpellReadyByName("生存本能")) { BarMapper.CastSpell("生存本能"); }
                    if (ObjectManager.MyPlayer.IsDead) return;
                    break;
                }
                while (true)
                {
                    if (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) continue;
                    if (BarMapper.IsSpellReadyByName("狂暴")) { BarMapper.CastSpell("狂暴"); }
                    if (ObjectManager.MyPlayer.IsDead) return;
                    break;
                }
                //while (BarMapper.IsSpellReadyByName("狂暴")) { BarMapper.CastSpell("狂暴"); break; }
                // 加点血
                while (ObjectManager.MyPlayer.Health < 30)
                {
                    if (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) continue;
                    if (BarMapper.IsSpellReadyByName("回春术")) { BarMapper.CastSpell("回春术"); break; }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }
                while (ObjectManager.MyPlayer.Health < 30)
                {
                    if (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) continue;
                    if (BarMapper.IsSpellReadyByName("愈合")) { BarMapper.CastSpell("愈合"); break; }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }
                while (!ObjectManager.MyPlayer.HasBuff("猎豹形态"))
                {
                    if (ObjectManager.MyPlayer.HasBuff(MyBadBuff)) continue;
                    if (BarMapper.IsSpellReadyByName("猎豹形态")) { BarMapper.CastSpell("猎豹形态"); break; }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }

                boss.Face();

                while (true)
                {
                    //ObjectManager.MyPlayer.IsInCombat
                    Thread.Sleep(100);
                    bool TargetME = false;
                    PUnit emO = new PUnit(0);
                    foreach (PUnit uu in ObjectManager.GetUnits)
                    {
                        if (uu.IsPlayer) continue;
                        if (uu.Name.Equals(boss.Name)) continue;
                        if (uu.TargetGUID.Equals(ObjectManager.MyPlayer.GUID)) { TargetME = true; emO = uu; break; }
                    }
                    if (!TargetME) break;
                    emO.Face();
                    if (!ObjectManager.MyPlayer.HasBuff("原始疯狂") && BarMapper.IsSpellReadyByName("猛虎之怒")) BarMapper.CastSpell("猛虎之怒");
                    if (BarMapper.IsSpellReadyByName("树皮术")) BarMapper.CastSpell("树皮术");
                    if (!BarMapper.IsSpellReadyByName("横扫")) continue;
                    BarMapper.CastSpell("横扫");
                    Thread.Sleep(100);
                    if (ObjectManager.MyPlayer.IsDead) return;
                }

                // 面对boss
                boss.Face();

                // 召唤“打架赛车”
                KeyHelper.SendLuaOverChat("/use 蓝色打架赛车");
                BarMapper.CastSpell("蓝色打架赛车");
                Thread.Sleep(1000);
                PUnit djsc = new PUnit(0);
                bool FoundDJSC = false;
                while (!FoundDJSC)
                {
                    foreach (PUnit uu in ObjectManager.GetUnits)
                    {
                        if (uu.Name.Contains("打架赛车"))
                        {
                            djsc = uu;
                            FoundDJSC = true;
                        }
                    }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }

                Thread.Sleep(500);
                // 走到boss旁边，打架赛车Y不小于646
                //while (djsc.Location.DistanceFromXY(boss.Location) > 6)
                string ddd = Convert.ToString(djsc.Location.Y);
                float PosY = djsc.Location.Y;
                while (PosY > 648 || PosY == 0)
                {
                    KeyLowHelper.PressKey(MicrosoftVirtualKeys.Up);
                    Thread.Sleep(100);
                    PosY = djsc.Location.Y;
                    ddd = ddd + Convert.ToString(PosY);
                    if (ObjectManager.MyPlayer.IsDead) return;
                }
                KeyLowHelper.ReleaseKey(MicrosoftVirtualKeys.Up);
                Logging.Write(ddd);

                // 一直跳，直到boss消失
                while (boss.Health > 0)
                {
                    KeyLowHelper.PressKey(MicrosoftVirtualKeys.Space);
                    Thread.Sleep(10);
                    KeyLowHelper.ReleaseKey(MicrosoftVirtualKeys.Space);
                    Thread.Sleep(500);
                    if (ObjectManager.MyPlayer.IsDead) return;
                }

                // 给自己加血
                while (ObjectManager.MyPlayer.Health < 100 && ObjectManager.MyPlayer.ManaPoints > 5590)
                {
                    // 治疗之触
                    if (BarMapper.IsSpellReadyByName("治疗之触"))
                    {
                        BarMapper.CastSpell("治疗之触");
                        Thread.Sleep(100);
                    }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }
                Thread.Sleep(200);
                KeyHelper.SendLuaOverChat("/use 魔法酪饼");

                // 等待一段时间，直到boss重新出现
                Thread.Sleep(1000);
                bool FoundBoss = false;
                while (!FoundBoss)
                {
                    foreach (PUnit uu in ObjectManager.GetUnits)
                    {
                        if (uu.Name.Equals(BossName))
                        {
                            FoundBoss = true;
                        }
                    }
                    Thread.Sleep(200);
                    if (ObjectManager.MyPlayer.IsDead) return;
                }

                // 猎豹形态
                //BarMapper.CastSpell("猎豹形态");
                //MessageBox.Show("OK");

                // 每个小号跳一次
                Process[] wcc = Process.GetProcessesByName("Wow");
                foreach (Process proc in wcc)
                {
                    KeyLowHelper.PressKey(proc.MainWindowHandle, MicrosoftVirtualKeys.Space);
                    Thread.Sleep(10);
                    KeyLowHelper.ReleaseKey(proc.MainWindowHandle, MicrosoftVirtualKeys.Space);
                    Thread.Sleep(100);
                }

                while (ObjectManager.MyPlayer.Health < 100)
                {
                    while (BarMapper.IsSpellReadyByName("生命之血")) { BarMapper.CastSpell("生命之血"); break; }
                    if (ObjectManager.MyPlayer.ManaPoints > 5590)
                    {
                        // 治疗之触
                        if (BarMapper.IsSpellReadyByName("治疗之触"))
                        {
                            BarMapper.CastSpell("治疗之触");
                            Thread.Sleep(100);
                        }
                    }
                    if (ObjectManager.MyPlayer.IsDead) return;
                }
            }

            Process[] wcc1 = Process.GetProcessesByName("Wow");
            foreach (Process proc in wcc1)
            {
                proc.Kill();
                Thread.Sleep(1000);
            }
        }

                private void button9_Click_1(object sender, EventArgs e)
        {
            if (SpyLogin.initme("11"))
            {
                SpyLogin.start();
                while (!SpyLogin.IsOK) Thread.Sleep(1000);
            }

            if (SpyCJ.initme())
            {
                SpyCJ.start();
                Thread.Sleep(5000);
                Logging.Write("现在的运行状态是："+(SpyCJ.RUNNING?"正常":"不正常"));
            }
        }

    }
}