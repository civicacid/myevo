namespace LazyEvo.Plugins
{
    partial class SpyTeam
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
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.member1 = new System.Windows.Forms.ComboBox();
            this.member2 = new System.Windows.Forms.ComboBox();
            this.member3 = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.Leader = new System.Windows.Forms.ComboBox();
            this.button3 = new System.Windows.Forms.Button();
            this.PointList = new System.Windows.Forms.ListBox();
            this.button4 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(5, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 12);
            this.label1.TabIndex = 0;
            this.label1.Text = "小号";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(69, 176);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Start";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(152, 176);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 2;
            this.button2.Text = "End";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // member1
            // 
            this.member1.FormattingEnabled = true;
            this.member1.Location = new System.Drawing.Point(73, 12);
            this.member1.Name = "member1";
            this.member1.Size = new System.Drawing.Size(121, 20);
            this.member1.TabIndex = 3;
            // 
            // member2
            // 
            this.member2.FormattingEnabled = true;
            this.member2.Location = new System.Drawing.Point(200, 12);
            this.member2.Name = "member2";
            this.member2.Size = new System.Drawing.Size(121, 20);
            this.member2.TabIndex = 3;
            // 
            // member3
            // 
            this.member3.FormattingEnabled = true;
            this.member3.Location = new System.Drawing.Point(336, 12);
            this.member3.Name = "member3";
            this.member3.Size = new System.Drawing.Size(121, 20);
            this.member3.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(5, 46);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(29, 12);
            this.label2.TabIndex = 4;
            this.label2.Text = "大号";
            // 
            // Leader
            // 
            this.Leader.FormattingEnabled = true;
            this.Leader.Location = new System.Drawing.Point(73, 43);
            this.Leader.Name = "Leader";
            this.Leader.Size = new System.Drawing.Size(121, 20);
            this.Leader.TabIndex = 3;
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(233, 176);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 23);
            this.button3.TabIndex = 5;
            this.button3.Text = "Get Team";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // PointList
            // 
            this.PointList.FormattingEnabled = true;
            this.PointList.ItemHeight = 12;
            this.PointList.Location = new System.Drawing.Point(524, 3);
            this.PointList.Name = "PointList";
            this.PointList.Size = new System.Drawing.Size(179, 220);
            this.PointList.TabIndex = 6;
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(443, 196);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(75, 23);
            this.button4.TabIndex = 7;
            this.button4.Text = "DelPair";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(443, 167);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(75, 23);
            this.button5.TabIndex = 7;
            this.button5.Text = "AddPair";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // SpyTeam
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(715, 231);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.PointList);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.member3);
            this.Controls.Add(this.member2);
            this.Controls.Add(this.Leader);
            this.Controls.Add(this.member1);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label1);
            this.Name = "SpyTeam";
            this.Text = "SpyTeam";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.ComboBox member1;
        private System.Windows.Forms.ComboBox member2;
        private System.Windows.Forms.ComboBox member3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox Leader;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.ListBox PointList;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button5;
    }
}