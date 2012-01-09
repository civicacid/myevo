namespace LazyEvo.Plugins
{
    partial class SpyForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lstAccount = new System.Windows.Forms.ListBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtAccPass = new System.Windows.Forms.TextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnSaveChar = new System.Windows.Forms.Button();
            this.btnNewChar = new System.Windows.Forms.Button();
            this.comboChaIdx = new System.Windows.Forms.ComboBox();
            this.lstRole = new System.Windows.Forms.ListBox();
            this.label6 = new System.Windows.Forms.Label();
            this.btnDelChar = new System.Windows.Forms.Button();
            this.txtServer = new System.Windows.Forms.TextBox();
            this.txtCharName = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnSaveAcc = new System.Windows.Forms.Button();
            this.btnNewAcc = new System.Windows.Forms.Button();
            this.btnDelAcc = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtCharList = new System.Windows.Forms.TextBox();
            this.txtAccName = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // lstAccount
            // 
            this.lstAccount.FormattingEnabled = true;
            this.lstAccount.Location = new System.Drawing.Point(12, 12);
            this.lstAccount.Name = "lstAccount";
            this.lstAccount.Size = new System.Drawing.Size(210, 394);
            this.lstAccount.TabIndex = 4;
            this.lstAccount.SelectedIndexChanged += new System.EventHandler(this.lstAccount_SelectedIndexChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(40, 61);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(31, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "密码";
            // 
            // txtAccPass
            // 
            this.txtAccPass.Location = new System.Drawing.Point(85, 57);
            this.txtAccPass.Name = "txtAccPass";
            this.txtAccPass.Size = new System.Drawing.Size(243, 21);
            this.txtAccPass.TabIndex = 6;
            this.txtAccPass.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtAccPass_KeyPress);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnSaveChar);
            this.groupBox1.Controls.Add(this.btnNewChar);
            this.groupBox1.Controls.Add(this.comboChaIdx);
            this.groupBox1.Controls.Add(this.lstRole);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.btnDelChar);
            this.groupBox1.Controls.Add(this.txtServer);
            this.groupBox1.Controls.Add(this.txtCharName);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Location = new System.Drawing.Point(14, 150);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(350, 238);
            this.groupBox1.TabIndex = 8;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "角色";
            // 
            // btnSaveChar
            // 
            this.btnSaveChar.Location = new System.Drawing.Point(280, 197);
            this.btnSaveChar.Name = "btnSaveChar";
            this.btnSaveChar.Size = new System.Drawing.Size(65, 27);
            this.btnSaveChar.TabIndex = 0;
            this.btnSaveChar.Text = "保存";
            this.btnSaveChar.UseVisualStyleBackColor = true;
            this.btnSaveChar.Click += new System.EventHandler(this.btnSaveChar_Click);
            // 
            // btnNewChar
            // 
            this.btnNewChar.Location = new System.Drawing.Point(138, 198);
            this.btnNewChar.Name = "btnNewChar";
            this.btnNewChar.Size = new System.Drawing.Size(65, 27);
            this.btnNewChar.TabIndex = 0;
            this.btnNewChar.Text = "新增";
            this.btnNewChar.UseVisualStyleBackColor = true;
            this.btnNewChar.Click += new System.EventHandler(this.btnNewChar_Click);
            // 
            // comboChaIdx
            // 
            this.comboChaIdx.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboChaIdx.FormattingEnabled = true;
            this.comboChaIdx.Items.AddRange(new object[] {
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9"});
            this.comboChaIdx.Location = new System.Drawing.Point(182, 86);
            this.comboChaIdx.Name = "comboChaIdx";
            this.comboChaIdx.Size = new System.Drawing.Size(162, 21);
            this.comboChaIdx.TabIndex = 3;
            this.comboChaIdx.SelectedIndexChanged += new System.EventHandler(this.comboChaIdx_SelectedIndexChanged);
            // 
            // lstRole
            // 
            this.lstRole.FormattingEnabled = true;
            this.lstRole.Location = new System.Drawing.Point(12, 26);
            this.lstRole.Name = "lstRole";
            this.lstRole.Size = new System.Drawing.Size(116, 199);
            this.lstRole.TabIndex = 2;
            this.lstRole.SelectedIndexChanged += new System.EventHandler(this.lstRole_SelectedIndexChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(136, 89);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(43, 13);
            this.label6.TabIndex = 0;
            this.label6.Text = "角色号";
            // 
            // btnDelChar
            // 
            this.btnDelChar.Location = new System.Drawing.Point(209, 198);
            this.btnDelChar.Name = "btnDelChar";
            this.btnDelChar.Size = new System.Drawing.Size(65, 26);
            this.btnDelChar.TabIndex = 1;
            this.btnDelChar.Text = "删除";
            this.btnDelChar.UseVisualStyleBackColor = true;
            this.btnDelChar.Click += new System.EventHandler(this.btnDelChar_Click);
            // 
            // txtServer
            // 
            this.txtServer.Location = new System.Drawing.Point(183, 55);
            this.txtServer.Name = "txtServer";
            this.txtServer.Size = new System.Drawing.Size(161, 21);
            this.txtServer.TabIndex = 1;
            this.txtServer.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtServer_KeyPress);
            // 
            // txtCharName
            // 
            this.txtCharName.Location = new System.Drawing.Point(183, 26);
            this.txtCharName.Name = "txtCharName";
            this.txtCharName.Size = new System.Drawing.Size(161, 21);
            this.txtCharName.TabIndex = 1;
            this.txtCharName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCharName_KeyPress);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(136, 59);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(43, 13);
            this.label7.TabIndex = 0;
            this.label7.Text = "服务器";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(136, 29);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(43, 13);
            this.label4.TabIndex = 0;
            this.label4.Text = "角色名";
            // 
            // btnSaveAcc
            // 
            this.btnSaveAcc.Location = new System.Drawing.Point(227, 116);
            this.btnSaveAcc.Name = "btnSaveAcc";
            this.btnSaveAcc.Size = new System.Drawing.Size(65, 27);
            this.btnSaveAcc.TabIndex = 0;
            this.btnSaveAcc.Text = "保存";
            this.btnSaveAcc.UseVisualStyleBackColor = true;
            this.btnSaveAcc.Click += new System.EventHandler(this.btnSaveAcc_Click);
            // 
            // btnNewAcc
            // 
            this.btnNewAcc.Location = new System.Drawing.Point(85, 117);
            this.btnNewAcc.Name = "btnNewAcc";
            this.btnNewAcc.Size = new System.Drawing.Size(65, 27);
            this.btnNewAcc.TabIndex = 0;
            this.btnNewAcc.Text = "新增";
            this.btnNewAcc.UseVisualStyleBackColor = true;
            this.btnNewAcc.Click += new System.EventHandler(this.btnNewAcc_Click);
            // 
            // btnDelAcc
            // 
            this.btnDelAcc.Location = new System.Drawing.Point(156, 117);
            this.btnDelAcc.Name = "btnDelAcc";
            this.btnDelAcc.Size = new System.Drawing.Size(65, 26);
            this.btnDelAcc.TabIndex = 1;
            this.btnDelAcc.Text = "删除";
            this.btnDelAcc.UseVisualStyleBackColor = true;
            this.btnDelAcc.Click += new System.EventHandler(this.btnDelAcc_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.btnSaveAcc);
            this.groupBox2.Controls.Add(this.groupBox1);
            this.groupBox2.Controls.Add(this.btnNewAcc);
            this.groupBox2.Controls.Add(this.txtCharList);
            this.groupBox2.Controls.Add(this.txtAccName);
            this.groupBox2.Controls.Add(this.txtAccPass);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.btnDelAcc);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Location = new System.Drawing.Point(228, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(370, 394);
            this.groupBox2.TabIndex = 9;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "账号";
            // 
            // txtCharList
            // 
            this.txtCharList.Location = new System.Drawing.Point(85, 87);
            this.txtCharList.Name = "txtCharList";
            this.txtCharList.Size = new System.Drawing.Size(243, 21);
            this.txtCharList.TabIndex = 6;
            this.txtCharList.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCharList_KeyPress);
            // 
            // txtAccName
            // 
            this.txtAccName.Location = new System.Drawing.Point(85, 28);
            this.txtAccName.Name = "txtAccName";
            this.txtAccName.Size = new System.Drawing.Size(243, 21);
            this.txtAccName.TabIndex = 6;
            this.txtAccName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtAccName_KeyPress);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(40, 90);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(31, 13);
            this.label5.TabIndex = 5;
            this.label5.Text = "列表";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(40, 31);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(31, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "账号";
            // 
            // SpyForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(612, 415);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.lstAccount);
            this.Name = "SpyForm";
            this.Text = "SpyForm";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.SpyForm_FormClosing);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.SpyForm_FormClosed);
            this.Load += new System.EventHandler(this.SpyForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ListBox lstAccount;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtAccPass;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtCharName;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ListBox lstRole;
        private System.Windows.Forms.Button btnSaveAcc;
        private System.Windows.Forms.Button btnNewAcc;
        private System.Windows.Forms.Button btnDelAcc;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtCharList;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox comboChaIdx;
        private System.Windows.Forms.TextBox txtServer;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button btnSaveChar;
        private System.Windows.Forms.Button btnNewChar;
        private System.Windows.Forms.Button btnDelChar;
        private System.Windows.Forms.TextBox txtAccName;
        private System.Windows.Forms.Label label2;
    }
}