using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SQLite;

namespace LazyEvo.Plugins
{
    public partial class SpyForm : Form
    {

        public SpyForm()
        {
            InitializeComponent();
        }

        private void SpyForm_Load(object sender, EventArgs e)
        {
            WOWAll.Open();
            reload_data();
        }

        private void SpyForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            WOWAll.Close();
        }

        private void reload_data()
        {
            WOWAll.LoadData();

            foreach (WOWAll.WoWAccount wa in WOWAll.AllWOWAccount)
            {
                lstAccount.Items.Add(wa.AccountName);
            }

            UpdateControler(OPMode.Reset);
        }
        
        private void lstAccount_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectAccount(lstAccount.Text);
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void SelectAccount(string SelectedAccountName)
        {
            if (String.IsNullOrEmpty(SelectedAccountName))
            {
                return;
            }

            WOWAll.WoWAccount SelectedWa = WOWAll.AllWOWAccount.Find(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == SelectedAccountName); });
            txtAccName.Text = SelectedWa.AccountName;
            txtAccPass.Text = SelectedWa.AccountPass;
            txtCharList.Text = SelectedWa.CharList;

            lstRole.Items.Clear();
            foreach (WOWAll.WoWChar wc in SelectedWa.Char )
            {
                lstRole.Items.Add(wc.CharName);
                txtCharName.Text = "";
                txtServer.Text= "";
                comboChaIdx.Text = "";
            }
        }

        private void SelectChar(string SelectedAccountName, string SelectedCharName)
        {
            if (String.IsNullOrEmpty(SelectedAccountName))
            {
                return;
            }
            if (String.IsNullOrEmpty(SelectedCharName))
            {
                return;
            }
            WOWAll.WoWAccount SelectedWa = WOWAll.AllWOWAccount.Find(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == SelectedAccountName); });
            WOWAll.WoWChar SelectWc = SelectedWa.Char.Find(delegate(WOWAll.WoWChar wc) { return (wc.CharName == SelectedCharName); });
            txtCharName.Text = SelectWc.CharName;
            txtServer.Text = SelectWc.Server;
            //comboChaIdx.SelectedValue = SelectWc.CharIndex;
            comboChaIdx.Text = Convert.ToString(SelectWc.CharIndex);
        }

        private void lstRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectChar(lstAccount.Text,lstRole.Text);
        }

        private bool isChanged()
        {
            return (txtAccName.BackColor == System.Drawing.Color.DarkSeaGreen) &&
                   (txtAccPass.BackColor == System.Drawing.Color.DarkSeaGreen) &&
                   (txtCharList.BackColor == System.Drawing.Color.DarkSeaGreen) &&
                   (txtCharName.BackColor == System.Drawing.Color.DarkSeaGreen) &&
                   (txtServer.BackColor == System.Drawing.Color.DarkSeaGreen) &&
                   (comboChaIdx.BackColor == System.Drawing.Color.DarkSeaGreen);
        }

        private void SpyForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (isChanged())
            {
                MessageBox.Show("保存更改以后，再退出！");
                e.Cancel = true;
            }
        }

        // ***************************  账户 ***************************
        // 新建账户
        private void btnNewAcc_Click(object sender, EventArgs e)
        {
            if (btnNewAcc.Text == "复位")
            {
                reload_data();
                return;
            }

            if (isChanged())
            {
                MessageBox.Show("有未保存的修改");
                return;
            }

            UpdateControler(OPMode.NewAcc);

        }

        // 保存账户
        private void btnSaveAcc_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtAccName.Text) || String.IsNullOrEmpty(txtAccName.Text) || String.IsNullOrEmpty(txtAccName.Text))
            {
                MessageBox.Show("有未录入的内容");
                return;
            }

            if (btnNewAcc.Text == "复位")
            {
                if (WOWAll.AllWOWAccount.Exists(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == txtAccName.Text); }))
                {
                    MessageBox.Show("账号已经存在");
                    return;
                }
                WOWAll.NewWOWAccount(txtAccName.Text.ToLower(), txtAccPass.Text.ToLower(), txtCharList.Text.ToLower());
                txtAccName.ReadOnly = true;
                ResetTextColor();
                reload_data();
                return;
            }

            if (isChanged())
            {
                WOWAll.UpdateWOWAccount(txtAccName.Text.ToLower(), txtAccPass.Text.ToLower(), txtCharList.Text.ToLower());
                ResetTextColor();
                reload_data();
                return;
            }
        }
        // 删除
        private void btnDelAcc_Click(object sender, EventArgs e)
        {
            if (btnNewAcc.Text == "复位" || isChanged())
            {
                MessageBox.Show("保存以后再删除");
                return;
            }
            WOWAll.DelWOWAccount(txtAccName.Text.ToLower());
            reload_data();
            return;
        }

        // ********************************  角色  ********************************

        private void btnNewChar_Click(object sender, EventArgs e)
        {
            if (btnNewChar.Text == "复位")
            {
                reload_data();
                return;
            }

            if (isChanged())
            {
                MessageBox.Show("有未保存的修改");
                return;
            }

            UpdateControler(OPMode.NewChar);
        }

        private void btnDelChar_Click(object sender, EventArgs e)
        {
            if (btnNewChar.Text == "复位" || isChanged())
            {
                MessageBox.Show("保存以后再删除");
                return;
            }
            WOWAll.DelWOWChar(txtAccName.Text.ToLower(), txtCharName.Text.ToLower());
            reload_data();
            return;
        }

        private void btnSaveChar_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtCharName.Text) || String.IsNullOrEmpty(txtServer.Text) || String.IsNullOrEmpty(comboChaIdx.Text))
            {
                MessageBox.Show("有未录入的内容");
                return;
            }

            if (btnNewChar.Text == "复位")
            {
                WOWAll.WoWAccount SelectedWa = WOWAll.AllWOWAccount.Find(delegate(WOWAll.WoWAccount wa) { return (wa.AccountName == txtAccName.Text.ToLower()); });
                if (SelectedWa.Char.Exists(delegate(WOWAll.WoWChar wc) { return (wc.CharName == txtCharName.Text.ToLower()); }))
                {
                    MessageBox.Show("账号已经存在");
                    return;
                }
                WOWAll.NewWOWChar(txtAccName.Text.ToLower(), txtCharName.Text.ToLower(),txtServer.Text.ToLower(), Convert.ToInt16(comboChaIdx.Text));
                
                ResetTextColor();
                reload_data();
                return;
            }

            if (isChanged())
            {
                WOWAll.UpdateWOWChar(txtAccName.Text.ToLower(), txtCharName.Text.ToLower(), txtServer.Text.ToLower(), Convert.ToInt16(comboChaIdx.Text));
                ResetTextColor();
                reload_data();
                return;
            }
        }
        private enum OPMode 
        {
            NewAcc = 1,
            NewChar = 2,
            Reset = 3
        };

        private void UpdateControler(OPMode oo)
        {
            switch (oo)
            {
                case OPMode.NewAcc:
                    lstAccount.Text = "";
                    txtAccName.Text = "";
                    txtAccPass.Text = "";
                    txtCharList.Text = "";
                    lstRole.Text = "";
                    txtCharName.Text = "";
                    txtServer.Text = "";
                    comboChaIdx.Text = "";

                    lstAccount.Enabled = false;
                    txtAccName.Enabled = true;
                    btnNewAcc.Text = "复位";
                    btnDelAcc.Enabled = false;

                    lstRole.Enabled = false;
                    txtCharName.Enabled = false;
                    txtServer.Enabled = false;
                    comboChaIdx.Enabled = false;
                    btnNewChar.Enabled = false;
                    btnDelChar.Enabled = false;
                    btnSaveChar.Enabled = false;

                    txtAccName.Focus();
                    break;

                case OPMode.NewChar:
                    lstRole.Text = "";
                    txtCharName.Text = "";
                    txtServer.Text = "";
                    comboChaIdx.Text = "";

                    lstAccount.Enabled = false;
                    txtAccName.Enabled = false;
                    txtAccPass.Enabled = false;
                    txtCharList.Enabled = false;
                    btnNewAcc.Enabled = false;
                    btnDelAcc.Enabled = false;
                    btnSaveAcc.Enabled = false;

                    lstRole.Enabled = false;
                    txtCharName.Enabled = true;
                    btnNewChar.Text = "复位";
                    btnDelChar.Enabled = false;

                    txtCharName.Focus();
                    break;

                case OPMode.Reset:
                    lstAccount.Enabled = true;
                    txtAccName.Enabled = false;
                    txtAccPass.Enabled = true;
                    txtCharList.Enabled = true;
                    btnNewAcc.Enabled = true;
                    btnNewAcc.Text = "新增";
                    btnDelAcc.Enabled = true;
                    btnSaveAcc.Enabled = true;
                    lstRole.Enabled = true;
                    txtCharName.Enabled = false;
                    txtServer.Enabled = true;
                    comboChaIdx.Enabled = true;
                    btnNewChar.Enabled = true;
                    btnNewChar.Text = "新增";
                    btnDelChar.Enabled = true;
                    btnSaveChar.Enabled = true;
                    ResetTextColor();
                    break;
            }
        }

        private void ResetTextColor()
        {
            txtAccName.BackColor = System.Drawing.SystemColors.Window;
            txtAccPass.BackColor = System.Drawing.SystemColors.Window;
            txtCharList.BackColor = System.Drawing.SystemColors.Window;
            txtCharName.BackColor = System.Drawing.SystemColors.Window;
            txtServer.BackColor = System.Drawing.SystemColors.Window;
            comboChaIdx.BackColor = System.Drawing.SystemColors.Window;
        }

        private void txtAccName_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtAccName.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

        private void txtAccPass_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtAccPass.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

        private void txtCharList_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtCharList.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

        private void txtCharName_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtCharName.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

        private void txtServer_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtServer.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

        private void comboChaIdx_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboChaIdx.BackColor = System.Drawing.Color.DarkSeaGreen;
        }

    }
}
