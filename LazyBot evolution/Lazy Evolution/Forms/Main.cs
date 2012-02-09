/*
This file is part of LazyBot - Copyright (C) 2011 Arutha

    LazyBot is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    LazyBot is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with LazyBot.  If not, see <http://www.gnu.org/licenses/>.
*/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Media;
using System.Threading;
using System.Windows.Forms;
using DevComponents.DotNetBar;
using DevComponents.DotNetBar.Controls;
using LazyEvo.Classes;
using LazyEvo.Forms.Helpers;
using LazyEvo.Other;
using LazyEvo.PluginSystem;
using LazyEvo.Plugins;
using LazyEvo.Plugins.RotationPlugin;
using LazyEvo.Public;
using LazyLib;
using LazyLib.ActionBar;
using LazyLib.Combat;
using LazyLib.FSM;
using LazyLib.Helpers;
using LazyLib.IEngine;
using LazyLib.LazyRadar;
using LazyLib.LazyRadar.Drawer;
using LazyLib.Wow;
using LazyLib.SPY;



namespace LazyEvo.Forms
{
    public partial class Main : Office2007Form
    {
        private const string LazyVersion = "1.5.2";
        internal static CombatEngine CombatEngine;
        internal static ILazyEngine EngineHandler;
        internal static bool OneInstance;
        private readonly List<ButtonItem> _buttons = new List<ButtonItem>();
        private readonly SoundPlayer _soundPlayer = new SoundPlayer();
        internal bool ShouldRelog;
        private Hotkey _f10;
        private Hotkey _f9;
        private bool _hotKeysLoaded;
        private RadarForm _radar;

        public Main()
        {
            InitializeComponent();
            GeomertrySettings.LoadSettings();
            //Geometry.GeometryFromString(GeomertrySettings.MainGeometry, this);
            Logging.OnWrite += Logging_OnWrite;
#if DEBUG
            Logging.OnDebug += Logging_OnDebug;
#endif
            BtnDebug.Visible = true;
        }

        private void MainFormClosing(object sender, FormClosingEventArgs e)
        {
            if (Engine.Running)
                StopBotting(true);
            GeomertrySettings.MainGeometry = Geometry.GeometryToString(this);
            GeomertrySettings.Save();
            ReleaseHotKeys();
            DoLoad.Close();
        }

        private void MainLoad(object sender, EventArgs e)
        {
            LBVersion.Text = string.Format("LazyBot Evolution V{0}", LazyVersion);
            expandableSplitter1.Expanded = false;
            DoLoad.Load();
            LoadCustomClasses();
            LoadEngines();
            SelectEngine.SelectedIndex = SelectEngine.FindStringExact(LazySettings.SelectedEngine, -1);
            SelectCombat.SelectedIndex = SelectEngine.FindStringExact(LazySettings.SelectedCombat, -1);
            if (SelectEngine.SelectedIndex == -1)
                SelectEngine.SelectedIndex = 0;
            if (SelectCombat.SelectedIndex == -1)
                SelectCombat.SelectedIndex = 0;
            PluginCompiler.RecompileAll();
            PluginCompiler.StartSavedPlugins();
            LoadPluginButtons();
            RegisterHotKeys();
            Engine.StateChange += UpdateStateChange;
            ObjectManager.NoAttach += LogOut;
#if RELEASE
            CBDebug.Checked = LazySettings.DebugLog;
#endif
#if DEBUG
            buttonX1.Visible = true;
            buttonX2.Visible = true;
#endif
        }

        private void LogOut(object sender, NotifyEventNoAttach e)
        {
            if (Engine.Running)
            {
                StopBotting(false);
            }
        }

        private void RegisterHotKeys()
        {
            if (LazySettings.SetupUseHotkeys && !_hotKeysLoaded)
            {
                _f10 = new Hotkey();
                _f10.KeyCode = Keys.F10;
                _f10.Windows = false;
                _f10.Pressed += delegate { PauseBot(); };
                try
                {
                    if (!_f10.GetCanRegister(this))
                    {
                        Logging.Write("Cannot register F10 as hotkey");
                    }
                    else
                    {
                        _f10.Register(this);
                    }
                }
                catch
                {
                    Logging.Write("Cannot register F10 as hotkey");
                }
                _f9 = new Hotkey();
                _f9.KeyCode = Keys.F9;
                _f9.Windows = false;
                _f9.Pressed += delegate { StartStopBotting(); };
                try
                {
                    if (!_f9.GetCanRegister(this))
                    {
                        Logging.Write("Cannot register F9 as hotkey");
                    }
                    else
                    {
                        _f9.Register(this);
                    }
                }
                catch
                {
                    Logging.Write("Cannot register F9 as hotkey");
                }
                _hotKeysLoaded = true;
            }
        }

        private void ReleaseHotKeys()
        {
            if (LazySettings.SetupUseHotkeys && _hotKeysLoaded)
            {
                if (_f10.Registered)
                    _f10.Unregister();
                if (_f9.Registered)
                    _f9.Unregister();
            }
        }

        public void LoadPluginButtons()
        {
            foreach (ButtonItem buttonItem in _buttons)
            {
                ControlSettings.Items.Remove(buttonItem);
            }
            _buttons.Clear();
            foreach (string loadedPlugin in PluginCompiler.LoadedPlugins)
            {
                var item = new ButtonItem(PluginCompiler.Assemblys[loadedPlugin].GetName(),
                                          PluginCompiler.Assemblys[loadedPlugin].GetName())
                               {Tag = loadedPlugin};
                item.Click += ShowPluginSettings;
                _buttons.Add(item);
                AddToControlSettings(item);
            }
        }

        private void AddToControlSettings(ButtonItem button)
        {
            if (ControlSettings.InvokeRequired)
            {
                ControlSettings.Invoke(new Action<ButtonItem>(AddToControlSettings), button);
                return;
            }
            ControlSettings.Items.Add(button);
        }

        private void StartStopBotting()
        {
            StartStopEngine.Enabled = false;
            try
            {
                if (LazySettings.HookMouse)
                {
                    Hook.ReleaseMouse();
                }
            }
            catch
            {
            }
            if (ObjectManager.Initialized)
            {
                if (!Engine.Running)
                {
                    StartBotting();
                }
                else
                {
                    ShouldRelog = false;
                    StopBotting(true);
                }
            }
            else
            {
                Logging.Write(LogType.Error, "Please enter the world");
            }
            StartStopEngine.Enabled = true;
        }

        private void DisableItems()
        {
            UpdateComboBoxEx(SelectEngine, false);
            UpdateButtonItem(GeneralSettings, false);
            UpdateButtonItem(EngineSettings, false);
            UpdateComboBoxEx(SelectCombat, false);
            UpdateButtonItem(CombatSettings, false);
        }

        public void EnableItems()
        {
            UpdateComboBoxEx(SelectEngine, true);
            UpdateButtonItem(GeneralSettings, true);
            UpdateButtonItem(EngineSettings, true);
            UpdateComboBoxEx(SelectCombat, true);
            UpdateButtonItem(CombatSettings, true);
        }

        private void PauseBot()
        {
            Engine.Pause();
        }

        public void StartBotting()
        {
            if (!ValidateKeys.AutoLoot)
            {
                Logging.Write(LogType.Error, "Please enable auto loot【打开自动拾取】");
                return;
            }
            if (ValidateKeys.ClickToMove)
            {
                Logging.Write(LogType.Error, "Please disable click to move【禁止点击移动】");
                return;
            }
            BarMapper.MapBars();
            KeyHelper.LoadKeys();
            if (!ValidateKeys.Validate())
            {
                Thread.Sleep(2000);
            }
            Langs.Load();
            if (EngineHandler.EngineStart())
            {
                LazySettings.SaveSettings();
                if (CombatEngine.StartOk)
                {
                    CombatEngine.BotStarted();
                }
                else
                {
                    Logging.Write(LogType.Warning, "CustomClass returned false on StartOk not starting");
                    return;
                }
                Logging.Debug("Relogger: " + ReloggerSettings.ReloggingEnabled);
                Logging.Debug("Engine: " + EngineHandler.Name);
                Logging.Write("Bot started【外挂启动】");
                UpdateText(StartStopEngine, "Stop botting");
                ShouldRelog = ReloggerSettings.ReloggingEnabled;
                LazyForm.Engine = EngineHandler.Name;
                DisableItems();
                Engine.StartEngine(EngineHandler);
                StopAfter.BotStarted();
                PeriodicRelogger.BotStarted();
                PluginManager.BotStart();
                PluginManager.StartPulseThread(true);
            }
            else
            {
                Logging.Write(LogType.Warning, "Engine returned false on load");
            }
        }

        public void HideThis()
        {
            if (InvokeRequired)
            {
                Invoke(
                    new MethodInvoker(
                        delegate { HideThis(); }));
            }
            else
            {
                Hide();
            }
        }

        public void StopBotting(string reason)
        {
            Logging.Write("停止原因: " + reason);
            StopBotting(false);
        }

        public void StopBotting(string reason, bool userStoppedIt)
        {
            Logging.Write("Bot stopping: " + reason);
            StopBotting(userStoppedIt);
        }

        public void StopBotting(bool userStoppedIt)
        {
            CombatHandler.Stop();
            MouseHelper.ReleaseMouse();
            EnableItems();
            StopAfter.BotStopped();
            PeriodicRelogger.BotStopped();
            UpdateText(StartStopEngine, "Start botting");
            if (Engine.Running)
            {
                if (!userStoppedIt && LazySettings.SoundStop)
                {
                    try
                    {
                        if (File.Exists(LazySettings.OurDirectory + @"\falert.wav"))
                        {
                            _soundPlayer.SoundLocation = LazySettings.OurDirectory + @"\falert.wav";
                            _soundPlayer.Play();
                        }
                    }
                    catch
                    {
                        //Empty
                    }
                }
                if (LazySettings.UseCtm)
                {
                    MoveHelper.Forwards(true);
                    MoveHelper.Forwards(false);
                }
                MoveHelper.ReleaseKeys();
                Engine.StopEngine();
                EngineHandler.EngineStop();
                MoveHelper.ReleaseKeys();
                PluginManager.TerminatePulseThread();
                PluginManager.BotStop();
                Thread.Sleep(300);
                Logging.Write("外挂停止");
            }
        }

        private void BtnOpenRadarClick(object sender, EventArgs e)
        {
            OpenRadar();
        }

        private void OpenRadar()
        {
            if (_radar != null && !_radar.IsDisposed)
                _radar.Close();
            _radar = new RadarForm();
            foreach (IDrawItem drawItem in EngineHandler.GetRadarDraw())
            {
                _radar.AddDrawItem(drawItem);
            }
            foreach (IMouseClick mouseClick in EngineHandler.GetRadarClick())
            {
                _radar.AddMonitorMouseClick(mouseClick);
            }
            _radar.Show();
        }

        private void CBTopMostCheckedChanged(object sender, EventArgs e)
        {
            TopMost = CBTopMost.Checked;
        }

        private void CBDebug_CheckedChanged(object sender, EventArgs e)
        {
            if (CBDebug.Checked)
            {
                LazySettings.DebugLog = true;
                LazySettings.SaveSettings();
                Logging.OnDebug += Logging_OnDebug;
            }
            else
            {
                LazySettings.DebugLog = false;
                LazySettings.SaveSettings();
                Logging.OnDebug -= Logging_OnDebug;
            }
        }

        public void LicenseOk()
        {
            UpdateExpandableSplitter(expandableSplitter1, true, true);
            EnableButton(StartStopEngine);
        }

        private void OpenRotator_Click(object sender, EventArgs e)
        {
            var form = new RotatorForm();
            form.Show();
            OpenRotator.Enabled = false;
            form.Closed += RotatorClosed;
        }

        private void RotatorClosed(object sender, EventArgs e)
        {
            OpenRotator.Enabled = true;
        }

        #region Logging

        public void ChatMessage(string message)
        {
            AppendMessage(ChatAll, message, Color.Black);
            SpyFB.CheckPassword(message);
        }

        public void WhisperMessage(string message)
        {
            AppendMessage(ChatWhisper, message, Color.Black);
            SpyFB.CheckPassword(message);
        }

        private void Logging_OnWrite(string message, LogType logType)
        {
            Color col;
            switch (logType)
            {
                case LogType.Error:
                    col = Color.Red;
                    break;
                case LogType.Warning:
                    col = Color.Firebrick;
                    break;
                case LogType.Info:
                    col = Color.BlueViolet;
                    break;
                case LogType.Good:
                    col = Color.Green;
                    break;
                default:
                    col = Color.Black;
                    break;
            }
            AppendMessage(LogWin, message, col);
        }

        private void Logging_OnDebug(string message, LogType logType)
        {
            Color col;
            switch (logType)
            {
                case LogType.Error:
                    col = Color.Red;
                    break;
                case LogType.Warning:
                    col = Color.Firebrick;
                    break;
                case LogType.Info:
                    col = Color.BlueViolet;
                    break;
                case LogType.Good:
                    col = Color.Green;
                    break;
                default:
                    col = Color.Black;
                    break;
            }
            AppendMessage(LogWin, message, col);
        }

        /// <summary>
        /// Writes a message to the specified RichTextBox.
        /// </summary>
        /// <param name="textBox"></param>
        /// <param name="message">The <see cref="string">message</see> to be written.</param>
        /// <param name="col"></param>
        private static void AppendMessage(RichTextBox textBox, string message, Color col)
        {
            try
            {
                if (!textBox.IsDisposed)
                {
                    if (textBox.InvokeRequired)
                    {
                        textBox.Invoke(new Action<RichTextBox, string, Color>(AppendMessage), textBox, message, col);
                        return;
                    }

                    Color oldColor = textBox.SelectionColor;
                    textBox.SelectionColor = col;
                    textBox.AppendText(message);
                    textBox.SelectionColor = oldColor;
                    textBox.AppendText(Environment.NewLine);
                    textBox.ScrollToCaret();
                }
            }
            catch (ThreadAbortException)
            {
                //OnPurpose
            }
            catch
            {
            }
        }

        public void ChatNewChatMessage(object sender, GChatEventArgs e)
        {
            try
            {
                ChatMsg msg = e.Msg;
                if ((msg.Type == Constants.ChatType.Whisper || msg.Type == Constants.ChatType.RealId) &&
                    msg.Player != ObjectManager.MyPlayer.Name)
                {
                    if (LazySettings.SoundWhisper && Engine.Running)
                    {
                        try
                        {
                            if (File.Exists(LazySettings.OurDirectory + @"\palert.wav"))
                            {
                                _soundPlayer.SoundLocation = LazySettings.OurDirectory + @"\palert.wav";
                                _soundPlayer.Play();
                            }
                        }
                        catch
                        {
                        }
                    }
                    if (msg.Type == Constants.ChatType.RealId)
                    {
                        WhisperMessage("Type: " + msg.Type.ToString().ToLower() + ", Text: " + msg.Msg);
                        Logging.Write(LogType.Warning, "Type: " + msg.Type + ", Text: " + msg.Msg);
                    }
                    else
                    {
                        WhisperMessage("Type: " + msg.Type.ToString().ToLower() + ", Player Name: " + msg.Player +
                                       ", Text: " + msg.Msg);
                        Logging.Write(LogType.Warning,
                                      "Type: " + msg.Type + ", Player Name: " + msg.Player + ", Text: " + msg.Msg);
                    }
                    return;
                }
                ChatMessage("Type: " + msg.Type.ToString().ToLower() + ", Player Name: " + msg.Player + ", Text: " +
                            msg.Msg);
            }
            catch
            {
            }
        }

        #endregion

        #region Thread Invokes

        private void UpdateComboBoxEx(ComboBoxEx item, bool enabled)
        {
            if (item.InvokeRequired)
            {
                item.Invoke(new Action<ComboBoxEx, bool>(UpdateComboBoxEx), item, enabled);
                return;
            }
            item.Enabled = enabled;
        }

        private void UpdateButtonItem(ButtonItem items, bool enabled)
        {
            if (items.InvokeRequired)
            {
                items.Invoke(new MethodInvoker(delegate { UpdateButtonItem(items, enabled); }));
                return;
            }
            items.Enabled = enabled;
        }

        public void EnableComboBox(ComboBoxEx combo)
        {
            if (combo.InvokeRequired)
            {
                combo.Invoke(
                    new MethodInvoker(
                        delegate { EnableComboBox(combo); }));
            }
            else
            {
                combo.Enabled = true;
            }
        }

        public void EnableButton(ButtonItem button)
        {
            if (button.InvokeRequired)
            {
                button.Invoke(
                    new MethodInvoker(
                        delegate { EnableButton(button); }));
            }
            else
            {
                button.Enabled = true;
            }
        }

        public void DisableButton(ButtonX button)
        {
            if (button.InvokeRequired)
            {
                button.Invoke(
                    new MethodInvoker(
                        delegate { DisableButton(button); }));
            }
            else
            {
                button.Enabled = false;
            }
        }

        public void EnableButton(ButtonX button)
        {
            if (button.InvokeRequired)
            {
                button.Invoke(
                    new MethodInvoker(
                        delegate { EnableButton(button); }));
            }
            else
            {
                button.Enabled = true;
            }
        }

        /// <summary>
        ///   Updates the text.
        /// </summary>
        /// <param name = "lab">The lab.</param>
        /// <param name = "text">The text.</param>
        public void UpdateText(ButtonX lab, string text)
        {
            if (lab.InvokeRequired)
            {
                lab.Invoke(
                    new MethodInvoker(
                        delegate { UpdateText(lab, text); }));
            }
            else
            {
                lab.Text = text;
            }
        }

        public void UpdateTitle(string text)
        {
            if (InvokeRequired)
            {
                Invoke(
                    new MethodInvoker(
                        delegate { UpdateTitle(text); }));
            }
            else
            {
                Text = text;
            }
        }

        public void DoRefresh()
        {
            if (InvokeRequired)
            {
                Invoke(
                    new MethodInvoker(
                        DoRefresh));
            }
            else
            {
                Refresh();
            }
        }

        public void UpdateGroupControl(GroupPanel groupControl, string text)
        {
            if (groupControl.InvokeRequired)
            {
                groupControl.BeginInvoke(
                    new MethodInvoker(
                        delegate { UpdateGroupControl(groupControl, text); }));
            }
            else
            {
                groupControl.Text = text;
            }
        }

        public void UpdateTextLabel(LabelX labelX, string text)
        {
            if (labelX.InvokeRequired)
            {
                labelX.BeginInvoke(
                    new MethodInvoker(
                        delegate { UpdateTextLabel(labelX, text); }));
            }
            else
            {
                labelX.Text = text;
            }
        }

        public void UpdateProgressBar(ProgressBarX progressBarX, int healtPercentage)
        {
            if (progressBarX.InvokeRequired)
            {
                progressBarX.BeginInvoke(
                    new MethodInvoker(
                        delegate { UpdateProgressBar(progressBarX, healtPercentage); }));
            }
            else
            {
                progressBarX.Value = healtPercentage;
            }
        }

        public void UpdateExpandableSplitter(ExpandableSplitter expandable, bool expanded, bool enabled)
        {
            if (expandable.InvokeRequired)
            {
                expandable.BeginInvoke(
                    new MethodInvoker(
                        delegate { UpdateExpandableSplitter(expandable, expanded, enabled); }));
            }
            else
            {
                expandable.Expanded = expanded;
                expandable.Enabled = enabled;
            }
        }

        #endregion

        #region Custom Classes and Engines

        private void CombatSettings_Click(object sender, EventArgs e)
        {
            if (CombatEngine != null)
            {
                CombatEngine.Settings().Show();
            }
        }

        private void LoadCustomClasses()
        {
            ClassCompiler.RecompileAll();
            SelectCombat.Items.Clear();
            //Now lets add the compiled dlls/files to our combat system
            foreach (var assembly in ClassCompiler.Assemblys)
            {
                var cs = new CustomClass(assembly.Key, assembly.Value.Name);
                SelectCombat.Items.Add(cs);
            }
        }

        private void SelectCombatSelectedIndexChanged(object sender, EventArgs e)
        {
            if (SelectCombat.SelectedIndex != -1)
            {
                LazySettings.SelectedCombat = SelectCombat.Text;
                LazySettings.SaveSettings();
                var cs = (CustomClass) SelectCombat.SelectedItem;
                CombatEngine = ClassCompiler.Assemblys[cs.AssemblyName];
            }
        }

        #endregion

        #region Engines

        private void LoadEngines()
        {
            EngineCompiler.RecompileAll();
            SelectEngine.Items.Clear();
            //Now lets add the compiled dlls/files to our engine system
            foreach (var assembly in EngineCompiler.Assemblys)
            {
                var cs = new CustomEngine(assembly.Key, assembly.Value.Name);
                SelectEngine.Items.Add(cs);
            }
        }

        private void EngineSettings_Click(object sender, EventArgs e)
        {
            if (EngineHandler != null)
            {
                EngineHandler.Settings.Show();
            }
        }

        private void BtnProfileSettingsClick(object sender, EventArgs e)
        {
            if (EngineHandler != null)
            {
                EngineHandler.ProfileForm.Show();
            }
        }

        private void SelectEngineSelectedIndexChanged(object sender, EventArgs e)
        {
            if (SelectEngine.SelectedIndex != -1)
            {
                var cs = (CustomEngine) SelectEngine.SelectedItem;
                LazySettings.SelectedEngine = SelectEngine.Text;
                LazySettings.SaveSettings();
                EngineHandler = EngineCompiler.Assemblys[cs.AssemblyName];
                EngineHandler.Load();
                if (_radar != null && !_radar.IsDisposed)
                {
                    OpenRadar();
                }
            }
        }

        #endregion

        #region Control events

        private void UpdateStateChange(object sender, Engine.NotifyStateChanged e)
        {
            UpdateStateText(e.Name);
        }

        private void BtnDebugClick(object sender, EventArgs e)
        {
            var debug = new Debug();
            debug.Show();
        }

        private void ShowPluginSettings(object sender, EventArgs e)
        {
            var item = (ButtonItem) sender;
            if (PluginCompiler.LoadedPlugins.Contains(item.Tag.ToString()))
            {
                PluginCompiler.Assemblys[item.Tag.ToString()].Settings();
            }
        }

        private void LazySettingsClick(object sender, EventArgs e)
        {
            LazyForms.SetupForm.ShowDialog();
            LazyForms.SetupForm = new Setup();
            LoadPluginButtons();
        }

        private void StartEngineClick(object sender, EventArgs e)
        {
            StartStopBotting();
        }

        private void Expander(object sender, ExpandedChangeEventArgs e)
        {
            //Size = expandableSplitter1.Expanded ? new Size(481, 445) : new Size(350, 445);
        }

        private void ChatSendTextClick(object sender, EventArgs e)
        {
            if (ChatTBSendText.Text != "")
            {
                ChatQueu.AddChat(ChatTBSendText.Text);
                ChatTBSendText.Text = "";
            }
        }

        public void UpdateStatsText(string text)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(UpdateStatsText), text);
                return;
            }
            StatsText.Text = text;
        }

        public void UpdateStateText(string text)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(UpdateStateText), text);
                return;
            }
            Text = text;
        }

        #endregion

        #region Debug

        private Thread _killDummy;
        private Process[] _wowProc = Process.GetProcessesByName("Wow");

        private void MainBtnRefreshProcessClick(object sender, EventArgs e)
        {
            MainComProcessSelection.Items.Clear();
            MainComProcessSelection.Update();
            _wowProc = Process.GetProcessesByName("Wow");
            foreach (Process proc in _wowProc)
            {
                string name = "Not ingame";
                if (Memory.OpenProcess(proc.Id))
                {
                    try
                    {
                        if (Memory.Read<byte>(Memory.BaseAddress + (uint)PublicPointers.InGame.InGame) == 1)
                        {
                            try
                            {
                                name = Memory.ReadUtf8(Memory.BaseAddress + (uint)PublicPointers.Globals.PlayerName, 256);
                            }
                            catch
                            {
                            }
                        }
                    }
                    catch
                    {
                    }
                }
                MainComProcessSelection.Items.Add(proc.MainWindowTitle + "- " + proc.Id + " - " + name);
            }
            if (MainComProcessSelection.Items.Count == 0)
                MainComProcessSelection.Items.Add("No game");
            MainComProcessSelection.SelectedIndex = 0;
        }

        private void MainBtnSelectProcessClick(object sender, EventArgs e)
        {
            if (MainComProcessSelection.SelectedItem != null)
            {
                if (MainComProcessSelection.SelectedText != "No game" &&
                    MainComProcessSelection.SelectedItem.ToString() != "No game")
                {
                    ObjectManager.Initialize(_wowProc[MainComProcessSelection.SelectedIndex].Id);
                    Hook.DoHook();
                }
            }
        }

        private void DebugBtnClassRecompileClick(object sender, EventArgs e)
        {
            ClassCompiler.RecompileAll();
        }

        private void DebugBtnShouldRepairClick(object sender, EventArgs e)
        {
            if (ObjectManager.InGame)
            {
                Logging.Write("Should repair: " + ObjectManager.MyPlayer.ShouldRepair);
            }
        }

        /*
        private void LogRepair()
        {
            if (ObjectManager.Initialized)
            {
                foreach (uint u in ObjectManager.MyPlayer.GetItemsEquippedId)
                {
                    string name = "";
                    double durability = 0;
                    bool foundit = false;
                    foreach (PItem pItem in ObjectManager.GetItems)
                    {
                        if (pItem.EntryId.Equals(u))
                        {
                            foundit = true;
                            try
                            {
                                name = WowHeadData.GetWowHeadItem(u)["name"];
                            }
                            catch
                            {
                                Logging.Write("Wowhead down");
                            }
                            durability = pItem.GetDurabilityPercentage;
                        }
                    }
                    if (!foundit)
                    {
                        if (u != 0)
                        {
                            Logging.Write("Found an item with id " + u +
                                          " that does not exist. Assuming it is broken, going to repair");
                        }
                    }
                    else
                    {
                        Logging.Write("Found item " + name + " Durability: " + durability);
                    }
                }
                Logging.Write("Should repair: " + ObjectManager.MyPlayer.ShouldRepair);
            }
        } */

        private void DebugBtnLogTargetBuffClick(object sender, EventArgs e)
        {
            if (ObjectManager.InGame)
            {
                if (ObjectManager.MyPlayer.IsValid)
                {
                    IEnumerable<PUnit.WoWAura> buffs = ObjectManager.MyPlayer.Target.GetAuras;
                    foreach (PUnit.WoWAura buff in buffs)
                    {
                        try
                        {
                            Logging.Write(buff.SpellId + " : " + WowHeadData.GetWowHeadSpell(buff.SpellId) +
                                          " : Is player owner: " +
                                          (buff.OwnerGUID == ObjectManager.MyPlayer.GUID ||
                                           buff.OwnerGUID == ObjectManager.MyPlayer.PetGUID) + " : Stack:" + buff.Stack +
                                          " : Seconds left: " + buff.SecondsLeft);
                        }
                        catch
                        {
                            Logging.Write(buff.SpellId + "");
                        }
                    }
                }
            }
        }

        private void DebugBtnLogOwnBuffClick(object sender, EventArgs e)
        {
            if (ObjectManager.InGame)
            {
                IEnumerable<PUnit.WoWAura> buffs = ObjectManager.MyPlayer.GetAuras;
                foreach (PUnit.WoWAura buff in buffs)
                {
                    try
                    {
                        Logging.Write(buff.SpellId + " : " + WowHeadData.GetWowHeadSpell(buff.SpellId) +
                                      " : Is player owner: " +
                                      (buff.OwnerGUID == ObjectManager.MyPlayer.GUID ||
                                       buff.OwnerGUID == ObjectManager.MyPlayer.PetGUID) + " : Stack:" + buff.Stack +
                                      " : Seconds left: " + buff.SecondsLeft);
                    }
                    catch
                    {
                        Logging.Write(buff.SpellId + "");
                    }
                }
            }
        }

        private void StopnAttackTargetDummyClick(object sender, EventArgs e)
        {
            if (_killDummy != null && _killDummy.IsAlive)
            {
                CombatHandler.Stop();
                _killDummy.Abort();
                _killDummy = null;
            }
            BtnAttackTargetDummy.Enabled = true;
        }

        private void BtnAttackTargetDummyClick(object sender, EventArgs e)
        {
            if (ObjectManager.InGame)
            {
                Langs.Load();
                if (ObjectManager.MyPlayer.IsValid && Langs.TrainingDummy(ObjectManager.MyPlayer.Target.Name))
                {
                    if (_killDummy == null || !_killDummy.IsAlive)
                    {
                        KeyHelper.LoadKeys();
                        BarMapper.MapBars();
                        if (CombatEngine.StartOk)
                        {
                            CombatEngine.BotStarted();
                        }
                        else
                        {
                            Logging.Write(LogType.Warning, "CustomClass returned false on StartOk not starting");
                            return;
                        }
                        _killDummy = new Thread(KillTheDummy);
                        _killDummy.Name = "KillDummy";
                        _killDummy.IsBackground = true;
                        _killDummy.Start();
                    }
                    BtnAttackTargetDummy.Enabled = false;
                }
                else
                {
                    Logging.Write("Please target a Training dummy ingame");
                }
            }
        }

        private void KillTheDummy()
        {
            try
            {
                if (ObjectManager.MyPlayer.IsValid)
                {
                    if (CombatEngine.StartOk)
                    {
                        CombatEngine.BotStarted();
                        CombatHandler.StartCombat(ObjectManager.MyPlayer.Target);
                    }
                    else
                    {
                        Logging.Write(LogType.Warning, "CustomClass returned false on StartOk not starting");
                        return;
                    }
                }
            }
            catch
            {
            }
        }

        #endregion

        private void buttonX1_Click(object sender, EventArgs e)
        {
            SpyData.GetAllSpell();
        }

        private void buttonX2_Click(object sender, EventArgs e)
        {
            testForm myform;
            myform = new testForm();
            myform.Show();
            myform = null;
            //Dictionary<string,int> hhh = SpyFrame.lua_GetBagInfo();
            //Logging.Write("fff");
        }

        SpyWOW nn = new SpyWOW();
        private void buttonX3_Click(object sender, EventArgs e)
        {
            if (buttonX3.Text.Equals("开始计划"))
            {
                if (string.IsNullOrEmpty(LazySettings.WOWPath)
                    || string.IsNullOrEmpty(LazySettings.WOWAccName)
                    || string.IsNullOrEmpty(LazySettings.WOWAccPass)
                    //|| string.IsNullOrEmpty(LazySettings.WOWCharList)  角色列表可以不用
                    || string.IsNullOrEmpty(LazySettings.WOWCharIdx)
                    || string.IsNullOrEmpty(LazySettings.WOWServer)
                    || string.IsNullOrEmpty(LazySettings.StartHour)
                    || string.IsNullOrEmpty(LazySettings.StartMin)
                    || string.IsNullOrEmpty(LazySettings.StopHour)
                    || string.IsNullOrEmpty(LazySettings.StopMin)
                    || string.IsNullOrEmpty(LazySettings.FightFile)
                    || string.IsNullOrEmpty(LazySettings.MapFile))
                {
                    Logging.Write("配置文件中，有空项，补全！");
                    return;
                }
                nn.StartHour = Convert.ToInt32(LazySettings.StartHour);
                nn.StartMin = Convert.ToInt32(LazySettings.StartMin);
                nn.StopHour = Convert.ToInt32(LazySettings.StopHour);
                nn.StopMin = Convert.ToInt32(LazySettings.StopMin);

                buttonX3.Text = "结束计划";
                Logging.Write("计划开始。。。。。。。");
                nn.StartProc();
            }
            else
            {
                buttonX3.Text = "开始计划";
                Logging.Write("计划结束!!!!!!!!");
                nn.StopProc();
            }
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            comboBoxCharList.Items.Clear();
            Dictionary<string, string> chars = new Dictionary<string, string>();
            chars = SpyDB.GetChars();
            if (chars.Count == 0) return;
            foreach (KeyValuePair<string, string> kk in chars)
            {
                comboBoxCharList.Items.Add(kk);
            }
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(comboBoxCharList.Text)) return;
            KeyValuePair<string, string> singlechar = (KeyValuePair<string, string>)comboBoxCharList.SelectedItem;
            Dictionary<string, string> result = SpyDB.GetCharLoginInfo(singlechar.Key);
            if (result.Count == 0)
            {
                MessageBox.Show("数据库没有找到信息，检查视图v_login_info的数据");
                return;
            }

            SpyLogin.initme(result["AccountName"], result["AccountPass"], result["RealmName"], result["CharIdx"], result["AccountList"]);
            SpyLogin.start();
            while (!SpyLogin.IsOK) { Thread.Sleep(100); };
            //MessageBox.Show("OKOK_____AUTO Login");
            ObjectManager.Initialize(SpyLogin.WOW_P.Id);
        }

        private void buttonItem4_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem4.Text.Equals("血色-图书馆（开始）"))
            {
                buttonItem4.Text = "血色-图书馆（停止）";
                SpyFB.XSXDY_TSG(txtDaHao.Text);
            }
            else
            {
                buttonItem4.Text = "血色-图书馆（开始）";
            }
        }

        private void buttonItem1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem1.Text.Equals("血色-墓地（开始）"))
            {
                buttonItem1.Text = "血色-墓地（停止）";
                SpyFB.XSXDY_MD(txtDaHao.Text);
            }
            else
            {
                buttonItem1.Text = "血色-墓地（开始）";
            }
        }

        private void buttonItem2_Click(object sender, EventArgs e)
        {
            //STSM-前门（开始）
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem2.Text.Equals("STSM-前门（开始）"))
            {
                buttonItem2.Text = "STSM-前门（停止）";
                SpyFB.STSM_For(txtDaHao.Text);
            }
            else
            {
                buttonItem2.Text = "STSM-前门（开始）";
            }
        }

        private void buttonItem3_Click(object sender, EventArgs e)
        {
            //神庙副本（开始）
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem3.Text.Equals("神庙副本（开始）"))
            {
                buttonItem3.Text = "神庙副本（停止）";
                SpyFB.ATHKSM(txtDaHao.Text);
            }
            else
            {
                buttonItem3.Text = "神庙副本（开始）";
            }
        }

        private void buttonItem5_Click(object sender, EventArgs e)
        {
            //外域—城墙（开始）
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem5.Text.Equals("外域—城墙（开始）"))
            {
                buttonItem5.Text = "外域—城墙（停止）";
                SpyFB.WY_CQ(txtDaHao.Text);
            }
            else
            {
                buttonItem5.Text = "外域—城墙（开始）";
            }
        }

        private void buttonItem6_Click(object sender, EventArgs e)
        {
            //外域-魔导师平台（开始）
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem6.Text.Equals("外域-魔导师平台（开始）"))
            {
                buttonItem6.Text = "外域-魔导师平台（停止）";
                SpyFB.WY_MDSPT(txtDaHao.Text);
            }
            else
            {
                buttonItem6.Text = "外域-魔导师平台（开始）";
            }
        }

        private void buttonItem7_Click(object sender, EventArgs e)
        {
            //WLK-古达克（开始）
            if (string.IsNullOrWhiteSpace(txtDaHao.Text))
            {
                MessageBox.Show("在下面的框框里面输入大号的名字");
                return;
            }
            if (buttonItem7.Text.Equals("WLK-古达克（开始）"))
            {
                buttonItem7.Text = "WLK-古达克（停止）";
                SpyFB.WLK_GDK(txtDaHao.Text);
            }
            else
            {
                buttonItem7.Text = "WLK-古达克（开始）";
            }
        }



    }
}