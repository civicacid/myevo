
HWstatus = {}

HWstatus.debug = 0

-- 初始化拍卖货物的数据
giGoodsItemCount = 0
garrayGoodsItemName = {}
garrayGoodsItemMinPrice = {}
garrayGoodsItemCount = {}
garrayGoodsItemMaxPrice = {}
garrayGoodsItemStackSize = {}

-- 当前角色缺货数据table
LessItems = {}
LessItems.ItemCount = {}
LessItems.ItemName = {}

-- 所有角色缺货数据table
AllLessItems = {}
AllLessItems.CharName = {}
AllLessItems.ItemCount = {}
AllLessItems.ItemName = {}

local myDB = LibStub("AceAddon-3.0"):NewAddon("myDB")
AceTime = LibStub("AceAddon-3.0"):NewAddon("TimerTest", "AceTimer-3.0")

function myDB:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("HelloWorldDB")
end
function myDB:OnEnable()
    local liLoop

    NormalPrint("载入数据。。。。。。 ")
    gstrGoods = self.db.profile.AHItemData

    -- 获取物品清单
    LoadAHItemData()

    -- 获取所有角色“缺货”物品清单
    LoadLessItem()
end

function SaveAHItemData()
    myDB.db.profile.AHItemData = gstrGoods
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     初始化类程序     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function hello_world_initialize()
    -- add our very first chat command!
    SlashCmdList["HELLOW"] = hello_world_command
    SLASH_HELLOW1 = "/hellow"
    SLASH_HELLOW2 = "/hw"

    GlobalValue=1

    HWstatus.AHBox = 0
    HWstatus.MailBox = 0

    MAX_BIN_VALUE_LENGTH=17

    BlockSize=5                                 -- 显示的数据块大小（像素）
    BlockGap=0

    NextMail = 1

    iMarkTime = nil
    iDelaySecond = 0

    local i


    -- 循环执行AH的变量
    giLoopAHCount = 0
    giLoopAHFlag = 0
    giLoopAHHandle = 0
    giLoopAHStatus = 0

    -- 初始化时间窗体
    frmTime = CreateFrame("frame","TimeFrame", UIParent)
    frmTime:SetScript("OnUpdate", getNowTime)
    testbutton = CreateFrame("Button", frmTime, UIParent, "SecureActionButtonTemplate")
    testbutton:SetAttribute("macrotext", "/cast 选矿")

    -- 初始化血量框
    iCeng=1
    Blood = {}
    BloodBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        Blood[i] = CreateFrame("Frame", "Blood", UIParent)
        BloodBk[i] = Blood[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        BloodBk[i]:SetTexture(0, 0, 0, 1)
        BloodBk[i]:SetAllPoints()
        Blood[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        Blood[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        Blood[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        Blood[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    Blood[1]:SetScript("OnUpdate", getHealth)

    -- 初始化能量框
    iCeng=2
    Power = {}
    PowerBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        Power[i] = CreateFrame("Frame", "Blood", UIParent)
        PowerBk[i] = Power[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        PowerBk[i]:SetTexture(0, 0, 0, 1)
        PowerBk[i]:SetAllPoints()
        Power[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        Power[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        Power[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        Power[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    Power[1]:SetScript("OnUpdate", getPower)

    -- 初始化坐标框
    iCeng=3
    XY_X = {}
    XYBk_X = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        XY_X[i] = CreateFrame("Frame", "XY_X", UIParent)
        XYBk_X[i] = XY_X[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        XYBk_X[i]:SetTexture(0, 0, 0, 1)
        XYBk_X[i]:SetAllPoints()
        XY_X[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        XY_X[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        XY_X[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        XY_X[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end

    iCeng=4
    XY_Y = {}
    XYBk_Y = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        XY_Y[i] = CreateFrame("Frame", "XY_Y", UIParent)
        XYBk_Y[i] = XY_Y[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        XYBk_Y[i]:SetTexture(0, 0, 0, 1)
        XYBk_Y[i]:SetAllPoints()
        XY_Y[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        XY_Y[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        XY_Y[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        XY_Y[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    XY_X[1]:SetScript("OnUpdate", getXY)

    -- 初始化朝向框
    iCeng=5
    FACE = {}
    FACEBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        FACE[i] = CreateFrame("Frame", "FACE", UIParent)
        FACEBk[i] = FACE[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        FACEBk[i]:SetTexture(0, 0, 0, 1)
        FACEBk[i]:SetAllPoints()
        FACE[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        FACE[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        FACE[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        FACE[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    FACE[1]:SetScript("OnUpdate", getFace)

    -- 初始化包空间框
    iCeng=6
    FreeSlot = {}
    FreeSlotBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        FreeSlot[i] = CreateFrame("Frame", "FreeSlot", UIParent)
        FreeSlotBk[i] = FreeSlot[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        FreeSlotBk[i]:SetTexture(0, 0, 0, 1)
        FreeSlotBk[i]:SetAllPoints()
        FreeSlot[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        FreeSlot[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        FreeSlot[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        FreeSlot[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    FreeSlot[1]:SetScript("OnUpdate", getFreeSlot)

    -- 初始化死亡状态框
    iCeng=7
    DeadSlot = {}
    DeadSlotBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        DeadSlot[i] = CreateFrame("Frame", "DeadSlot", UIParent)
        DeadSlotBk[i] = DeadSlot[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        DeadSlotBk[i]:SetTexture(0, 0, 0, 1)
        DeadSlotBk[i]:SetAllPoints()
        DeadSlot[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        DeadSlot[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        DeadSlot[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        DeadSlot[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    DeadSlot[1]:SetScript("OnUpdate", getDeadStatus)

    -- 初始化地区框
    iCeng=8
    ZoneSlot = {}
    ZoneSlotBk = {}
    for i=1,MAX_BIN_VALUE_LENGTH do
        ZoneSlot[i] = CreateFrame("Frame", "ZoneSlot", UIParent)
        ZoneSlotBk[i] = ZoneSlot[i]:CreateTexture("TestFrameBackground", "BACKGROUND")
        ZoneSlotBk[i]:SetTexture(0, 0, 0, 1)
        ZoneSlotBk[i]:SetAllPoints()
        ZoneSlot[i]:SetPoint("TOP", WorldFrame, "BOTTOMLEFT", 0, iCeng*BlockSize+(iCeng-1)*BlockGap)
        ZoneSlot[i]:SetPoint("BOTTOM", WorldFrame, "BOTTOMLEFT", 0, (iCeng-1)*BlockSize+(iCeng-1)*BlockGap)
        ZoneSlot[i]:SetPoint("LEFT", WorldFrame, "BOTTOMLEFT", (BlockSize+BlockGap)*(i-1), 0)
        ZoneSlot[i]:SetPoint("RIGHT", WorldFrame, "BOTTOMLEFT", BlockSize*i+BlockGap*(i-1), 0)
    end
    ZoneSlot[1]:SetScript("OnUpdate", getZoneCode)

    -- 初始化拍卖相关状态框
    AHStatSlot = {}
    AHStatSlotBk = {}
    AHStatSlot[1] = CreateFrame("Frame", "AHStatSlot", UIParent)
    AHStatSlotBk[1] = AHStatSlot[1]:CreateTexture("TestFrameBackground", "BACKGROUND")
    AHStatSlotBk[1]:SetTexture(0, 0, 0, 1)
    AHStatSlotBk[1]:SetAllPoints()
    AHStatSlot[1]:SetPoint("TOP", WorldFrame, "TOPLEFT", 0, 0)
    AHStatSlot[1]:SetPoint("BOTTOM", WorldFrame, "TOPLEFT", 0, -50)
    AHStatSlot[1]:SetPoint("LEFT", WorldFrame, "TOPLEFT", 0, 0)
    AHStatSlot[1]:SetPoint("RIGHT", WorldFrame, "TOPLEFT", 50, 0)
    AHStatSlot[1]:SetScript("OnUpdate", getCode)

    -- 测试真
    frmTest = CreateFrame("Frame", "frmTest", UIParent)
    frmTest:SetWidth(64) -- 设置宽度
    frmTest:SetHeight(64) -- 设置高度
    frmTest:SetBackdrop({
       bgFile = "Interface\\AddOns\\Sora's Threat\\Media\\Solid", -- 背景材质路径
       insets = {left = 1,right = 1,top = 1,bottom = 1}, -- 背景收缩程度，单位为像素，例如，top = 1即背景材质的上边缘向内收缩1个像素
       edgeFile = "Interface\\AddOns\\Sora's Threat\\Media\\Solid", -- 边框材质路径
       edgeSize = 1, -- 边框宽度
    })
    frmTest:SetBackdropColor(0, 0, 0, 0.6) -- 背景材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
    frmTest:SetBackdropBorderColor(0, 0, 0, 1)  -- 边框材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
    frmTest:SetPoint("TOP", WorldFrame, "TOPLEFT", 0, -50)
    frmTest:SetPoint("BOTTOM", WorldFrame, "TOPLEFT", 0, -100)
    frmTest:SetPoint("LEFT", WorldFrame, "TOPLEFT", 0, 0)
    frmTest:SetPoint("RIGHT", WorldFrame, "TOPLEFT", 50, 0)
    frmTest.Text = frmTest:CreateFontString("frmTestText", "OVERLAY") -- 为Frame创建一个新的文字层
    frmTest.Text:SetFont("Fonts\\ZYKai_T.ttf", 12, "THINOUTLINE") -- 设置字体路径, 大小, 描边
    frmTest.Text:SetText("测试文字") -- 设置材质路径
    frmTest.Text:SetPoint("TOP", frmTest, "BOTTOM", 0, 5)
    frmTest:Hide()
end


--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     框体数值显示     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- 显示血量
function getHealth()
    local health,healthbin
    local healtharray = {}
    health = UnitHealth("player")
    healthbin = ten_to_bin(health)

    local i
    for i=1,strlen(healthbin) do
        healtharray[i]=strsub(healthbin,i,i)
    end

    for i=1,MAX_BIN_VALUE_LENGTH do
        BloodBk[i]:ClearAllPoints()
        if healtharray[i]=="1" then
            BloodBk[i]:SetTexture(1, 1, 1, 1)
        else
            BloodBk[i]:SetTexture(0, 0, 0, 1)
        end
        BloodBk[i]:SetAllPoints()
    end

end

-- 显示能量或者魔法或者怒气等
function getPower()
    local health,healthbin
    local healtharray = {}
    health = UnitPower("player")
    healthbin = ten_to_bin(health)

    local i
    for i=1,strlen(healthbin) do
        healtharray[i]=strsub(healthbin,i,i)
    end

    for i=1,MAX_BIN_VALUE_LENGTH do
        PowerBk[i]:ClearAllPoints()
        if healtharray[i]=="1" then
            PowerBk[i]:SetTexture(1, 1, 1, 1)
        else
            PowerBk[i]:SetTexture(0, 0, 0, 1)
        end
        PowerBk[i]:SetAllPoints()
    end

end

-- 获得商业技能
function hello_world_getskill(strSkillName)
    local n = GetNumSkillLines()
    for i=1,n do
        local name, _, _, rank, _, modifier, skillmax = GetSkillLineInfo(i)
        NormalPrint (name.."["..rank.."]")
    end
    local iPosX,iPoxY=GetPlayerMapPosition("player")
    local facing = GetPlayerFacing()
    if (iPosX) then
        NormalPrint(iPosX)
    end
end

-- 获得坐标
function getXY()
    local x, y = GetPlayerMapPosition("player")
    local xbin,ybin
    local i
    local binarray = {}
    local facing = GetPlayerFacing()
    if (x) then
        xbin=ten_to_bin(floor(x*1000))
        for i=1,strlen(xbin) do
            binarray[i]=strsub(xbin,i,i)
        end

        for i=1,MAX_BIN_VALUE_LENGTH do
            XYBk_X[i]:ClearAllPoints()
            if binarray[i]=="1" then
                XYBk_X[i]:SetTexture(1, 1, 1, 1)
            else
                XYBk_X[i]:SetTexture(0, 0, 0, 1)
            end
            XYBk_X[i]:SetAllPoints()
        end

        ybin=ten_to_bin(floor(y*1000))
        for i=1,strlen(ybin) do
            binarray[i]=strsub(ybin,i,i)
        end

        for i=1,MAX_BIN_VALUE_LENGTH do
            XYBk_Y[i]:ClearAllPoints()
            if binarray[i]=="1" then
                XYBk_Y[i]:SetTexture(1, 1, 1, 1)
            else
                XYBk_Y[i]:SetTexture(0, 0, 0, 1)
            end
            XYBk_Y[i]:SetAllPoints()
        end

    end
end

-- 获得朝向
function getFace()
    local strbin,i
    local binarray = {}
    local facing = GetPlayerFacing()
    if (facing) then
        strbin=ten_to_bin(floor(facing*1000))
        for i=1,strlen(strbin) do
            binarray[i]=strsub(strbin,i,i)
        end

        for i=1,MAX_BIN_VALUE_LENGTH do
            FACEBk[i]:ClearAllPoints()
            if binarray[i]=="1" then
                FACEBk[i]:SetTexture(1, 1, 1, 1)
            else
                FACEBk[i]:SetTexture(0, 0, 0, 1)
            end
            FACEBk[i]:SetAllPoints()
        end

    end
end

-- 获得包空间，剩余空格数量
function getFreeSlot()
    slotCount = 0
    for b = 0, 4 do
        if GetBagName(b) then
            slotCount = slotCount + GetContainerNumFreeSlots(b)
        end
    end
    local strbin,i
    local binarray = {}
    if (slotCount) then
        strbin=ten_to_bin(slotCount)
        for i=1,strlen(strbin) do
            binarray[i]=strsub(strbin,i,i)
        end

        for i=1,MAX_BIN_VALUE_LENGTH do
            FreeSlotBk[i]:ClearAllPoints()
            if binarray[i]=="1" then
                FreeSlotBk[i]:SetTexture(1, 1, 1, 1)
            else
                FreeSlotBk[i]:SetTexture(0, 0, 0, 1)
            end
            FreeSlotBk[i]:SetAllPoints()
        end

    end
end

-- 显示是否死亡
function getDeadStatus()
    local iValue,strValue
    local arrayValue = {}
    iValue = UnitIsDeadOrGhost("player")

    for i=1,MAX_BIN_VALUE_LENGTH do
        DeadSlotBk[i]:ClearAllPoints()
        if iValue==1 then
            DeadSlotBk[i]:SetTexture(1, 1, 1, 1)
        else
            DeadSlotBk[i]:SetTexture(0, 0, 0, 1)
        end
        DeadSlotBk[i]:SetAllPoints()
    end

end

-- 获得ZoneCode
function getZoneCode()
    local strValue,iValue,iLoop
    local arrayValue = {}
    iValue = GetCurrentMapZone()
    if (iValue) then
        strValue=ten_to_bin(iValue)
        for iLoop=1,strlen(strValue) do
            arrayValue[iLoop]=strsub(strValue,iLoop,iLoop)
        end

        for iLoop=1,MAX_BIN_VALUE_LENGTH do
            ZoneSlotBk[iLoop]:ClearAllPoints()
            if arrayValue[iLoop]=="1" then
                ZoneSlotBk[iLoop]:SetTexture(1, 1, 1, 1)
            else
                ZoneSlotBk[iLoop]:SetTexture(0, 0, 0, 1)
            end
            ZoneSlotBk[iLoop]:SetAllPoints()
        end

    end
end

-- 获得AHStat，变的通用了，按照检查标记来显示。
CheckFlag = 0     -- 要来标记要检查哪些项目，不同的项目，色块(AHStatSlotBk)会相应这些项目。

function ClearCheckFlag()
    CheckFlag = 0
end

function getCode()
    local strValue,iValue,iLoop
    local arrayValue = {}
    
    AHStatSlotBk[1]:ClearAllPoints()
    AHStatSlotBk[1]:SetTexture(0, 0, 0, 1)

    if CheckFlag == 0 then

        if AHCancelCheck() == 10 then
            AHStatSlotBk[1]:SetTexture(0.5, 0.5, 0.5, 1)
        end

        -- Cancel=FFFFFF
        if AHCancelCheck() == 2 then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
        end

        -- Dead=FF0000
        if (UnitIsDeadOrGhost("player")) then
            AHStatSlotBk[1]:SetTexture(1, 0, 0, 1)
        end
    end

    -- 显示法师冰盾是否存在
    if CheckFlag == 110 then
        for iLoop = 1, 20 do
            strValue = UnitBuff("player", iLoop)
            if (strValue) then
                strValue = (select(1, strValue))
                --print(strValue)
                if (string.find(strValue, "寒冰护体")) then
                    AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
                    return
                end
            end
        end
    end

    -- 检查法师是否正在施法
    if CheckFlag == 120 then
        strValue = UnitChannelInfo("player")
        if (strValue) then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    -- 检查玩家是否在战斗状态
    if CheckFlag == 130 then
        strValue = UnitAffectingCombat("player")
        if (strValue) then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    -- 检查玩家是否满血满蓝
    if CheckFlag == 140 then
        if (UnitHealth("player") - UnitHealthMax("player")) == 0 and (UnitPower("player") - UnitPowerMax("player")) == 0 then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    -- 检查玩家是否有面包( [魔法酪饼])
    if CheckFlag == 150 then
        if getXXcount("魔法酪饼") - 0 > 0 then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    -- 检查玩家是否有智慧
    if CheckFlag == 160 then
        for iLoop = 1, 20 do
            strValue = UnitBuff("player", iLoop)
            if (strValue) then
                strValue = (select(1, strValue))
                --print(strValue)
                if (string.find(strValue, "奥术智慧")) then
                    AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
                    return
                end
            end
        end
    end

    -- 检查玩家是否有冰甲术
    if CheckFlag == 170 then
        for iLoop = 1, 20 do
            strValue = UnitBuff("player", iLoop)
            if (strValue) then
                strValue = (select(1, strValue))
                --print(strValue)
                if (string.find(strValue, "冰甲术")) then
                    AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
                    return
                end
            end
        end
    end

    -- 检查玩家是否在飞行状态
    if CheckFlag == 180 then
        strValue = IsFlying()
        if (strValue) and strValue == 1 then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    --{******************* AH 检查项目 *******************************}
    --是否需要取消
    if CheckFlag == 200 then
        if AHCancelCheck() == 2 then
            AHStatSlotBk[1]:SetTexture(1, 1, 1, 1)
            return
        end
    end

    --是否需要点击拍卖
    if CheckFlag == 210 then
        AHStatSlotBk[1]:SetTexture(0, 1, 0, 1)
        return
    end

    AHStatSlotBk[1]:SetAllPoints()
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     获得背包剩余空间     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function getFreeSlotX()
    local slotCount = 0
    for iBag = 0,4 do
        if GetBagName(iBag) then
            slotCount = slotCount + GetContainerNumFreeSlots(iBag)
        end
    end
    return slotCount
end

function hello_world_command(strFunc)
    --NormalPrint(strFunc)
    --NormalPrint(time())
    --searching=1
    --QueryAuctionItems("腿甲片", 0, 0, 0, 0, 0, 0, 0, 0, 0)

    local bag,slot,item,found1,found2,found3,found4,name,FirstFound
    local numSkills, SlotCount, InboxCount
    local iLoop,iLoopNext
    local skillName, skillType, numAvailable, isExpanded, serviceType, numSkillUps = GetTradeSkillInfo(10)
    local arg1,arg2,arg3

    arg1,arg2,arg3 = strsplit(",",strFunc)

    testbutton:SetAttribute("*type2", "macro")
    testbutton:SetAttribute("*type*", "click")
    testbutton:SetAttribute("*clickbutton1", itemFrame)
    testbutton:SetAttribute("clickbutton2", ATTRIBUTE_NOOP)
    testbutton:RegisterForClicks("AnyUp")
    testbutton:RegisterForDrag("LeftButton")
    testbutton:SetFrameStrata("DIALOG")
    testbutton:SetScript("OnShow", function(self)
        self:SetAttribute("*macrotext2", "/cast 分解 \n/use 猛攻指环")
    end)
    testbutton:SetAttribute("*macrotext2", "/cast 分解 \n/use 猛攻指环")
    testbutton:Show()

    --if (arg1) then
    --    NormalPrint("arg1 ["..arg1.."]")
    --end
    --if (arg2) then
    --    NormalPrint("arg2 ["..arg2.."]")
    --end
    --if (arg3) then
    --    NormalPrint("arg3 ["..arg3.."]")
    --end

    if (arg1=="sell") then
        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                item = GetContainerItemLink(bag,slot)
                if (item) then
                    if    (select(1,GetItemInfo(item))) == "烈日石戒"
                       or (select(1,GetItemInfo(item))) == "血石指环"
                       or (select(1,GetItemInfo(item))) == "水晶茶晶石项链"
                       or (select(1,GetItemInfo(item))) == "强攻暗影水晶"
                       or (select(1,GetItemInfo(item))) == "完美强攻暗影水晶"
                       or (select(1,GetItemInfo(item))) == "美味的蚌肉"
                       then
                        PickupContainerItem(bag, slot)
                        PickupMerchantItem()
                    end
                end
            end
        end
    end

    if (arg1=="gem") then
        local arrayToDoList = {}
        local arrayToDoTarget = {}
        local iLoopToDO

        arrayToDoList[1] = "血石"
        arrayToDoTarget[1] = "血石指环"
        arrayToDoList[2] = "茶晶石"
        arrayToDoTarget[2] = "水晶茶晶石项链"
        arrayToDoList[3] = "太阳水晶"
        arrayToDoTarget[3] = "烈日石戒"
        arrayToDoList[4] = "暗影水晶"
        arrayToDoTarget[4] = "强攻暗影水晶"

        for iLoopToDO = 1, table.getn(arrayToDoList) do
            for bag = 0,4 do
                for slot = 1,GetContainerNumSlots(bag) do
                    item = GetContainerItemLink(bag,slot)
                    if (item) then
                        if (select(1,GetItemInfo(item))) == arrayToDoList[iLoopToDO] then
                            -- 找到，可以做
                            numSkills = GetNumTradeSkills()
                            for iLoop = 1, numSkills do
                                skillName = ((select(1,GetTradeSkillInfo(iLoop))))
                                if skillName == arrayToDoTarget[iLoopToDO] then
                                    DoTradeSkill(iLoop)
                                    return 0
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if (arg1=="ench") then
        -- 物品名称
        if (arg2==nil) then
            NormalPrint("物品名称 空")
            return -1
        end
        print(arg2)
        numSkills = GetNumTradeSkills()
        for iLoop = 1, numSkills do
            skillName = ((select(1,GetTradeSkillInfo(iLoop))))
            --print(skillName)
            found1 = string.find(skillName, arg2, 1)
            if (found1) then
                print("Do")
                DoTradeSkill(iLoop)
                return 0
            end
        end
    end

    if (arg1=="mailsend") then
        -- 物品名称
        if (arg2==nil) then
            NormalPrint("物品名称 空")
            return -1
        end
        -- 收件人
        if (arg3==nil) then
            NormalPrint("收件人 空")
            return -1
        end

        if not (SendMailFrame:IsVisible() and not CursorHasItem()) then
            NormalPrint("打开邮箱界面")
            return -1
        end

        --FirstFound = 1
        SlotCount = 0

        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                item = GetContainerItemLink(bag,slot)
                if (item) then
                    -- 找物品
                    if (select(1,GetItemInfo(item))) == arg2 then
                        -- 添加到邮件附件中区
                        PickupContainerItem(bag, slot)
                        ClickSendMailItemButton()
                        SlotCount = SlotCount +1

                        -- 检查邮件附件区域是否已经被填充满(函数返回物品名称均为非空)，满了就发送，同时重置“第一次发现标志位”
                        if SlotCount == 12 then
                            --NormalPrint(EmptySlotCount)
                        --    FirstFound = 1
                            SlotCount = 0
                            --SendMailFrame_SendMail()
                            ClearCursor()
                            SendMail(arg3, "AutoSend", "")
                            return
                        end
                    end
                end
            end
        end
    end

    if (arg1=="mailget") then
        -- 物品名称
        if (arg2==nil) then
            NormalPrint("物品名称 空")
            return -1
        end

        InboxCount,_ = GetInboxNumItems()
        for iLoop=1,InboxCount do
            for iLoopNext=1,12 do
                name, _, _, _, _ = GetInboxItem(iLoop, iLoopNext)
                if (name) then
                    found1 = string.find(name,arg2)
                    if (found1) then
                        NormalPrint(iLoop.."  "..iLoopNext)
                        TakeInboxItem(iLoop,iLoopNext)
                        return 0
                    end
                end
            end
        end
    end
end


--*************************** New AH 自动 ***************************--
HWstatus.AHAutoRun = 0                  -- 0 闲置，10 开始搜索，20 检查搜索状态，发出取消命令，30 检查取消，发出拆货，
                                        -- 40 检查拆伙，发出挂货，50 检查挂货，进入等待，60 确认等待 继续下一个循环
local AHAutoRun = {}
local AHAutoRunMachine = LibStub("AceAddon-3.0"):NewAddon("AHAutoRunMachine", "AceTimer-3.0")

AHAutoRun.WAIT_TIME = 0.05
AHAutoRun.LOOP_TIME = 0.1

AHAutoRun.Handle = ""

-- 待处理清单
AHAutoRun.ItemName = {}
AHAutoRun.ItemMinPrice = {}
AHAutoRun.ItemCount = {}
AHAutoRun.ItemMaxPrice = {}
AHAutoRun.ItemStackSize = {}

-- 循环计数器
AHAutoRun.LoopCount = 0
-- AH搜索找到拍卖物品了么？ 1 找到， 0 没有
AHAutoRun.FlagSearchFound = 1
-- 挂货价格
AHAutoRun.NowPrice = 0
-- 使用哪个版本
AHAutoRun.Version = ""

function AHAutoRunDoor(astrVersion)
    local liLoop, liLessLoop, liItemCount, liFlagFound

    if not astrVersion or AHAutoRun.Version == "" then                     -- 默认国服版本，为了提供兼容
        AHAutoRun.Version = "GF"
    end

    if giGoodsItemCount == 0 then
        NormalPrint("没有物品可供处理。")
        return
    end

    AHAutoRun.ItemName = wipe(AHAutoRun.ItemName)
    AHAutoRun.ItemMinPrice = wipe(AHAutoRun.ItemMinPrice)
    AHAutoRun.ItemCount = wipe(AHAutoRun.ItemCount)
    AHAutoRun.ItemMaxPrice = wipe(AHAutoRun.ItemMaxPrice)
    AHAutoRun.ItemStackSize = wipe(AHAutoRun.ItemStackSize)
    liItemCount = 0

    -- 挑出那些有货的进行挂
    if CheckItemCount() == 0 then
        for liLoop = 1, giGoodsItemCount do
            AHAutoRun.ItemName[liLoop] = garrayGoodsItemName[liLoop]
            AHAutoRun.ItemMinPrice[liLoop] = garrayGoodsItemMinPrice[liLoop]
            AHAutoRun.ItemCount[liLoop] = garrayGoodsItemCount[liLoop]
            AHAutoRun.ItemMaxPrice[liLoop] = garrayGoodsItemMaxPrice[liLoop]
            AHAutoRun.ItemStackSize[liLoop] = garrayGoodsItemStackSize[liLoop]
        end
    else
        -- 缺货的就跳过，不允许他们凑热闹
        for liLoop = 1, giGoodsItemCount do
            liFlagFound = 0
            for liLessLoop = 1, #LessItems.ItemName do
                if LessItems.ItemName[liLessLoop] == garrayGoodsItemName[liLoop] then  -- and LessItems.ItemCount[liLessLoop] == garrayGoodsItemCount[liLoop] * garrayGoodsItemStackSize[liLoop]
                    liFlagFound = 1
                end
            end
            if liFlagFound == 0 then
                liItemCount = liItemCount + 1
                AHAutoRun.ItemName[liItemCount] = garrayGoodsItemName[liLoop]
                AHAutoRun.ItemMinPrice[liItemCount] = garrayGoodsItemMinPrice[liLoop]
                AHAutoRun.ItemCount[liItemCount] = garrayGoodsItemCount[liLoop]
                AHAutoRun.ItemMaxPrice[liItemCount] = garrayGoodsItemMaxPrice[liLoop]
                AHAutoRun.ItemStackSize[liItemCount] = garrayGoodsItemStackSize[liLoop]
            end
        end
    end

    -- 设置参数，准备开始
    AHAutoRun.LoopCount = #AHAutoRun.ItemName
    AHAutoRun.FlagSearchFound = 1

    -- 开始状态机
    AHAutoRun.Handle = AHAutoRunMachine:ScheduleRepeatingTimer("Run", AHAutoRun.LOOP_TIME)

    -- 修改状态参数
    HWstatus.AHAutoRun = 10
end

function AHAutoRunCheck()
    return HWstatus.AHAutoRun
end

function AHAutoRunMachine:Run()
    local liAHMinPrice, lstrAHMinPriceSeller

    if HWstatus.AHAutoRun == 10 then
        AHSearchDoor(AHAutoRun.ItemName[AHAutoRun.LoopCount], 0)
        HWstatus.AHAutoRun = 20
        NormalPrint("正在处理第【"..tostring(#AHAutoRun.ItemName - AHAutoRun.LoopCount + 1).."】件拍卖物品["..AHAutoRun.ItemName[AHAutoRun.LoopCount].."]，共【"..tostring(#AHAutoRun.ItemName).."】件。")
        return
    end

    if HWstatus.AHAutoRun == 20 then
        if AHSearchCheck() == -1 then
            AHAutoRunMachine:Fail()
            return
        end

        if AHSearchCheck() == 0 then

            -- 置搜索结果状态(默认是找到)
            AHAutoRun.FlagSearchFound = 1

            -- 检查搜索结果
            liAHMinPrice, lstrAHMinPriceSeller = AHSearchMinOut()
            debugprint("查询结果："..liAHMinPrice.." "..lstrAHMinPriceSeller)
            AHAutoRun.NowPrice = liAHMinPrice

            -- 搜索没有结果
            if tonumber(liAHMinPrice) == 0 then
                AHAutoRun.FlagSearchFound = 0
                AHAutoRun.NowPrice = AHAutoRun.ItemMaxPrice[AHAutoRun.LoopCount] * 10000             --这里要乘以10000，因为单位是G，而挂货单位是铜板
                -- 直接跳到出售物品（status = 40）
                HWstatus.AHAutoRun = 40
                return
            end

            -- 搜索的结果是自己 或者 最低价格太低
            if lstrAHMinPriceSeller == GetUnitName("player",false) then
                NormalPrint("价格最低的就是我自己，不用做什么，直接下一个")
                -- 那就直接下一个，什么都不用做了
                HWstatus.AHAutoRun = 60
                AHAutoRunMachine:ScheduleTimer("Waiting", AHAutoRun.WAIT_TIME)
                return
            end

            -- 当前AH最低价格过低，小于指定最低价格
            if (tonumber(liAHMinPrice) - tonumber(AHAutoRun.ItemMinPrice[AHAutoRun.LoopCount]) * 10000 < 0) then
                NormalPrint("["..lstrAHMinPriceSeller.."]价格太低["..liAHMinPrice.."]，暂时不出货")
                -- 那就直接下一个，什么都不用做了
                HWstatus.AHAutoRun = 60
                AHAutoRunMachine:ScheduleTimer("Waiting", AHAutoRun.WAIT_TIME)
                return
            end

            -- 现在取消通过前台按键来做，通过排定颜色，来让AutoIT按取消的宏
        NormalPrint("["..lstrAHMinPriceSeller.."]价格最低["..liAHMinPrice.."]，暂时不出货")
            AHCancelDoor(AHAutoRun.ItemName[AHAutoRun.LoopCount])
            HWstatus.AHAutoRun = 30
            return
        end
    end

    if HWstatus.AHAutoRun == 30 then
        if AHCancelCheck() == -1 then
            AHAutoRunMachine:Fail()
            return
        end
        if AHCancelCheck() == 0 then
            -- 取消结束，开始拍卖
            --AHPostItem4Door(AHAutoRun.ItemName[AHAutoRun.LoopCount], AHAutoRun.NowPrice, AHAutoRun.ItemStackSize[AHAutoRun.LoopCount], AHAutoRun.ItemCount[AHAutoRun.LoopCount])
            HWstatus.AHAutoRun = 40
            return
        end
    end

    -- 单独设置开始拍卖状态，为了上面查询时候调用
    if HWstatus.AHAutoRun == 40 then
        AHPostItem4Door(AHAutoRun.ItemName[AHAutoRun.LoopCount], AHAutoRun.NowPrice, AHAutoRun.ItemStackSize[AHAutoRun.LoopCount], AHAutoRun.ItemCount[AHAutoRun.LoopCount])
        HWstatus.AHAutoRun = 45
    end

    if HWstatus.AHAutoRun == 45 then
        if IsAHOpen() ~= 1 then
            debugprint("AHPostItem4Door： AH Close")
            AHAutoRunMachine:Fail()
            return
        end
        if AHPostItem4Check() == -1 then
            debugprint("AHPostItem4Door： Fail")
            AHAutoRunMachine:Fail()
            return
        end
        if AHPostItem4Check() == 0 then
            -- 挂货完毕，等待一段时间，开始下一波
            AHAutoRunMachine:ScheduleTimer("Waiting", AHAutoRun.WAIT_TIME)
            HWstatus.AHAutoRun = 60
            return
        end
    end

end

function AHAutoRunMachine:Waiting()
    if HWstatus.AHAutoRun == 60 then
        AHAutoRun.LoopCount = AHAutoRun.LoopCount - 1
        if AHAutoRun.LoopCount == 0 then
            AHAutoRunMachine:Stop()
            return
        end
        HWstatus.AHAutoRun = 10
    end
end

function AHAutoRunMachine:Stop()
    if AHAutoRun.Handle then
        AHAutoRunMachine:CancelTimer(AHAutoRun.Handle, true)
    end

    HWstatus.AHAutoRun = 0
    CheckFlag = 0

    NormalPrint("AHAutoRun is Done. 挂货完毕")
end

function AHAutoRunMachine:Fail()
    if AHAutoRun.Handle then
        AHAutoRunMachine:CancelTimer(AHAutoRun.Handle, true)
    end

    HWstatus.AHAutoRun = -1
    CheckFlag = 0
    debugprint("AHAutoRunMachine:Fail()")
end
--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------       其他功能       ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

--************                    检查当前角色是否有缺少货情况                  ******************-----
function CheckItemCount()
    local liLoop, liFlagFound, liLessItemCount

    liFlagFound = 0
    liLessItemCount = 0

    if LessItems.ItemName then
        LessItems.ItemName = wipe(LessItems.ItemName)
    end
    if LessItems.ItemCount then
        LessItems.ItemCount = wipe(LessItems.ItemCount)
    end

    for liLoop = 1, giGoodsItemCount do
        if CalcItemCount(garrayGoodsItemName[liLoop]) == 0 then
            liFlagFound = 1
            liLessItemCount = liLessItemCount + 1
            LessItems.ItemName[liLessItemCount] = garrayGoodsItemName[liLoop]
            LessItems.ItemCount[liLessItemCount] = garrayGoodsItemCount[liLoop] * garrayGoodsItemStackSize[liLoop]
            if liLessItemCount == 1 then
                NormalPrint("####################################################")
            end
            NormalPrint("缺货物品： 【"..garrayGoodsItemName[liLoop].."】，设置中需要【"..LessItems.ItemCount[liLessItemCount].."】件")
        end
        if (CalcItemCount(garrayGoodsItemName[liLoop]) > 0) and (CalcItemCount(garrayGoodsItemName[liLoop]) - (tonumber(garrayGoodsItemCount[liLoop]) * tonumber(garrayGoodsItemStackSize[liLoop])) < 0) then
            liFlagFound = 1
            liLessItemCount = liLessItemCount + 1
            LessItems.ItemName[liLessItemCount] = garrayGoodsItemName[liLoop]
            LessItems.ItemCount[liLessItemCount] = garrayGoodsItemCount[liLoop] * garrayGoodsItemStackSize[liLoop] - CalcItemCount(garrayGoodsItemName[liLoop])
            if liLessItemCount == 1 then
                NormalPrint("####################################################")
            end
            NormalPrint("少货物品： "..garrayGoodsItemName[liLoop].."，设置中需要【"..tostring(garrayGoodsItemCount[liLoop] * garrayGoodsItemStackSize[liLoop]).."】件，实际只有【"..CalcItemCount(garrayGoodsItemName[liLoop]).."】件")
        end
    end

    SaveLessItem()

    if liFlagFound == 0 then
        debugprint("无缺货和少货物品")
        return 0
    else
        return 1
    end
end

-- 显示缺货物品
function DispAllLessItem()
    local liLoop

    NormalPrint("*****************************************************")
    for liLoop = 1, #AllLessItems.CharName do
        NormalPrint("角色[" .. AllLessItems.CharName[liLoop] .. "]: " .. AllLessItems.ItemName[liLoop] .. " | " .. AllLessItems.ItemCount[liLoop])
    end
end

----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    配置项管理功能      ----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------


--*********** 将保存的字符串翻译为table，供自动AH使用。（由OnEnable时调用） *************--
function LoadAHItemData()
    local larrayTemp
    larrayTemp = {}

    local liCount,lstrData,liLoop,liTotalLoop
    local lstrValue

    liCount = 0
    liTotalLoop = 0
    lstrData = gstrGoods

    if lstrData == nil then
        return
    end

    -- count all value, it should be four times as
    while string.find(lstrData,",") do
        lstrValue = string.sub(lstrData,1,string.find(lstrData,",")-1)
        lstrData = string.sub(lstrData,string.find(lstrData,",")+1)
        liCount = liCount+1

        if liCount == 1 then
            liTotalLoop = liTotalLoop + 1
            garrayGoodsItemName[liTotalLoop] = lstrValue
        end
        if liCount == 2 then
            garrayGoodsItemMinPrice[liTotalLoop] = tonumber(lstrValue)
        end
        if liCount == 3 then
            garrayGoodsItemCount[liTotalLoop] = tonumber(lstrValue)
        end
        if liCount == 4 then
            garrayGoodsItemMaxPrice[liTotalLoop] = tonumber(lstrValue)
        end
        if liCount == 5 then
            garrayGoodsItemStackSize[liTotalLoop] = tonumber(lstrValue)
            liCount = 0
        end
    end
    -- 处理最后一个元素，这个后面没有分隔符
    garrayGoodsItemStackSize[liTotalLoop] = tonumber(lstrData)
    giGoodsItemCount = liTotalLoop
end

--*************          检查当前配置情况          ***********--
function ListData()
    local liLoop

    for liLoop = 1, giGoodsItemCount do
        NormalPrint("["..garrayGoodsItemName[liLoop].."] 最低：["..garrayGoodsItemMinPrice[liLoop].."] 出货量：["..garrayGoodsItemCount[liLoop].."] 最高：["..garrayGoodsItemMaxPrice[liLoop].."] 尺寸：["..garrayGoodsItemStackSize[liLoop].."]")
    end
    NormalPrint("共【"..giGoodsItemCount.."】件物品")
end


--*************           增加物品配置项           ***********--
function InputData(arg1,arg2,arg3,arg4,arg5)
    -- valid data
    if arg1==nil then
        NormalPrint("物品名称没有")
        return
    end
    if arg2==nil then
        NormalPrint("弄点数字进来，作为最低价格")
        return
    end
    if arg3==nil then
        NormalPrint("出几堆货啊？")
        return
    end
    if arg4==nil then
        NormalPrint("最高我们应该出价多少？")
        return
    end
    if arg5==nil then
        NormalPrint("一堆要放几个货？")
        return
    end


    -- check dupliacate
    local liLoop
    for liLoop = 1, giGoodsItemCount do
        if garrayGoodsItemName[liLoop] == arg1 then
            NormalPrint("已经有此种物品，删除后再添加")
            NormalPrint("["..garrayGoodsItemName[liLoop].."] 最低：["..garrayGoodsItemMinPrice[liLoop].."] 出货量：["..garrayGoodsItemCount[liLoop].."] 最高：["..garrayGoodsItemMaxPrice[liLoop].."] 尺寸：["..garrayGoodsItemStackSize[liLoop].."]")
            return
        end
    end

    giGoodsItemCount = giGoodsItemCount + 1
    garrayGoodsItemName[giGoodsItemCount] = arg1
    garrayGoodsItemMinPrice[giGoodsItemCount] = tonumber(arg2)
    garrayGoodsItemCount[giGoodsItemCount] = tonumber(arg3)
    garrayGoodsItemMaxPrice[giGoodsItemCount] = tonumber(arg4)
    garrayGoodsItemStackSize[giGoodsItemCount] = tonumber(arg5)

    -- append data to string(data)
    if gstrGoods == nil then
        gstrGoods = arg1 .. "," .. arg2 .. "," .. arg3 .. "," .. arg4 .. "," .. arg5
    else
        gstrGoods = gstrGoods .. "," .. arg1 .. "," .. arg2 .. "," .. arg3 .. "," .. arg4 .. "," .. arg5
    end

    -- save value
    SaveAHItemData()

    --ListData()
end

--****************              删除配置文件中的一项                 *********************--
function DeleteData(astrItemName)
    -- check exists
    local liLoop, liFlagFound
    liFlagFound = 0
    for liLoop = 1,giGoodsItemCount do
        if garrayGoodsItemName[liLoop] == astrItemName then
            liFlagFound = liLoop
            break
        end
    end
    if liFlagFound == 0 then
        NormalPrint("未找到["..astrItemName.."]的数据信息")
        return
    end

    -- delete data from table
    table.remove(garrayGoodsItemName, liFlagFound)
    table.remove(garrayGoodsItemMinPrice, liFlagFound)
    table.remove(garrayGoodsItemCount, liFlagFound)
    table.remove(garrayGoodsItemMaxPrice, liFlagFound)
    table.remove(garrayGoodsItemStackSize, liFlagFound)

    -- modify global count
    giGoodsItemCount = table.getn(garrayGoodsItemName)

    if giGoodsItemCount ~= 0 then
        -- rebuild save string
        gstrGoods = ""
        for liLoop = 1, (giGoodsItemCount - 1) do
            gstrGoods = gstrGoods .. garrayGoodsItemName[liLoop] .. ","
            gstrGoods = gstrGoods .. garrayGoodsItemMinPrice[liLoop] .. ","
            gstrGoods = gstrGoods .. garrayGoodsItemCount[liLoop] .. ","
            gstrGoods = gstrGoods .. garrayGoodsItemMaxPrice[liLoop] .. ","
            gstrGoods = gstrGoods .. garrayGoodsItemStackSize[liLoop] .. ","
        end
        gstrGoods = gstrGoods .. garrayGoodsItemName[giGoodsItemCount] .. ","
        gstrGoods = gstrGoods .. garrayGoodsItemMinPrice[giGoodsItemCount] .. ","
        gstrGoods = gstrGoods .. garrayGoodsItemCount[giGoodsItemCount] .. ","
        gstrGoods = gstrGoods .. garrayGoodsItemMaxPrice[giGoodsItemCount] .. ","
        gstrGoods = gstrGoods .. garrayGoodsItemStackSize[giGoodsItemCount]
    else
        gstrGoods = ""
    end
    -- save data
    SaveAHItemData()

    -- list data
    --ListData()

end

--****************              读取角色缺货物品清单                 *********************--
function LoadLessItem()
    local liLoop

    if myDB.db.realm.AllLessItems then
        for liLoop = 1, #myDB.db.realm.AllLessItems.CharName do
            table.insert(AllLessItems.CharName,  myDB.db.realm.AllLessItems.CharName[liLoop])
            table.insert(AllLessItems.ItemCount, myDB.db.realm.AllLessItems.ItemCount[liLoop])
            table.insert(AllLessItems.ItemName,  myDB.db.realm.AllLessItems.ItemName[liLoop])
        end
    end
end

--****************              保存角色缺货物品清单                 *********************--
function SaveLessItem()
    local liLoop, liLoopLess

    -- 找当前角色的数据，找到就删除
    for liloop = #AllLessItems.CharName, 1, -1  do
        if AllLessItems.CharName[liloop] == (select(1, UnitName("player"))) then
            table.remove(AllLessItems.CharName, liloop)
            table.remove(AllLessItems.ItemCount, liloop)
            table.remove(AllLessItems.ItemName, liloop)
        end
    end

    -- 填充进去新的清单
    for liLoop = 1, #LessItems.ItemCount do
        table.insert(AllLessItems.CharName, (select(1, UnitName("player"))))
        table.insert(AllLessItems.ItemCount, LessItems.ItemCount[liLoop])
        table.insert(AllLessItems.ItemName, LessItems.ItemName[liLoop])
    end

    myDB.db.realm.AllLessItems = AllLessItems
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    拍卖场挂货功能(4.0)      ---------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.AHPostItem = 0                                 -- 0 闲置，10 准备发出挂货指令，20 挂货指令发出，等待结果, 30 正在挂货（这个状态通过前端宏实现）
local AHPostItem4 = {}
AHPostItem4.GET_RESULT_LOOP_TIME = 0.0                   -- 状态机循环间隔
AHPostItem4.AH_TIME = 1                                  -- 拍卖时间（对于4.0来说是1、2、3，对于3.3来说是小时*60秒）
AHPostItem4.CUT_PRICE = 1                                -- 砍价幅度

AHPostItem4.PostHandle = ""                              -- 挂货状态机句柄

AHPostItem4.PostItemName = ""                            -- 拍卖物品名称
AHPostItem4.PostSingleItemPrice = 0                      -- 拍卖物品单价(铜板为单位)
AHPostItem4.PostItemStackSize = 0                        -- 拍卖物品每堆数量
AHPostItem4.PostItemNumStack = 0                         -- 拍卖物品共放置多少堆

AHPostItem4.ItemBag = 0                                  -- 待挂货物品所在包
AHPostItem4.ItemSlot = 0                                 -- 待挂货物品所在槽
AHPostItem4.ItemLeftStack = 0                            -- 剩余多少堆要挂出去

function AHPostItem4Door(astrItemName, aiSingleItemPrice, aiItemStackSize, aiItemNumStack)
    HWstatus.AHPostItem = 0
    -- 检查参数值
    if astrItemName == nil then
        debugprint("AHPostItem4Door： 要干什么？？说话。。")
        AHPostItem4Machine:Fail()
        return
    end
     if astrItemName == "" then
        AHPostItem4Machine:Fail()
        debugprint("AHPostItem4Door： 要干什么？？说话。。")
        return
    end
    if aiSingleItemPrice == nil or aiSingleItemPrice == 0 then
        debugprint("AHPostItem4Door： 参数aiSingleItemPrice=0")
        AHPostItem4Machine:Fail()
        return
    end
    if aiItemStackSize == nil or aiItemStackSize == 0 then
        debugprint("AHPostItem4Door： 参数aiItemStackSize=0")
        AHPostItem4Machine:Fail()
        return
    end
    if aiItemNumStack == nil or aiItemNumStack == 0 then
        debugprint("AHPostItem4Door： 参数aiItemNumStack=0")
        AHPostItem4Machine:Fail()
        return
    end

    -- 看看环境是不是合适
    if IsAHOpen() ~= 1 then
        debugprint("AHPostItem4Door： AH Close")
        HWstatus.AHPostItem = -1
        CheckFlag = 0
        return
    end

    -- 赋值初始化变量
    AHPostItem4.PostItemName = astrItemName
    AHPostItem4.PostSingleItemPrice = aiSingleItemPrice
    AHPostItem4.PostItemStackSize = aiItemStackSize
    AHPostItem4.PostItemNumStack = aiItemNumStack

    -- 找到指定物品所在包、槽
    AHPostItem4.ItemBag, AHPostItem4.ItemSlot = SearchItem(AHPostItem4.PostItemName, 0)
    if AHPostItem4.ItemBag == -1 then
        HWstatus.AHPostItem = -1
        return
    end

    HWstatus.AHPostItem = 10

    -- 做准备工作，把物品从包里面拉出来，放到拍卖框上去
    PickupContainerItem(AHPostItem4.ItemBag, AHPostItem4.ItemSlot)
    ClickAuctionSellItemButton()
    ClearCursor()

    -- 设定颜色状态，让前台发出拍卖指令(前台按下指令，然后清除颜色状态，设定开始拍卖的标志，后续工作由游戏的时间触发完成)
    CheckFlag = 210

end

function AHPostItem4Check()
    return HWstatus.AHPostItem
end

function AHPostItem4BeginPost()
    HWstatus.AHPostItem = 20
end

function AHPostItem4GetPara(aiParaNo)
    if aiParaNo == 1 then
        return AHPostItem4.PostSingleItemPrice * AHPostItem4.PostItemStackSize - AHPostItem4.CUT_PRICE
    end
    if aiParaNo == 2 then
        return AHPostItem4.PostSingleItemPrice * AHPostItem4.PostItemStackSize - AHPostItem4.CUT_PRICE
    end
    if aiParaNo == 3 then
        return AHPostItem4.AH_TIME
    end
    if aiParaNo == 4 then
        return AHPostItem4.PostItemStackSize
    end
    if aiParaNo == 5 then
        return AHPostItem4.PostItemNumStack
    end
end

function AHPostItem4FirstPost()
    if HWstatus.AHPostItem == 20 then
        AHPostItem4.ItemLeftStack = AHPostItem4.PostItemNumStack
    end
end

function AHPostItem4NextPost()
    if HWstatus.AHPostItem == 20 then
        AHPostItem4.ItemLeftStack = AHPostItem4.ItemLeftStack - 1
        if AHPostItem4.ItemLeftStack == 0 then
            HWstatus.AHPostItem = 0
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    拍卖场取消功能      --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.AHCancel = 0                                 -- 0 闲置，1 运行中，2 已经发出取消指令，等待取消完成，3 取消完成，等待
local AHCancel = {}
local AHCancelMachine = LibStub("AceAddon-3.0"):NewAddon("AHCancelMachine", "AceTimer-3.0")
AHCancel.GET_RESULT_LOOP_TIME = 0.1                 -- 状态机循环间隔
AHCancel.WAIT_TIME = 0.3                              -- 事件结束之后，等待多久，才做下一件

AHCancel.CancelHandle = ""
AHCancel.CancelItem = ""
AHCancel.CancelItemNo = 0

function AHCancelDoor(astrItemName)
    -- 检查参数值
    if astrItemName == nil then
        HWstatus.AHCancel = -1
        debugprint("AHCancelDoor 要干什么？？说话。。")
        return
    end
     if astrItemName == "" then
        HWstatus.AHCancel = -1
        debugprint("AHCancelDoor 要干什么？？说话。。")
        return
    end

    -- 看看环境是不是合适
    if IsAHOpen() ~= 1 then
        HWstatus.AHCancel = -1
        return
    end

    -- 赋值初始化变量
    AHCancel.CancelItem = astrItemName

    -- 启动
    AHCancelMachine:Start()
end

function AHCancelCheck()
    return HWstatus.AHCancel
end

function AHCancelDoIt()
    CancelAuction(AHCancel.CancelItemNo)
end

function AHCancelMachine:Start()
    -- 判断状态
    if HWstatus.AHCancel ~= 0 then
        debugprint("AHCancel：取消正在进行。。。。。")
        return
    end

    -- 设置状态参数
    HWstatus.AHCancel = 1

    -- 设置初始化参数

    -- 启动状态机AHCancel.CancelHandle
    AHCancel.CancelHandle = AHCancelMachine:ScheduleRepeatingTimer("Run", AHCancel.GET_RESULT_LOOP_TIME)
end

function AHCancelMachine:Stop()
    -- 关闭状态机
    AHCancelMachine:CancelTimer(AHCancel.CancelHandle,true)

    -- 复位运行参数

    -- 设置状态参数
    HWstatus.AHCancel = 0
end

function AHCancelMachine:Fail()
    -- 关闭状态机
    AHCancelMachine:CancelTimer(AHCancel.CancelHandle,true)

    -- 复位运行参数

    -- 设置状态参数
    HWstatus.AHCancel = -1
end

function AHCancelMachine:Run()
    local liLoop, liTotalItemCount, lstrItemName, liFlagSold

    -- 检查环境情况
    if IsAHOpen() ~= 1 then
        AHCancelMachine:Fail()
        return
    end

    -- 检查状态，并执行主体程序
    if HWstatus.AHCancel == 1 then
        _, liTotalItemCount = GetNumAuctionItems("owner")
        if liTotalItemCount then
            for liLoop = 1, liTotalItemCount do
                lstrItemName = (select(1, GetAuctionItemInfo("owner", liLoop)))
                liFlagSold = (select(14, GetAuctionItemInfo("owner", liLoop)))
                if lstrItemName == AHCancel.CancelItem and liFlagSold == 0 then
                    AHCancel.CancelItemNo = liLoop
                    --CancelAuction(liLoop)
                    -- 选定目标，改色，通知autoit点击取消按钮，然后再置状态
                    HWstatus.AHCancel = 2
                    --SetSelectedAuctionItem("owner", liLoop)
                    CheckFlag = 200
                    return
                end
            end
            AHCancelMachine:Stop()
            return
        end
    end
end

function AHCancelMachine:Waiting()
    if HWstatus.AHCancel == 3 then
        HWstatus.AHCancel = 1
    end
end

function AHCancelMachine:CancelDone()
    if HWstatus.AHCancel == 2 then
        HWstatus.AHCancel = 3
        AHCancelMachine:ScheduleTimer("Waiting", AHCancel.WAIT_TIME)
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    取消AH中小于指定价格的已经上架的物品      --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function CancelAH(astrItemName, aiPrice)
    SendData("正在执行")

    if astrItemName == nil then
        SendErrData("物品名称为空")
        return
    end
    if astrItemName == "" then
        SendErrData("物品名称为空")
        return
    end
    if aiPrice == nil then
        SendErrData("物品价格为空")
        return
    end
    if aiPrice == 0 then
        SendErrData("物品价格为0")
        return
    end

    -- 检查环境情况
    if IsAHOpen() ~= 1 then
        SendErrData("AH 没有打开")
        return
    end

    local liTotalItemCount, liLoop, lstrItemName, liFlagSold, liBuyoutPrize

    _, liTotalItemCount = GetNumAuctionItems("owner")
    if liTotalItemCount then
        for liLoop = 1, liTotalItemCount do
            lstrItemName = (select(1, GetAuctionItemInfo("owner", liLoop)))             --物品名称
            liFlagSold = (select(14, GetAuctionItemInfo("owner", liLoop)))              --是否售出
            liBuyoutPrize = (select(10, GetAuctionItemInfo("owner", liLoop)))           --是否售出
            if lstrItemName == astrItemName and liFlagSold == 0 and aiPrice - liBuyoutPrize < 0 then
                CancelAuction(liLoop)
                SendData("YES需要被取消")
                return
            end
        end
        SendData("NO不需要被取消")
        return
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    计算最大最小值      --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.AHMaxMin = 0             -- 0 表示一般状态，1 表示正在运行
local AHMaxMin = {}

AHMaxMin.ItemName = ""
AHMaxMin.Result = {}
AHMaxMin.Result.MaxBuyOutPrice = 0
AHMaxMin.Result.MaxBuyOutSeller = ""
AHMaxMin.Result.MinBuyOutPrice = 0
AHMaxMin.Result.MinBuyOutSeller = ""

function AHMaxMinDoor(astrItemName)
    -- 检查参数值
    if astrItemName == nil then
        debugprint("AHMaxMinDoor 要干什么？？说话。。")
        return
    end
    if astrItemName == "" then
        debugprint("AHMaxMinDoor 要干什么？？说话。。")
        return
    end

    -- 赋值初始化变量
    AHMaxMin.ItemName = astrItemName

    -- 启动
    AHMaxMin:Start()
end

function AHMaxMin:Start()
    if HWstatus.AHMaxMin ~= 0 then
        debugprint("AHMaxMin： 正在运行中。。。。")
        return
    end

    AHMaxMin.Result.MaxBuyOutPrice = 0
    AHMaxMin.Result.MaxBuyOutSeller = ""
    AHMaxMin.Result.MinBuyOutPrice = 0
    AHMaxMin.Result.MinBuyOutSeller = ""

    local liLoop
    HWstatus.AHMaxMin = 1
    for liLoop = 1, table.getn(AHSearch.SearchResult.ItemName) do
        if AHSearch.SearchResult.ItemName[liLoop] == AHMaxMin.ItemName then
            if AHMaxMin.Result.MinBuyOutPrice == 0 then
                AHMaxMin.Result.MinBuyOutPrice = AHSearch.SearchResult.ItemEachPrice[liLoop]
                AHMaxMin.Result.MinBuyOutSeller = AHSearch.SearchResult.ItemSellerName[liLoop]
            elseif AHSearch.SearchResult.ItemEachPrice[liLoop] < AHMaxMin.Result.MinBuyOutPrice then
                AHMaxMin.Result.MinBuyOutPrice = AHSearch.SearchResult.ItemEachPrice[liLoop]
                AHMaxMin.Result.MinBuyOutSeller = AHSearch.SearchResult.ItemSellerName[liLoop]
            end
            if AHMaxMin.Result.MaxBuyOutPrice == 0 then
                AHMaxMin.Result.MaxBuyOutPrice = AHSearch.SearchResult.ItemEachPrice[liLoop]
                AHMaxMin.Result.MaxBuyOutSeller = AHSearch.SearchResult.ItemSellerName[liLoop]
            elseif AHSearch.SearchResult.ItemEachPrice[liLoop] > AHMaxMin.Result.MaxBuyOutPrice then
                AHMaxMin.Result.MaxBuyOutPrice = AHSearch.SearchResult.ItemEachPrice[liLoop]
                AHMaxMin.Result.MaxBuyOutSeller = AHSearch.SearchResult.ItemSellerName[liLoop]
            end
        end
    end

    HWstatus.AHMaxMin = 0
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     纯工具类程序     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- 十进制转换二进制
function ten_to_bin(ivalue)
    local i,imod,strRtv
    strRtv=""
    for i=1,MAX_BIN_VALUE_LENGTH do
        imod=mod(ivalue,2)
        if ivalue-imod<0 then
            ivalue=0
        end
        ivalue=floor((ivalue-imod)/2)
        strRtv=strRtv..tostring(imod)
    end
    return strRtv
end

-- 搜索指定物品，返回bag和slot
function SearchItem(astrItemName, aiStackSize)
    -- aiStackSize = 0 表示不限定查询的数量
    local bag, slot, item
    for bag = 0,4 do
        for slot = 1,GetContainerNumSlots(bag) do
            item = select(7,GetContainerItemInfo(bag,slot))
            if (item) then
                if (select(1,GetItemInfo(item)) == astrItemName) then
                    if aiStackSize == 0 then
                        return bag, slot
                    else
                        if select(2,GetContainerItemInfo(bag,slot)) - aiStackSize == 0 then
                            return bag, slot
                        end
                    end
                end
            end
        end
    end
    return -1, -1
end

-- 计算包包的剩余空间
function CalcBagFreeSlotCount()
    local liBag, liCount

    liCount = 0
    for liBag = 0, 4 do
        liCount = liCount + select(1, GetContainerNumFreeSlots(liBag))
    end
    return liCount
end

-- 计算包包中指定物品数量
function CalcItemCount(astrItemName)
    local SlotCount, bag, slot, item
    SlotCount = 0
    for bag = 0,4 do
        for slot = 1,GetContainerNumSlots(bag) do
            item = select(7,GetContainerItemInfo(bag,slot))
            if (item) then
                if (select(1,GetItemInfo(item)) == astrItemName) then
                    SlotCount = SlotCount + select(2,GetContainerItemInfo(bag,slot))
                end
            end
        end
    end
    return SlotCount
end

-- 找最近的一个包包中的空槽
function FindEmptySlot()
    local liBag, liTempBag, liTempSlot, ltblFreeSlots, liNumFreeSlots
    for liBag = 0,4 do
        liNumFreeSlots, _ = GetContainerNumFreeSlots(liBag)
        if liNumFreeSlots > 0 then
            ltblFreeSlots = GetContainerFreeSlots(liBag)
            liTempBag = liBag
            liTempSlot = ltblFreeSlots[1]
            return liTempBag, liTempSlot
        end
    end
    return -1, -1
end

-- 拍卖场是不是开着
function IsAHOpen()
    if (HWstatus.AHBox == 1) then
        return 1
    else
        NormalPrint("拍卖场已经关闭")
        return 0
    end
end

function IsMailBoxOpen()
    if (HWstatus.MailBox == 1) then
        return 1
    else
        NormalPrint("邮箱没开")
        return 0
    end
end

function debugprint(astrMsg)
    if HWstatus.debug == 1 then
        print(astrMsg)
        DEFAULT_CHAT_FRAME:AddMessage(astrMsg);
    end
end

function NormalPrint(astrMsg)
    print(astrMsg)
end

-- table 数据 复制
function table_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end

-- 获得物品ID
function getItemIDByName(astrItemName)
    local lsLink, lsItemID
    lsLink = (select(2, GetItemInfo(astrItemName)))
    if (lsLink) then
        lsLink = string.match(lsLink or "", "|H(.-):([-0-9]+):([0-9]+)|h")
        lsItemID = string.gsub(lsLink, ":0:0:0:0:0:0", "")
    end
    return lsItemID
end

-- 获得物品名称
function getItemNameByID(astrItemID)
    local lstrName
    lstrName = (select(1,GetItemInfo(astrItemID)))
    return lstrName
end

-- 获知动作条上制定魔法cooldown是否结束(0--OK, 1--No, -1--Error)
function isCooldown(astrSpellName)
    local liLoopActionSlot
    local start,duration,enable
    local name
    local actiontype,id,subtype

    for liLoopActionSlot = 1, 120 do
        actiontype,id,subtype = GetActionInfo(liLoopActionSlot)
        if actiontype == "spell" then
            name = GetSpellName(id, "spell")
            --print(name)
            if name == astrSpellName then
                start,duration,enable = GetActionCooldown(liLoopActionSlot)
                --print(start .. "   " .. duration)
                if duration == 0 then
                    return 0
                else
                    return 1
                end
            end
        end
    end
    return -1
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------        取信程序      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

HWstatus.MailBoxGetItemNew = 0             -- 0 闲置，10 发出取信命令，等待Event，20 Event响应，发出等待，30 检查等待状态
local MailBoxGetItemMachineNew = LibStub("AceAddon-3.0"):NewAddon("MailBoxGetItemMachineNew", "AceTimer-3.0")

local MailBoxGetItemNew = {}
MailBoxGetItemNew.WAIT_TIME = 0.01
MailBoxGetItemNew.LOOP_TIME = 0.01

MailBoxGetItemNew.Handle = ""

MailBoxGetItemNew.LoopCount = 0

-- 待取信数组，其中保存等待取信的数据清单，没有具体物品的内容，只有邮箱ID和附件ID
MailBoxGetItemNew.TblMailID = {}
MailBoxGetItemNew.TblAttachID = {}

-- 根据Table中记录的待取货清单（MailID，AttachID），获得物品(由于邮箱ID，在每次取信时会发生变化（相当于table.remove），因此要倒序取信)
-- 需要一个循环参数控制MailBoxGetItemNew.LoopCount，来控制目前取货到第几件
-- 通过注册Mail的相应事件，来获知是否拿到物品

function MailBoxGetItemDoorNew()
    local liLoop

    -- 检查取货列表
    if table.getn(MailBoxGetItemNew.TblMailID) == 0 then
        NormalPrint("MailBoxGetItemDoorNew: 没有待取货物品清单")
        return
    end

    -- 检查是否正在进行
    if MailBoxGetItemCheckNew() ~= 0 then
        NormalPrint("MailBoxGetItemDoorNew: 取货正在进行中")
        return
    end

    MailBoxGetItemMachineNew:Start()
end

function MailBoxGetItemCheckNew()
    return HWstatus.MailBoxGetItemNew
end

function MailBoxGetItemMachineNew:Start()
    if IsMailBoxOpen() == 0 then
        MailBoxGetItemMachineNew:Stop()
        return
    end

    -- 初始化参数
    MailBoxGetItemNew.LoopCount = table.getn(MailBoxGetItemNew.TblMailID)

    -- 设置状态参数
    HWstatus.MailBoxGetItemNew = 10

    -- 启动状态机
    MailBoxGetItemNew.Handle = MailBoxGetItemMachineNew:ScheduleRepeatingTimer("Run", MailBoxGetItemNew.LOOP_TIME)

end

function MailBoxGetItemMachineNew:Stop()
    --关闭状态机
    if MailBoxGetItemNew.Handle then
        MailBoxGetItemMachineNew:CancelTimer(MailBoxGetItemNew.Handle, true)
    end
    --设置状态参数
    HWstatus.MailBoxGetItemNew = 0

end

function MailBoxGetItemMachineNew:Run()
    if IsMailBoxOpen() == 0 then
        MailBoxGetItemMachineNew:Stop()
        return
    end

    if HWstatus.MailBoxGetItemNew == 10 then
        TakeInboxItem(MailBoxGetItemNew.TblMailID[MailBoxGetItemNew.LoopCount], MailBoxGetItemNew.TblAttachID[MailBoxGetItemNew.LoopCount])
        HWstatus.MailBoxGetItemNew = 20
    end
end

function MailBoxGetItemMachineNew:Waiting()
    if HWstatus.MailBoxGetItemNew == 30 then
        if MailBoxGetItemNew.LoopCount == 1 then
            NormalPrint("********** 信封取货完成 **********")
            MailBoxGetItemMachineNew:Stop()
            return
        end

        MailBoxGetItemNew.LoopCount = MailBoxGetItemNew.LoopCount - 1

        -- 拿下一件物品
        HWstatus.MailBoxGetItemNew = 10
    end
end

function MailBoxGetItemMachineNew:EventReady()
    if HWstatus.MailBoxGetItemNew == 20 then
        MailBoxGetItemMachineNew:ScheduleRepeatingTimer("Waiting", MailBoxGetItemNew.WAIT_TIME)
        HWstatus.MailBoxGetItemNew = 30
    end
end

--------------------------------------------------------------------------------------------------------------------------
--------------------------------      拿取邮箱中指定名称的物品      ------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function GetMAILAsItem(astrItemName)
    local liInboxCount, liLoop, iLoopNext, lstrItemName, liMaxCount

    if not astrItemName or astrItemName == "" then
        print("提供名称")
        return
    end

    -- 清空邮箱待取清单
    MailBoxGetItemNew.TblMailID = wipe(MailBoxGetItemNew.TblMailID)
    MailBoxGetItemNew.TblAttachID = wipe(MailBoxGetItemNew.TblAttachID)

    -- 在邮箱中找是否有满足条件的物品
    liInboxCount,_ = GetInboxNumItems()
    for liLoop = 1, liInboxCount do
        for iLoopNext=1,12 do
            lstrItemName = select(1, GetInboxItem(liLoop, iLoopNext))
            if (lstrItemName) and lstrItemName == astrItemName then
                table.insert(MailBoxGetItemNew.TblMailID, liLoop)
                table.insert(MailBoxGetItemNew.TblAttachID, iLoopNext)
            end
        end
    end

    -- 确定是否有符合条件的物品
    if table.getn(MailBoxGetItemNew.TblMailID) > 0 then
        MailBoxGetItemDoorNew()
    end

end



--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------        发信程序      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.SendMail = 0
local SendMailMachine = LibStub("AceAddon-3.0"):NewAddon("SendMailMachine", "AceTimer-3.0")

local SendMailTo = {}
SendMailTo.WAIT_TIME = 0.1
SendMailTo.LOOP_TIME = 0.1
SendMailTo.Handle = ""
SendMailTo.Looping = 0
SendMailTo.MaxGroup = 0
SendMailTo.MAXATTACHCOUNT = 12

-- 待发邮件清单
SendMailTo.Group = {}
SendMailTo.Receiver = {}
SendMailTo.ItemBagID = {}
SendMailTo.ItemSlotID = {}

function SendMailDoor()
    -- 检查待发送清单列表
    if table.getn(SendMailTo.Group) == 0 then
        NormalPrint("******** 邮包是空的 ********")
        return
    end

    -- 检查是否正在进行
    if HWstatus.SendMail > 0 then
        NormalPrint("******** 邮件发送程序正在进行中 ********")
        return
    end

    -- 进入发信状态机
    SendMailMachine:Start()
end

-- 清空邮包table
function CleanMailPackage()
    if HWstatus.SendMail > 0 then
        NormalPrint("******** 邮件发送程序正在进行中 ********")
        return -1
    end
    SendMailTo.Group = wipe(SendMailTo.Group)
    SendMailTo.Receiver = wipe(SendMailTo.Receiver)
    SendMailTo.ItemBagID = wipe(SendMailTo.ItemBagID)
    SendMailTo.ItemSlotID = wipe(SendMailTo.ItemSlotID)
    return 0
end

-- 显示邮包情况
function DispMailPackage()
    local liLoop
    if GetMaxGroup() > 0 then
        for liLoop = 1, table.getn(SendMailTo.Group) do
            print("Group: " .. SendMailTo.Group[liLoop] .. " Receiver:" .. SendMailTo.Receiver[liLoop] .. " Bag:" .. SendMailTo.ItemBagID[liLoop] .. " Slot:" .. SendMailTo.ItemSlotID[liLoop])
        end
    end
end

function AddMailPackage(astrReceiver, aiBagID, aiSlotID)
    local liLoop, liGroupID, liCount
    if astrReceiver == nil or aiBagID == nil or aiSlotID == nil then
        NormalPrint("********** 用参数为空 **********")
        return -1
    end

    -- 看看是不是已经有这个物品（靠背包和slot检查）
    for liLoop = 1, table.getn(SendMailTo.Group) do
        if SendMailTo.ItemBagID[liLoop] == aiBagID and SendMailTo.ItemSlotID[liLoop] == aiSlotID then
            NormalPrint("********** 同样的物品已经在包裹中 **********")
            return -2
        end
    end
    -- 先找到最大的group号，然后看看这个人名下最大group中还有没有空位，有就加，没有就分配一个新的组号
    if GetMaxGroup() > 0 then
        if GetMaxGroup(astrReceiver) > 0 then
            -- 看看这个人名下还有没有空位
            liCount = 0
            for liLoop = 1, table.getn(SendMailTo.Group) do
                if SendMailTo.Group[liLoop] == GetMaxGroup(astrReceiver) and SendMailTo.Receiver[liLoop] == astrReceiver then
                    liCount = liCount + 1
                end
            end
            if liCount < SendMailTo.MAXATTACHCOUNT then
                liGroupID = GetMaxGroup(astrReceiver)
            else
                liGroupID = GetMaxGroup() + 1
            end
        else
            liGroupID = GetMaxGroup() + 1
        end
    else
        liGroupID = 1
    end

    table.insert(SendMailTo.Group, liGroupID)
    table.insert(SendMailTo.Receiver, astrReceiver)
    table.insert(SendMailTo.ItemBagID, aiBagID)
    table.insert(SendMailTo.ItemSlotID, aiSlotID)
    return 0
end

-- 获得最大组号，如果输入名称为空，则全部，否则是个人
function GetMaxGroup(astrReceiver)
    local liLoop, liMaxGroup

    liMaxGroup = 0

    if astrReceiver == nil then
        for liLoop = 1, table.getn(SendMailTo.Group) do
            if SendMailTo.Group[liLoop] > liMaxGroup then
                liMaxGroup = SendMailTo.Group[liLoop]
            end
        end
    else
        for liLoop = 1, table.getn(SendMailTo.Group) do
            if SendMailTo.Receiver[liLoop] == astrReceiver then
                if SendMailTo.Group[liLoop] > liMaxGroup then
                    liMaxGroup = SendMailTo.Group[liLoop]
                end
            end
        end
    end

    return liMaxGroup
end

function GetSendStatus()
    return HWstatus.SendMail
end

function SendMailMachine:Start()
    local liLoop
    if IsMailBoxOpen() == 0 then
        SendMailMachine:Stop()
        return
    end

    -- 初始化状态
    HWstatus.SendMail = 10
    SendMailTo.Looping = 1
    SendMailTo.MaxGroup = GetMaxGroup()

    -- 启动状态机
    SendMailTo.Handle = SendMailMachine:ScheduleRepeatingTimer("Run", SendMailTo.LOOP_TIME)
end

function SendMailMachine:Stop()
    -- 关闭状态机
    if SendMailTo.Handle then
        SendMailMachine:CancelTimer(SendMailTo.Handle, true)
    end
    
    -- 设置状态参数
    HWstatus.SendMail = 0
end

function SendMailMachine:Run()
    local liLoop, lstrReceiver
    local ltblTempBagID = {}
    local ltblTempSlotID = {}

    if IsMailBoxOpen() == 0 then
        MailBoxGetItemMachineNew:Stop()
        return
    end

    if HWstatus.SendMail == 10 then
        
        ltblTempBagID = wipe(ltblTempBagID)
        ltblTempSlotID = wipe(ltblTempSlotID)

        -- 从清单中，找到这一组的数据：接收人、BagID、SlotID
        for liLoop = 1, table.getn(SendMailTo.Group) do
            if SendMailTo.Group[liLoop] == SendMailTo.Looping then
                lstrReceiver = SendMailTo.Receiver[liLoop]
                table.insert(ltblTempBagID, SendMailTo.ItemBagID[liLoop])
                table.insert(ltblTempSlotID, SendMailTo.ItemSlotID[liLoop])
            end
        end

        -- 开始给邮件加附件
        for liLoop = 1, table.getn(ltblTempBagID) do
            PickupContainerItem(ltblTempBagID[liLoop], ltblTempSlotID[liLoop])
            ClickSendMailItemButton()
        end
        
        -- Send Mail
        ClearCursor()
        SendMail(lstrReceiver, "自动发信程序")

        -- Set Status
        HWstatus.SendMail = 20
    end
end

function SendMailMachine:Waiting()
    if HWstatus.SendMail == 30 then
        if SendMailTo.Looping == SendMailTo.MaxGroup then
            NormalPrint("********** 发信完成 **********")
            SendMailMachine:Stop()
            return
        end

        SendMailTo.Looping = SendMailTo.Looping + 1

        -- 处理下一组邮包
        HWstatus.SendMail = 10
    end
end

function SendMailMachine:EventReady()
    if HWstatus.SendMail == 20 then
        SendMailMachine:ScheduleRepeatingTimer("Waiting", SendMailTo.WAIT_TIME)
        HWstatus.SendMail = 30
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     发送指定名称物品     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function SendItemByName(astrReceiver, astrName)
    local liBagID, liSlotID, lstrLink, lstrItemName

    SendData("正在执行")
    if astrName == nil then
        SendErrData("物品参数为空")
        NormalPrint("********** 物品参数为空 **********")
        return
    end
    
    if astrReceiver == nil then
        SendErrData("收信人参数为空")
        NormalPrint("********** 收信人参数为空 **********")
        return
    end
    
    -- 清空邮包table
    if CleanMailPackage() ~= 0 then
        SendErrData("清空邮包table")
        NormalPrint("********** 清空邮包table出错 **********")
        return
    end

    -- 生成邮包列表
    for liBagID = 0, 4 do
        for liSlotID = 1, GetContainerNumSlots(liBagID) do
            lstrLink = (select(7, GetContainerItemInfo(liBagID, liSlotID)))
            if (lstrLink) then
                lstrItemName = (select(1, GetItemInfo(lstrLink)))
                if (lstrItemName) then
                    if lstrItemName == astrName then
                        if AddMailPackage(astrReceiver, liBagID, liSlotID) ~= 0 then
                            SendErrData("收信人参数为空")
                            NormalPrint("********** 收信人参数为空 **********")
                            return
                        end
                    end
                end
            end
        end
    end

    -- 显示邮包情况
    -- DispMailPackage()

    -- 发送邮件
    SendMailDoor()
    SendData("执行完毕")
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     事件处理程序     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

function event_bag_update()
    if SplitItemMachine then
        SplitItemMachine:EventReady()
    end
    if MailBoxGetItemMachine then
        MailBoxGetItemMachine:EventReady()
    end
    if MailBoxGetItemMachineNew then
        MailBoxGetItemMachineNew:EventReady()
    end
end

function ahopen()
    if (HWstatus.AHBox == 0) then
        HWstatus.AHBox = 1
    end
    --debugprint("AH Open")
end
function ahclose()
    if (HWstatus.AHBox == 1) then
        HWstatus.AHBox = 0
    end
    --debugprint("AH Close")
end
function queryend()
    --debugprint("Fire")
    AHSearchItem:QueryEnd()
end

function event_AH_LIST_UPDATE()
    AHCancelMachine:CancelDone()
end

function event_mail_close()
    if (HWstatus.MailBox == 1) then
        HWstatus.MailBox = 0
    end
end

function event_mail_show()
    if (HWstatus.MailBox == 0) then
        HWstatus.MailBox = 1
    end
end

function event_send_success()
    if SendMailMachine then
        SendMailMachine:EventReady()
    end
end

function event_quit()
    SaveLessItem()
end

function event_ah_first()
    AHPostItem4FirstPost()
end

function event_ah_next()
    AHPostItem4NextPost()
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     数据交互功能区     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function SendData(strData)
    frmTest.Text:SetText(strData)
end

function SendErrData(strData)
    frmTest.Text:SetText("错误" .. strData)
end
--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     遍历背包，获得背包物品名称和数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
gItemName = {}
gItemCount = {}
function ScanBag()
    local iBag, iSlot, oItem
    local iCount
    local iLoop, iFound

    SendData("正在执行")
    iCount = 0
    for iBag = 0,4 do
        for iSlot = 1,GetContainerNumSlots(iBag) do
            oItem = GetContainerItemLink(iBag, iSlot)
            if (oItem) then
                -- 看看集合里面有没有这个物品
                iFound = 0
                for iLoop = 1, iCount do
                    if (gItemName[iLoop] == (select(1,GetItemInfo(oItem)))) then
                        iFound = 1
                        break
                    end
                end
                if (iFound == 0) then
                    iCount = iCount + 1
                    gItemName[iCount] = (select(1,GetItemInfo(oItem)))
                    gItemCount[iCount] = getXXcount(gItemName[iCount])
                end
            end
        end
    end
    SendData("执行完毕")
end

function ScanBagShow(iNext)
    -- 数据显示格式： 第几个#名称#数量#共几个#
    local iCount
    SendData("正在执行")
    
    if iNext == 0 then
        print("显示第一个")
        iCount = 1
    else
        print("显示第"..iNext.."个")
        iCount = iNext
    end

    if iNext > #gItemName then
        SendErrData("错误，超界限")
        return
    end

    SendData(iNext .. "#" .. gItemName[iNext] .. "#" .. gItemCount[iNext] .. "#" .. #gItemName  .. "#")
    print(iNext .. "#" .. gItemName[iNext] .. "#" .. gItemCount[iNext] .. "#" .. #gItemName  .. "#")
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     测试程序     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function AutoFeedPet()
    --创建安全模板按钮
    AutoFeedPet_Btn = CreateFrame("Button", "myButton", UIParent, "SecureActionButtonTemplate");
    AutoFeedPet_Btn:SetWidth(40);
    AutoFeedPet_Btn:SetHeight(40);
    AutoFeedPet_Btn:SetNormalTexture("Interface\\Icons\\INV_Misc_Food_18");
    AutoFeedPet_Btn:SetText("spell");
    AutoFeedPet_Btn:SetPoint('RIGHT', -250, -200);
    AutoFeedPet_Btn:Show();
    RunFeedPetMacro();
    AutoFeedPet_Btn:SetScript("OnUpdate", RunFeedPetMacro);
end

function RunFeedPetMacro()
    local lstrCMD;
    local macroText = '';
    AutoFeedPet_Btn:SetAttribute("type1", "macro");
    macroText = "/1 hello";
    AutoFeedPet_Btn:SetAttribute("macrotext", macroText);
end


--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    物品分堆功能      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
local SplitItem = {}

HWstatus.SplitItem = 0       -- 0 表示什么都不做，1 表示正在整理背包（拆分物品放置完毕，需求修改为此状态），2 表示开始放置拆分物品， 3 放置完毕，事件触发，人为等待中
                             -- -1 失败

local SplitItemMachine = LibStub("AceAddon-3.0"):NewAddon("SplitItemMachine", "AceTimer-3.0")

SplitItem.WAIT_TIME = 0.1
SplitItem.LOOP_TIME = 0.1

SplitItem.Handle = ""
SplitItem.EmptyBag = 0
SplitItem.EmptySlot = 0
SplitItem.ItemName = ""
SplitItem.StackSize = 0
SplitItem.ItemTargetStackSize = 0

function SplitItemDoor(astrItemName, aiPackSize)
    local liItemMaxStack
    local liTempBag, liTempSlot

    -- 输入参数检查
    liItemMaxStack = select(8, GetItemInfo(astrItemName))
    if liItemMaxStack == nil then
        debugprint("PlaceItem:没取到【"..astrItemName.."】的堆尺寸大小")
        SplitItemMachine:Fail()
        return -1
    end

    if aiPackSize - liItemMaxStack > 0 then
        debugprint("PlaceItem:参数设置与系统值冲突，堆放值【"..aiPackSize.."】超出标准【"..liItemMaxStack.."】")
        SplitItemMachine:Fail()
        return -1
    end

    if CalcBagFreeSlotCount() - 0 == 0 then
        debugprint("PlaceItem: 包空间不足")
        SplitItemMachine:Fail()
        return -1
    end

    liTempBag, liTempSlot = SearchItem(astrItemName, 0)
    if liTempBag - (-1) == 0 then
        debugprint("PlaceItem:包中未发现【"..astrItemName.."】")
        SplitItemMachine:Fail()
        return -1
    end

    if CalcItemCount(astrItemName) - aiPackSize < 0 then
        debugprint("PlaceItem: 包中【"..astrItemName.."】数量不足["..CalcItemCount(astrItemName).."]")
        SplitItemMachine:Fail()
        return -1
    end

    -- 传递变量值
    SplitItem.ItemName = astrItemName
    SplitItem.StackSize = aiPackSize

    -- 开始运行
    SplitItemMachine:Start()
end

function SplitItemOut()
    return SplitItem.EmptyBag, SplitItem.EmptySlot
end

function SplitItemCheck()
    return HWstatus.SplitItem
end

function SplitItemMachine:Start()
    local liEmptyBag, liEmptySlot
    if HWstatus.SplitItem ~= 0 then
        debugprint("SplitItemMachine:Start() 发现有分拆程序正在进行")
        SplitItemMachine:Fail()
        return
    end

    debugprint("SplitItemMachine:Start()")

    -- 看看是不是有堆叠好的
    liEmptyBag, liEmptySlot = SearchItem(SplitItem.ItemName, SplitItem.StackSize)
    if liEmptyBag >= 0 then
        SplitItem.EmptyBag = liEmptyBag
        SplitItem.EmptySlot = liEmptySlot
        SplitItemMachine:Stop()
        return
    end

    -- 定位空槽
    SplitItem.EmptyBag, SplitItem.EmptySlot = FindEmptySlot()

    -- 置待转移物品数量
    SplitItem.ItemTargetStackSize = SplitItem.StackSize

    HWstatus.SplitItem = 1
    SplitItem.Handle = SplitItemMachine:ScheduleRepeatingTimer("Run", SplitItem.LOOP_TIME)
end

function SplitItemMachine:Stop()
    if SplitItem.Handle then
        SplitItemMachine:CancelTimer(SplitItem.Handle,true)
    end

    HWstatus.SplitItem = 0

    if HWstatus.debug == 1 then
        debugprint("SplitItemMachine:Stop()")
    end
end

function SplitItemMachine:Fail()
    if SplitItem.Handle then
        SplitItemMachine:CancelTimer(SplitItem.Handle,true)
    end

    HWstatus.SplitItem = -1
end

function SplitItemMachine:Run()
    local liTempBag, liTempSlot, liTempStack             -- 循环时用的，包、槽
    local lstrItemLink

    if HWstatus.SplitItem == 1 and SplitItem.ItemTargetStackSize == 0 then
        SplitItemMachine:Stop()
        return
    end

    if HWstatus.SplitItem == 1 then
        for liTempBag = 0, 4 do
            for liTempSlot = 1, GetContainerNumSlots(liTempBag) do
                if not (liTempBag - SplitItem.EmptyBag == 0 and liTempSlot - SplitItem.EmptySlot == 0) then             -- 跳过空包
                    lstrItemLink = GetContainerItemLink(liTempBag, liTempSlot)
                    if lstrItemLink then
                        if (select(1,GetItemInfo(lstrItemLink)) == SplitItem.ItemName) then
                            liTempStack = select(2, GetContainerItemInfo(liTempBag, liTempSlot))
                            if SplitItem.ItemTargetStackSize - liTempStack <= 0 then
                                SplitContainerItem(liTempBag, liTempSlot, SplitItem.ItemTargetStackSize)
                                PickupContainerItem(SplitItem.EmptyBag, SplitItem.EmptySlot)
                                SplitItem.ItemTargetStackSize = 0
                                HWstatus.SplitItem = 2
                                --debugprint("Place if 1")
                                return
                            else
                                PickupContainerItem(liTempBag, liTempSlot)
                                PickupContainerItem(SplitItem.EmptyBag, SplitItem.EmptySlot)
                                SplitItem.ItemTargetStackSize = SplitItem.ItemTargetStackSize - liTempStack
                                HWstatus.SplitItem = 2
                                --debugprint("Place if 2")
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function SplitItemMachine:Waiting()
    if HWstatus.SplitItem == 3 then
        HWstatus.SplitItem = 1
    end
end
function SplitItemMachine:EventReady()
    if HWstatus.SplitItem == 2 then
        HWstatus.SplitItem = 3
        SplitItemMachine:ScheduleTimer("Waiting", SplitItem.WAIT_TIME)
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------      少货自动补货      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function GetLessItemAtMailDoor()
    local ltblTempMailID = {}
    local ltblTempAttachID = {}
    local ltblTempMailIDSort = {}
    local liLoopMail, liAttchLoop, lstrLessItemName, lstrItemName                -- 搜索少货物品在邮箱中位置
    local liLoopLessItemCount = {}
    local liLoopLessItemName = {}
    local liMailBoxCount, liMailItemCount

    -- 计算是否缺货
    if CheckItemCount() == 0 then
        NormalPrint("啥都不缺啊。。。。。。。。。")
        return
    end

    -- 获取最大邮件数量
    liMailBoxCount = select(1, GetInboxNumItems())

    -- 清空邮箱待取清单
    MailBoxGetItemNew.TblMailID = wipe(MailBoxGetItemNew.TblMailID)
    MailBoxGetItemNew.TblAttachID = wipe(MailBoxGetItemNew.TblAttachID)

    -- 复制一对少货数据
    liLoopLessItemCount = table_copy(LessItems.ItemCount)
    liLoopLessItemName = table_copy(LessItems.ItemName)

    -- 在邮箱中找是否有满足条件的物品，获得一个取货的队列
    -- 按照名称循环遍历少货数组，找到货物，就在少货数量上-1，直到少货数量为0，同时在少货清单中删除这种货物。
    while table.getn(liLoopLessItemName) > 0 do
        lstrLessItemName = liLoopLessItemName[table.getn(liLoopLessItemName)]

        -- 开始在邮件中找指定名称的物品，找到一种，则liLoopLessItemCount减1，同时设置找到的标志位liFound
        liLoopMail = 0
        while (liLoopMail <= liMailBoxCount) and (liLoopLessItemCount[table.getn(liLoopLessItemName)] > 0) do
            liLoopMail = liLoopMail + 1
            liAttchLoop = 0
            while (liAttchLoop <= 12) and (liLoopLessItemCount[table.getn(liLoopLessItemName)] > 0) do
                liAttchLoop = liAttchLoop + 1
                lstrItemName, _, liMailItemCount, _, _ = GetInboxItem(liLoopMail, liAttchLoop)
                if lstrItemName then
                    if lstrItemName == lstrLessItemName then
                        table.insert(ltblTempMailID, liLoopMail)
                        table.insert(ltblTempAttachID, liAttchLoop)
                        liLoopLessItemCount[table.getn(liLoopLessItemName)] = liLoopLessItemCount[table.getn(liLoopLessItemName)] - liMailItemCount
                    end
                end
            end
        end

        -- 无论什么情况，一种物品只扫描邮箱一次
        table.remove(liLoopLessItemName, table.getn(liLoopLessItemName))
    end

    -- 看看有没有从邮箱获得信息
    if table.getn(ltblTempMailID) == 0 then
        NormalPrint("******** 邮箱中目前没有发现缺货清单中的物品 *********")
        return
    end

    local liLoopSort, liLoopTempMailID, liFound
    -- 以下是排序，对获得的邮箱物品清单进行排序，排序的目的是将按照物品顺序排列的取货清单，改为按照邮箱ID进行排序（从小到大）
    -- 复制一个取信结果ltblTempMailID到ltblTempMailIDSort，然后对ltblTempMailIDSort进行排序，之后从小往大循环遍历，搬移ltblTempMailID数据到MailBoxGetItemNew
    ltblTempMailIDSort = table_copy(ltblTempMailID)
    table.sort(ltblTempMailIDSort)
    for liLoopSort = 1, table.getn(ltblTempMailIDSort) do
        liFound = 0
        liLoopTempMailID = 0
        while ((liLoopTempMailID <= table.getn(ltblTempMailID)) and (liFound == 0)) do
            liLoopTempMailID = liLoopTempMailID + 1
            if ltblTempMailIDSort[liLoopSort] == ltblTempMailID[liLoopTempMailID] then
                liFound = 1
                table.insert(MailBoxGetItemNew.TblMailID, ltblTempMailID[liLoopTempMailID])
                table.insert(MailBoxGetItemNew.TblAttachID, ltblTempAttachID[liLoopTempMailID])

                table.remove(ltblTempMailID, liLoopTempMailID)
                table.remove(ltblTempAttachID, liLoopTempMailID)
            end
        end
    end

    -- 确定是否有符合条件的物品，发出取信命令
    if table.getn(MailBoxGetItemNew.TblMailID) > 0 then
        MailBoxGetItemDoorNew()
    end
end
