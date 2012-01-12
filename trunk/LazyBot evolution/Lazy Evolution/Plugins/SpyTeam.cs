using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using LazyLib;
using LazyLib.Helpers;
using LazyLib.Wow;

namespace LazyEvo.Plugins
{
    public partial class SpyTeam : Form
    {
        public SpyTeam()
        {
            InitializeComponent();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            Dictionary<Location, string> whereplayer = new Dictionary<Location, string>();
            whereplayer.Add(ObjectManager.MyPlayer.Location, ObjectManager.MyPlayer.ZoneText);
            PointList.Items.Add(whereplayer);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            PointList.Items.Remove(PointList.SelectedItem);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            List<PPlayer> allone = ObjectManager.GetPlayers;
            member1.Items.Clear();
            member2.Items.Clear();
            member3.Items.Clear();
            Leader.Items.Clear();
            foreach (PPlayer pp in allone)
            {
                if (pp.IsMe) continue;
                Dictionary<string, ulong> gg = new Dictionary<string, ulong>();
                gg.Add(pp.Name, pp.GUID);
                member1.Items.Add(gg);
                member2.Items.Add(gg);
                member3.Items.Add(gg);
                Leader.Items.Add(gg);
            }
        }
    }
}
