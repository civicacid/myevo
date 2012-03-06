
﻿/*
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
#region

using System.Reflection;

#endregion

namespace LazyLib.Wow
{
    [Obfuscation(Feature = "renaming", ApplyToMembers = true)]
    public class PublicPointers
    {
        #region Globals enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum Globals
        {
            // PlayerName = 0x9BE6B8,   // 4.3
            //PlayerName = 0x9Bd070,   // 4.3.2
            PlayerName = 0x9Bca38,   // 4.3.3
        }

        #endregion

        #region InGame enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum InGame
        {
            // InGame = 0xAD7296, //4.3
            //InGame = 0xAD5C76, //4.3.2
            InGame = 0xAD5636, //4.3.3
        }

        #endregion
    }

    internal class Pointers
    {
        #region ActionBar enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum ActionBar
        {
            //ActionBarFirstSlot = 0xB440E0,  // 4.3
            //ActionBarBonus = 0xB44324,      // 4.3
            //ActionBarFirstSlot = 0xB42AC8,  // 4.3.2
            //ActionBarBonus = 0xB42D0C,      // 4.3.2
            ActionBarFirstSlot = 0xB42490,  // 4.3.3
            ActionBarBonus = 0xB426D4,      // 4.3.3
        }

        #endregion

        #region AutoLoot enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum AutoLoot
        {
            //Pointer = 0xAD74A0,  //4.3
            //Offset = 0x30,       //4.3
            //Pointer = 0xAD5E8C,  //4.3.2
            //Offset = 0x30,       //4.3.2
            Pointer = 0xAD5854,  //4.3.3
            Offset = 0x30,       //4.3.3
        }

        #endregion

        #region CgUnitCGetCreatureRank enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum CgUnitCGetCreatureRank
        {
            //Offset1 = 0x91C,  //4.3 
            //Offset2 = 0x1C,   //4.3
            Offset1 = 0x91C,  //4.3.2 
            Offset2 = 0x1C,   //4.3.2
        }

        #endregion

        #region CgUnitCGetCreatureType enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum CgUnitCGetCreatureType
        {
            //Offset1 = 0x91C,    //4.3
            //Offset2 = 0x14,     //4.3
            Offset1 = 0x91C,    //4.3.2
            Offset2 = 0x14,     //4.3.2
        }

        #endregion

        #region CgWorldFrameGetActiveCamera enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum CgWorldFrameGetActiveCamera
        {
            //CameraPointer = 0xAD7870,  //4.3
            //CameraOffset = 0x80D0,      //4.3
            //CameraX = 0x8,      //4.3
            //CameraY = 0xC,      //4.3
            //CameraZ = 0x10,     //4.3  
            //CameraMatrix = 0x14,    //4.3
            //CameraPointer = 0xAD6258,  //4.3.2
            CameraOffset = 0x80D0,      //4.3.2
            CameraX = 0x8,      //4.3.2
            CameraY = 0xC,      //4.3.2
            CameraZ = 0x10,     //4.3.2
            CameraMatrix = 0x14,    //4.3.2
            CameraPointer = 0xAD6258 - 0x638,  //4.3.3
        }

        #endregion

        /// <summary>
        ///   4.3
        /// </summary>
        public enum Quests
        {
            //ActiveQuests = 0x274,  //4.3
            //SelectedQuestId = 0xB436F0, //4.3
            //TitleText = 0xB434D0,   //4.3
            //GossipQuests = 0xB70F08,    //4.3
            //GossipQuestNext = 0x214,    //4.3
            ActiveQuests = 0x274,  //4.3.2?
            SelectedQuestId = 0xB436F0, //4.3.2?
            TitleText = 0xB434D0,   //4.3.2?
            GossipQuests = 0xB70F08,    //4.3.2?
            GossipQuestNext = 0x214,    //4.3.2?
        }

        #region ClickToMove enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum ClickToMove
        {
            //Pointer = 0xAD7480,     //4.3
            //Offset = 0x30,          //4.3
            //Pointer = 0xAD5E6C,     //4.3.2
            Offset = 0x30,          //4.3.2
            Pointer = 0xAD5E6C - 0x638,     //4.3.3
        }

        #endregion

        #region IsFlying enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum IsFlying
        {
            // Reversed from Lua_IsFlying
            //            Pointer = 0x100,    //4.3
            //            Offset = 0x38,      //4.3
            //            Mask = 0x1000000    //4.3
            Pointer = 0x100,    //4.3.2
            Offset = 0x38,      //4.3.2
            Mask = 0x1000000    //4.3.2
        }

        #endregion

        #region Nested type: AutoAttack

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum AutoAttack
        {
            //            AutoAttackFlag = 0x9E8,  //4.3
            //            AutoAttackMask = 0x9EC,  //4.3
            AutoAttackFlag = 0x9E8,  //4.3.2?
            AutoAttackMask = 0x9EC,  //4.3.2?
        }

        #endregion

        #region Nested type: CastingInfo

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum CastingInfo
        {
            //IsCasting = 0xA34,  //4.3
            //ChanneledCasting = 0xA48,   //4.3
            IsCasting = 0xA34,  //4.3.2?
            ChanneledCasting = 0xA48,   //4.3.2?
        }

        #endregion

        #region Nested type: Chat

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Chat : uint
        {
            //ChatStart = 0xAD8FD0 + 0x3C,    //4.3
            //OffsetToNextMsg = 0x17C0,       //4.3
            //ChatStart = 0xAD79B8,    //4.3.2
            ChatStart = 0xAD79B8 - 0x638 + 0x3C,    //4.3.3
            OffsetToNextMsg = 0x17C0,       //4.3.2
        }

        #endregion

        #region BlueChat
        /// <summary>
        ///   4.2  - Not updated
        /// </summary>
        internal enum Messages
        {
            //EventMessage = 0xA98068 //4.3
            //EventMessage = 0xA98068 //4.3.2?
            EventMessage = 0xA96A50 //4.3.3?
        }

        #endregion

        #region Nested type: ComboPoints

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum ComboPoints
        {
            //ComboPoints = 0xAD7361, //4.3
            //ComboPoints = 0xAD5D41, //4.3.2
            ComboPoints = 0xAD5D41 - 0x638, //4.3.3
        }

        #endregion

        #region Nested type: Container

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Container
        {
            //EquippedBagGUID = 0xB4DC38,  //4.3
            //EquippedBagGUID = 0xB4C620,  //4.3.2
            EquippedBagGUID = 0xB4C620 - 0x638,  //4.3.3
        }

        #endregion

        #region Nested type: Globals

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Globals
        {
            //            RedMessage = 0xAD6698,  //4.3
            //            MouseOverGUID = 0xAD72A8,   //4.3
            //            LootWindow = 0xB45088,      //4.3
            //            IsBobbing = 0xD4,           //4.3
            //            ArchFacing = 0x1c8,         //4.3
            //            ChatboxIsOpen = 0xAC6C58,   //4.3
            //            CursorType = 0x93D0E0,      //4.3
            //            RedMessage = 0xAD5078,  //4.3.2
            //            MouseOverGUID = 0xAD5C88,   //4.3.2
            //            LootWindow = 0xB43A70,      //4.3.2
            //            IsBobbing = 0xD4,           //4.3.2?
            //            ArchFacing = 0x1c8,         //4.3.2?
            //            ChatboxIsOpen = 0xAC5628,   //4.3.2
            //            CursorType = 0x93BAA0,      //4.3.2
            RedMessage = 0xAD5078 - 0x640,  //4.3.3
            MouseOverGUID = 0xAD5C88 - 0x640,   //4.3.3
            LootWindow = 0xB43A70 - 0x638,      //4.3.3
            IsBobbing = 0xD4,           //4.3.3
            ArchFacing = 0x1c8,         //4.3.3
            ChatboxIsOpen = 0xAC5628 - 0x640,   //4.3.3
            CursorType = 0x93BAA0 - 0x638,      //4.3.3
        }

        #endregion

        #region Nested type: Items

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Items : uint
        {
            //Offset = 0x998580,  //4.3
            //Offset = 0x996F38,  //4.3.2
            Offset = 0x996F38 - 0x638,  //4.3.3
        }

        #endregion

        #region Nested type: KeyBinding

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum KeyBinding
        {
            //NumKeyBindings = 0xB33D04,  //4.3
            //First = 0xC8,               //4.3
            //Next = 0xC0,       //4.3
            //Key = 0x14,   //4.3
            //Command = 0x28,    //4.3
            //NumKeyBindings = 0xB326EC,   //4.3.2
            NumKeyBindings = 0xB326EC - 0x638,   //4.3.3
            First = 0xC8, //4.3.2
            Next = 0xC0,//4.3.2
            Key = 0x14,//4.3.2
            Command = 0x28,//4.3.2
        }

        #endregion

        #region Nested type: ObjectManager

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum ObjectManager
        {
            //CurMgrPointer = 0x9BE678,   //4.3
            //CurMgrOffset = 0x463C,      //4.3
            //NextObject = 0x3C,          //4.3.0.15005
            //FirstObject = 0xC0,         //4.3.0.15005
            //LocalGUID = 0xC8             //4.3.0.15005
            //CurMgrPointer = 0x9BD030,   //4.3.2
            //CurMgrOffset = 0x463C,      //4.3.2
            NextObject = 0x3C,          //4.3.2
            FirstObject = 0xC0,         //4.3.2
            LocalGUID = 0xC8,           //4.3.2
            CurMgrPointer = 0x9BD030 - 0x638,   //4.3.3
            CurMgrOffset = 0x463C,      //4.3.3
        }

        #endregion

        #region Nested type: Reaction

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Reaction : uint
        {
            //FactionStartIndex = 0x998FB4,       //4.3
            //FactionPointer = FactionStartIndex + 0xC,   //4.3
            //FactionTotal = FactionStartIndex - 0x4,     //4.3
            //HostileOffset1 = 0x14,          //4.3
            //HostileOffset2 = 0x0C,          //4.3
            //FriendlyOffset1 = 0x10,         //4.3
            //FriendlyOffset2 = 0x0C,         //4.3
            //FactionStartIndex = 0x99796c,       //4.3.2
            FactionStartIndex = 0x99796c - 0x638,       //4.3.3
            FactionPointer = FactionStartIndex + 0xC,   //4.3.2
            FactionTotal = FactionStartIndex - 0x4,     //4.3.2
            HostileOffset1 = 0x14,          //4.3.2
            HostileOffset2 = 0x0C,          //4.3.2
            FriendlyOffset1 = 0x10,         //4.3.2
            FriendlyOffset2 = 0x0C,         //4.3.2
        }

        #endregion

        #region Nested type: Runes

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Runes
        {
            //RunesOffset = 0xB35EB8,     //4.3
            //RunesOffset = 0xB3483C,     //4.3.2?  +0x64?
            RunesOffset = (0xB3483C - 0x638) + 0x64,     //4.3.3?  +0x64?
        }

        #endregion

        #region Nested type: ShapeshiftForm

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum ShapeshiftForm
        {
            //BaseAddressOffset1 = 0xF8,      //4.3
            //BaseAddressOffset2 = 0x1B7,     //4.3
            BaseAddressOffset1 = 0xF8,      //4.3.2?
            BaseAddressOffset2 = 0x1B7,     //4.3.2?
        }

        #endregion

        #region Nested type: SpellCooldown

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum SpellCooldown : uint
        {
            //CooldPown = 0xACD584,   //4.3
            //CooldPown = 0xACBF64,   //4.3.2?
            CooldPown = 0xACBF64 - 0x640,   //4.3.3
        }

        #endregion

        #region Nested type: Swimming

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Swimming
        {
            //Pointer = 0x100,    //4.3
            //Offset = 0x38,      //4.3
            //Mask = 0x100000,    //4.3
            Pointer = 0x100,    //4.3.2
            Offset = 0x38,      //4.3.2
            Mask = 0x100000,    //4.3.2
        }

        #endregion

        #region Nested type: UnitAuras

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UnitAuras : uint
        {
            //AuraCount1 = 0xE90, //4.3
            //AuraCount2 = 0xC14, //4.3
            //AuraTable1 = 0xC10, //4.3
            //AuraTable2 = 0xC18, //4.3
            //AuraSize = 0x28, //4.3
            //AuraSpellId = 0x8, //4.3
            //AuraStack = 0xF, //4.3
            //TimeLeft = 0x14, //4.3
            AuraCount1 = 0xE90, //4.3.2
            AuraCount2 = 0xC14, //4.3.2
            AuraTable1 = 0xC10, //4.3.2
            AuraTable2 = 0xC18, //4.3.2
            AuraSize = 0x28, //4.3.2
            AuraSpellId = 0x8, //4.3.2
            AuraStack = 0xE, //4.3.2?
            TimeLeft = 0x10, //4.3.2?
        } ;

        #endregion

        #region Nested type: UnitName

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UnitName : uint
        {
            //ObjectName1 = 0x1CC, //4.3
            //ObjectName2 = 0xB4, //4.3
            //UnitName1 = 0x91C, //4.3
            //UnitName2 = 0x64, //4.3
            //PlayerNameCachePointer = 0x997F48, //4.3
            //PlayerNameMaskOffset = 0x024, //4.3
            //PlayerNameBaseOffset = 0x01c, //4.3
            //PlayerNameStringOffset = 0x020 //4.3
            ObjectName1 = 0x1CC, //4.3.2
            ObjectName2 = 0xB4, //4.3.2
            UnitName1 = 0x91C, //4.3.2
            UnitName2 = 0x64, //4.3.2
            //PlayerNameCachePointer = 0x996900, //4.3.2
            //PlayerNameMaskOffset = 0x024, //4.3.2
            //PlayerNameBaseOffset = 0x01c, //4.3.2
            //PlayerNameStringOffset = 0x020 //4.3.2
            PlayerNameCachePointer = 0x996900 - 0x638, //4.3.3
            PlayerNameMaskOffset = 0x024, //4.3.3
            PlayerNameBaseOffset = 0x01c, //4.3.3
            PlayerNameStringOffset = 0x020 //4.3.3
        }

        #endregion

        #region Nested type: UnitSpeed

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UnitSpeed
        {
            //Pointer1 = 0x100, //4.3
            //Pointer2 = 0x80, //4.3
            Pointer1 = 0x100, //4.3.2?
            Pointer2 = 0x80, //4.3.2?
        }

        #endregion

        #region Nested type: WowObject

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum WowObject
        {
            //X = 0x790, //4.3
            //Y = X + 0x4, //4.3
            //Z = X + 0x8, //4.3
            //RotationOffset = X + 0x10, //4.3
            //GameObjectX = 0x110, //4.3
            //GameObjectY = GameObjectX + 0x4, //4.3
            //GameObjectZ = GameObjectX + 0x8, //4.3
            X = 0x790, //4.3.2?
            Y = X + 0x4, //4.3.2?
            Z = X + 0x8, //4.3.2?
            RotationOffset = X + 0x10, //4.3.2?
            GameObjectX = 0x110, //4.3.2?
            GameObjectY = GameObjectX + 0x4, //4.3.2?
            GameObjectZ = GameObjectX + 0x8, //4.3.2?
        }

        #endregion

        #region Nested type: Zone

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Zone : uint
        {
            //ZoneText = 0xAD7288, //4.3
            //ZoneID = 0xAD7320, //4.3
            //ZoneText = 0xAD5C6C, //4.3.2
            //ZoneID = 0xAD5D00, //4.3.2
            ZoneText = 0xAD5C6C - 0x644, //4.3.3 (Messed up for 4.3.2?)
            ZoneID = 0xAD5D00 - 0x640, //4.3.3
        }

        #endregion


        #region Nested type: UiFrame

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UiFrame
        {
            ButtonEnabledPointer = 0x200, //4.3.2?
            ButtonEnabledMask = 0xF, //4.3.2?
            ButtonChecked = 0x238, //4.3.2?
            EditBoxText = 0x218, //4.3.2?
            FirstFrame = 0xce4, //4.3.2?
            FrameBottom = 0x68, //4.3.2?
            FrameLeft = 0x6c, //4.3.2?
            FrameTop = 0x70, //4.3.2?
            FrameRight = 0x74, //4.3.2?
            LabelText = 0xEC, //4.3.2?
            Name = 0x1C, //4.3.2?
            NextFrame = 0xCDC, //4.3.2?
            RegionsFirst = 0x170, //4.3.2?
            RegionsNext = 0x168, //4.3.2?
            //FrameBase = 0x9D2154, //4.3.2
            //ScrHeight = 0x9083CC, //4.3.2
            //ScrWidth = 0x9083C8, //4.3.2
            Visible = 0x64, //4.3.2?
            Visible1 = 0x1A, //4.3.2?
            Visible2 = 1, //4.3.2?
            //CurrentFrameOffset = 0x88, //4.3.2?
            //CurrentFramePtr = 0x9D2154, //4.3.2
            FrameBase = 0x9D2154 - 0x638, //4.3.3
            ScrHeight = 0x9083CC - 0x610, //4.3.3
            ScrWidth = 0x9083C8 - 0x610, //4.3.3
            CurrentFrameOffset = 0x88, //4.3.3
            CurrentFramePtr = 0x9D2154 - 0x638, //4.3.3
        }

        #endregion
    }
}