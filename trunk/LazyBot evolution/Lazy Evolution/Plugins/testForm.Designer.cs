﻿namespace LazyEvo.Plugins
{
    partial class testForm
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
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.txtLeader = new System.Windows.Forms.TextBox();
            this.Step = new System.Windows.Forms.NumericUpDown();
            this.button6 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Step)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(2, 59);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowTemplate.Height = 23;
            this.dataGridView1.Size = new System.Drawing.Size(242, 395);
            this.dataGridView1.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(37, 30);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "扫描背包";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(305, 12);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(120, 26);
            this.button4.TabIndex = 4;
            this.button4.Text = "分矿测试";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(304, 60);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(131, 38);
            this.button2.TabIndex = 5;
            this.button2.Text = "AH测试";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(269, 166);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(130, 25);
            this.button3.TabIndex = 6;
            this.button3.Text = "记录大号坐标";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(269, 199);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(129, 23);
            this.button5.TabIndex = 7;
            this.button5.Text = "记录当前坐标";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(441, 129);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(312, 301);
            this.textBox1.TabIndex = 8;
            // 
            // txtLeader
            // 
            this.txtLeader.Location = new System.Drawing.Point(286, 137);
            this.txtLeader.Name = "txtLeader";
            this.txtLeader.Size = new System.Drawing.Size(103, 21);
            this.txtLeader.TabIndex = 9;
            // 
            // Step
            // 
            this.Step.Location = new System.Drawing.Point(269, 232);
            this.Step.Name = "Step";
            this.Step.Size = new System.Drawing.Size(120, 21);
            this.Step.TabIndex = 11;
            // 
            // button6
            // 
            this.button6.Location = new System.Drawing.Point(514, 22);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(113, 37);
            this.button6.TabIndex = 12;
            this.button6.Text = "珠宝加工测试";
            this.button6.UseVisualStyleBackColor = true;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // testForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(776, 456);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.Step);
            this.Controls.Add(this.txtLeader);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.dataGridView1);
            this.Name = "testForm";
            this.Text = "testForm";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Step)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox txtLeader;
        private System.Windows.Forms.NumericUpDown Step;
        private System.Windows.Forms.Button button6;
    }
}