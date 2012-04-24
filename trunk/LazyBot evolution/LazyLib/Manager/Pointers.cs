
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
            //PlayerName = 0x9Bca38,   // 4.3.3
            PlayerName = 0x9be820,   // 4.3.4
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
            //InGame = 0xAD5636, //4.3.3
            InGame = 0xad7426, //4.3.4
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
            ActionBarBonus = 0xb444cc,
            ActionBarFirstSlot = 0xb44288
        }

        #endregion

        #region AutoLoot enum

        /// <summary>
        ///   4.3
        /// </summary>
        public enum AutoLoot
        {
            Pointer = 0xad7644,  //4.3.3
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
            CameraOffset = 0x80D0,      //4.3.2
            CameraX = 0x8,      //4.3.2
            CameraY = 0xC,      //4.3.2
            CameraZ = 0x10,     //4.3.2
            CameraMatrix = 0x14,    //4.3.2
            CameraPointer = 0xad7a10,  //4.3.3
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
            Pointer = 0xad7624,     //4.3.3
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
            ChatStart = 0xad91ac,    //4.3.3
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
            EventMessage = 0xad6828 //4.3.3?
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
            ComboPoints = 0xad74f1 //4.3.3
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
            EquippedBagGUID = 0xb4dde0  //4.3.3
        }

        #endregion

        #region Nested type: Globals

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Globals
        {
            RedMessage = 0xad6828,      //4.3.4
            MouseOverGUID = 0xad7438,   //4.3.4
            LootWindow = 0xb45230,      //4.3.4
            IsBobbing = 0xD4,           //4.3.4
            ArchFacing = 0x1c8,         //4.3.4
            ChatboxIsOpen = 0xac6dd4,   //4.3.4
            CursorType = 0x93d250       //4.3.4
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
            Offset = 0x9986e8,  //4.3.3
        }

        #endregion

        #region Nested type: KeyBinding

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum KeyBinding
        {
            NumKeyBindings = 0xb33eac,   //4.3.3
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
            NextObject = 0x3C,          //4.3.2
            FirstObject = 0xC0,         //4.3.2
            LocalGUID = 0xC8,           //4.3.2
            CurMgrPointer = 0x9be7e0,   //4.3.3
            CurMgrOffset = 0x463C,      //4.3.3
        }

        #endregion

        #region Nested type: Reaction

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Reaction : uint
        {
            FactionPointer = 0x999128,
            FactionStartIndex = 0x99911c,
            FactionTotal = 0x999118,
            FriendlyOffset1 = 0x10,
            FriendlyOffset2 = 12,
            HostileOffset1 = 20,
            HostileOffset2 = 12
        }

        #endregion

        #region Nested type: Runes

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Runes
        {
            RunesOffset = 0xb36060,     //4.3.3?  +0x64?
        }

        #endregion

        #region Nested type: ShapeshiftForm

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum ShapeshiftForm
        {
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
            CooldPown = 0xacd714,   //4.3.3
        }

        #endregion

        #region Nested type: Swimming

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Swimming
        {
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
            AuraCount1 = 0xe90,
            AuraCount2 = 0xc14,
            AuraSize = 40,
            AuraSpellId = 8,
            AuraStack = 15,
            AuraTable1 = 0xc10,
            AuraTable2 = 0xc18,
            TimeLeft = 20
        } ;

        #endregion

        #region Nested type: UnitName

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UnitName : uint
        {
            ObjectName1 = 460,
            ObjectName2 = 180,
            PlayerNameBaseOffset = 0x1c,
            PlayerNameCachePointer = 0x9980b0,
            PlayerNameMaskOffset = 0x24,
            PlayerNameStringOffset = 0x20,
            UnitName1 = 0x91c,
            UnitName2 = 100
        }

        #endregion

        #region Nested type: UnitSpeed

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UnitSpeed
        {
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
            GameObjectX = 0x110,
            GameObjectY = 0x114,
            GameObjectZ = 280,
            RotationOffset = 0x7a0,
            X = 0x790,
            Y = 0x794,
            Z = 0x798
        }

        #endregion

        #region Nested type: Zone

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum Zone : uint
        {
            ZoneID = 0xad74b0,
            ZoneText = 0xad741c
        }

        #endregion


        #region Nested type: UiFrame

        /// <summary>
        ///   4.3
        /// </summary>
        internal enum UiFrame
        {
            ButtonChecked = 0x238,
            ButtonEnabledMask = 15,
            ButtonEnabledPointer = 0x200,
            CurrentFrameOffset = 0x88,
            CurrentFramePtr = 0x9d3904,
            EditBoxText = 0x218,
            FirstFrame = 0xce4,
            FrameBase = 0x9d3904,
            FrameBottom = 0x68,
            FrameLeft = 0x6c,
            FrameRight = 0x74,
            FrameTop = 0x70,
            LabelText = 0xec,
            Name = 0x1c,
            NextFrame = 0xcdc,
            RegionsFirst = 0x170,
            RegionsNext = 360,
            ScrHeight = 0x9096bc,
            ScrWidth = 0x9096b8,
            Visible = 100,
            Visible1 = 0x1a,
            Visible2 = 1
        }

        #endregion
    }
}