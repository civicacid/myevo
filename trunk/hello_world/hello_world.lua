-- 发送指定名称物品                             function SendItemByName(astrReceiver, astrName)                 无返回（获取到SendSuccData内容表示成功）
-- 满包邮寄                                     function SendItemByNameFull(astrReceiver, astrName)             无返回（获取到SendSuccData内容表示成功）
-- 按照关键字邮寄蓝色珠宝加工物品               function SendBlueItemByName(astrReceiver, astrGemName)          无返回（获取到SendSuccData内容表示成功）
-- 拿取邮箱中指定名称的物品                     function GetMAILAsItem(astrItemName, aiCount)                   无返回（获取到SendSuccData内容表示成功）
-- 指定数量的物品                               function GetMAILAsItemFull(astrItemName, aiCount, aiSize)       无返回（获取到SendSuccData内容表示成功）
-- 拍卖场查询功能                               function AHSearchDoor(astrItemName, aiprint)                    返回最小价格和seller
-- 取消AH中小于指定价格的已经上架的物品         function CancelAH(astrItemName, aiPrice)                        返回值中Yes表示已经取消一个，NO表示没有需要取消的了
-- 获得背包物品名称和数量                       function ScanBag()                                              无返回（获取到SendSuccData内容表示成功）
-- 获得邮箱中所有物品名称以及数量               function ScanInbox()                                            无返回（获取到SendSuccData内容表示成功）
-- 获取执行结果                                 function SendResult(iNext)                                      返回值中包含TAG_NEXT_PAGE时，需要读取下一页，否则不需要
-- 商业技能中做物品                             function TradeSkillDO(astrName)                                 无返回（获取到SendSuccData内容表示成功）
-- 收全部的信                                   function GetAllMailDoor()                                       无返回（获取到SendSuccData内容表示成功）
-- 珠宝加工+分解（找出来绿色的装备的名字）      function FindGreenEquip(astrGemName)                            返回装备名字

-- 在frame上实时显示物品在邮箱和背包中的数量    function DispItemCount(astrItemName)
-- 获得背包中指定物品的数量                     function getXXcountInBag(asItemName)
-- 获得邮箱中指定物品的数量                     function getXXcountInMail(asItemName)
-- 取信程序                                     function MailBoxGetItemDoorNew()
-- 获得物品名称                                 function getItemNameByID(astrItemID)
-- 获得背包剩余空间                             function getFreeSlotX()

-- 保存并处理执行结果(SaveResult)，将结果中超过MAX_TEXT_LENGTH的字符串分割保存在全局变量outStrings中，通过SendResult将结果发给前台

-- 常量定义区
local MAX_TEXT_LENGTH = 8100            -- 每个汉字长度为3,strsub不能正确处理汉字
local TAG_NEXT_PAGE = "【MORE】"        -- 放在结果的最前面

-- 全局变量
HWstatus = {}
DisplayItemName = ""
local outStrings = {}

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     初始化类程序     ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function hello_world_initialize()

    HWstatus.AHBox = 0
    HWstatus.MailBox = 0

    -- 测试真
    frmTest = CreateFrame("Frame", "frmTest", UIParent)
    frmTest:SetWidth(64) -- 设置宽度
    frmTest:SetHeight(64) -- 设置高度
    frmTest:SetBackdrop({
       bgFile = "Interface\\AddOns\\Sora's Threat\\Media\\Solid", -- 背景材质路径
       insets = {left = 1,right = 1,top = 1,bottom = 1}, -- 背景收缩程度，单位为像素，例如，top = 1即背景材质的上边缘向内收缩1个像素
       edgeFile = "Interface\\AddOns\\Sora's Threat\\Media\\Solid", -- 边框材质路径
       edgeSize = 2, -- 边框宽度
    })
    frmTest:SetBackdropColor(0, 0, 0, 0.6) -- 背景材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
    frmTest:SetBackdropBorderColor(0, 0, 0, 1)  -- 边框材质颜色 (Red, Green, Black, Alpha) 各参数的范围都是 0-1
    frmTest:SetPoint("TOPLEFT", WorldFrame, "TOPLEFT", 0, 0)
    frmTest.Text = frmTest:CreateFontString("frmTestText", "OVERLAY") -- 为Frame创建一个新的文字层
    frmTest.Text:SetFont("fonts\\zyhei.ttf", 10, "OUTLINE")
    frmTest.Text:SetPoint("CENTER", frmTest, "CENTER", 0, 0)
    --frmTest:Hide()

    -- 显示数据框体（专用于显示物品数量）
    frmData = CreateFrame("Frame", "frmData", UIParent)
    frmData:SetWidth(64) -- 设置宽度
    frmData:SetHeight(64) -- 设置高度
    frmData:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
    frmDataText = frmData:CreateFontString("frmDataText", "OVERLAY") -- 为Frame创建一个新的文字层
    frmDataText:SetFont("fonts\\zyhei.ttf", 10, "OUTLINE")
    frmDataText:SetPoint("TOP", frmData, "BOTTOM", 0, 0)
    --frmDataText:SetText("Hell World")
    --frmData:Hide()
    frmData:SetScript("OnUpdate", DispItemCount)

    -- 显示数据框体（专用于显示邮箱是否需要关闭）
    frmMailData = CreateFrame("Frame", "frmMailData", UIParent)
    frmMailData:SetWidth(64) -- 设置宽度
    frmMailData:SetHeight(64) -- 设置高度
    frmMailData:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 20)
    frmMailDataText = frmMailData:CreateFontString("frmMailDataText", "OVERLAY") -- 为Frame创建一个新的文字层
    frmMailDataText:SetFont("fonts\\zyhei.ttf", 10, "OUTLINE")
    frmMailDataText:SetPoint("TOP", frmMailData, "BOTTOM", 0, 0)
    --frmDataText:SetText("Hell World")
    --frmData:Hide()

end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    拍卖场查询功能      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.AHSearch = 0         -- 0 表示什么都不做，1 表示正在查询，2 表示已经发出查询指令并等待返回结果，3 表示正在查询后续页信息，-1 错误
local AHSearch = {}

local AHSearchItem = LibStub("AceAddon-3.0"):NewAddon("AHSearchItem", "AceTimer-3.0")

AHSearch.SearchItem = ""                                    -- 要找的东西
AHSearch.SearchResult = {}                                  -- 搜索结果
AHSearch.ResultHandle = ""                                  -- 搜索的句柄
AHSearch.QueryEndHandle = ""                                -- 确定查询结束的句柄
--AHSearch.Sort = 0                                         -- 是否按照价格做排序（0 不排序，1 按照单价做正序，2 倒序）
AHSearch.printOut = 0                                  -- 是否打印结果，0为不打印，1为打印

AHSearch.SearchResult.MAX_RETRY_COUNT = 5                   -- 查询后，收集结果时，没有人名，最多重试次数
AHSearch.SearchResult.GET_RESULT_LOOP_TIME = 0.5            -- 收集结果，循环检查时间（秒）

AHSearch.SearchResult.ItemName = {}
AHSearch.SearchResult.ItemCount = {}
AHSearch.SearchResult.ItemBuyout = {}
AHSearch.SearchResult.ItemEachPrice = {}
AHSearch.SearchResult.ItemSellerName = {}

AHSearch.SearchResult.MinEachPrice = 0          -- 最低价格
AHSearch.SearchResult.MinPriceSeller = ""       -- 最低价格对应的销售者
AHSearch.SearchResult.count = 0                 -- 计数器，用来累加有完全符合名称的物品数量
AHSearch.SearchResult.NowPage = 0               -- 当前正在扫描那一页
AHSearch.SearchResult.NowRecordingPage = -1     -- 当前正在记录的那一页
AHSearch.SearchResult.RetryCount = 0            -- 不出名字，重新刷新的次数

function AHSearchDoor(astrItemName, aiprint)
    SendBeginData()

    if astrItemName == nil then
        SendErrData("AHSearchDoor 要查什么？说话。。")
        print("AHSearchDoor 要查什么？说话。。")
        AHSearchItem:Fail()
        return
    end
    if astrItemName == "" then
        SendErrData("AHSearchDoor 要查什么？说话。。")
        print("AHSearchDoor 要查什么？说话。。")
        AHSearchItem:Fail()
        return
    end
    AHSearch.printOut = aiprint
    if IsAHOpen() ~= 1 then
        SendErrData("AHSearchDoor AH has been closed")
        print("AHSearchDoor AH has been closed")
        AHSearchItem:Fail()
        return
    end

    AHSearch.SearchItem = astrItemName
    AHSearchItem:Start()
end

function AHSearchMinOut()
    return AHSearch.SearchResult.MinEachPrice, AHSearch.SearchResult.MinPriceSeller
end

function AHSearchCheck()
    return HWstatus.AHSearch
end

function AHSearchItem:Start()
    if HWstatus.AHSearch ~= 0 and HWstatus.AHSearch ~= 10 then
        print("AHSearchItem:Start 查询正在进行，清稍后")
        AHSearchItem:Fail()
        return
    end

    if IsAHOpen() ~= 1 then
        print("AHSearchItem:Start AH has been closed")
        AHSearchItem:Fail()
        return
    end

    HWstatus.AHSearch = 1

    AHSearch.SearchResult.ItemName = wipe(AHSearch.SearchResult.ItemName)
    AHSearch.SearchResult.ItemCount = wipe(AHSearch.SearchResult.ItemCount)
    AHSearch.SearchResult.ItemBuyout = wipe(AHSearch.SearchResult.ItemBuyout)
    AHSearch.SearchResult.ItemEachPrice = wipe(AHSearch.SearchResult.ItemEachPrice)
    AHSearch.SearchResult.ItemSellerName = wipe(AHSearch.SearchResult.ItemSellerName)

    AHSearch.SearchResult.MinEachPrice = 0          -- 最低价格
    AHSearch.SearchResult.MinPriceSeller = ""       -- 最低价格对应的销售者
    AHSearch.SearchResult.count = 0                 -- 计数器，用来累加有完全符合名称的物品数量
    AHSearch.SearchResult.NowPage = 0               -- 当前正在扫描那一页
    AHSearch.SearchResult.NowRecordingPage = -1     -- 当前正在记录的那一页
    AHSearch.SearchResult.Waiting = 0               -- 等待状态
    AHSearch.SearchResult.RetryCount = 0            -- 不出名字，重新刷新的次数

    QueryAuctionItems(AHSearch.SearchItem, 0, 0, 0, 0, 0, nil, 0, 0, 0)

    AHSearch.ResultHandle = AHSearchItem:ScheduleRepeatingTimer("Run", AHSearch.SearchResult.GET_RESULT_LOOP_TIME)

end

function AHSearchItem:Run()
    --print("Run......")
    local liTotal
    local liLoop, lstrSellerName

    if IsAHOpen() ~= 1 then
        print("AHSearchItem:GetResult AH has been closed")
        AHSearchItem:Fail()
        return
    end

    if HWstatus.AHSearch == 1 then
        return
    end

    if HWstatus.AHSearch == 2 then
        --print("HWstatus.AHSearch == 2")

        -- 发出下一页的查询指令
        if (select(1,CanSendAuctionQuery("list"))) == 1 then
            print("发出下一页的查询指令")
            AHSearch.SearchResult.NowPage = AHSearch.SearchResult.NowPage + 1
            QueryAuctionItems(AHSearch.SearchItem, 0, 0, 0, 0, 0, AHSearch.SearchResult.NowPage, 0, 0, 0)
            -- 继续等待查询返回结果
            HWstatus.AHSearch = 1
            AHSearch.SearchResult.NowRecordingPage = -1
            AHSearch.SearchResult.RetryCount = 0
        end
    end

    if HWstatus.AHSearch == 3 then
        -- 发出下一页的查询指令
        if (select(1,CanSendAuctionQuery("list"))) == 1 then
            print("发出重新查询指令")
            QueryAuctionItems(AHSearch.SearchItem, 0, 0, 0, 0, 0, AHSearch.SearchResult.NowPage, 0, 0, 0)
            -- 继续等待查询返回结果
            HWstatus.AHSearch = 1
            AHSearch.SearchResult.NowRecordingPage = -1
        end
    end

end

function AHSearchItem:printOut()
    local liLoop
    for liLoop = 1, table.getn(AHSearch.SearchResult.ItemName) do
        if AHSearch.SearchResult.ItemName[liLoop] then
            print(liLoop..AHSearch.SearchResult.ItemName[liLoop].." "..AHSearch.SearchResult.ItemCount[liLoop].." "..AHSearch.SearchResult.ItemBuyout[liLoop].." "..AHSearch.SearchResult.ItemEachPrice[liLoop].." "..AHSearch.SearchResult.ItemSellerName[liLoop])
        end
    end
end

function AHSearchItem:Stop()
    AHSearchItem:CancelTimer(AHSearch.ResultHandle,true)
    HWstatus.AHSearch = 0
    --if AHSearch.printOut == 1 then
        print("共" .. table.getn(AHSearch.SearchResult.ItemName) .. "件物品")
        --AHSearchItem:printOut()
    --end

    -- 显示查询结果，只显示最低价格和上货人
    SendData(AHSearch.SearchResult.MinPriceSeller .. "#" .. AHSearch.SearchResult.MinEachPrice .. "#")
    --AHSearch.Handle = wipe(AHSearch.Handle)
end

function AHSearchItem:Fail()
    if AHSearch.ResultHandle ~= nil and AHSearch.ResultHandle ~= "" then
        AHSearchItem:CancelTimer(AHSearch.ResultHandle,true)
    end

    HWstatus.AHSearch = 0
    SendErrData("执行错误")
end

function AHSearchItem:RecordItem(aiPageCount)
    local lstrItemName, liItemCount, liBuyoutPrice, lstrSellerName
    local liLoop
    for liLoop = 1, aiPageCount do
        lstrItemName = (select(1, GetAuctionItemInfo("list", liLoop)))
        liItemCount = (select(3, GetAuctionItemInfo("list", liLoop)))
        liBuyoutPrice = (select(10, GetAuctionItemInfo("list", liLoop)))
        lstrSellerName = (select(13, GetAuctionItemInfo("list", liLoop)))
        if not lstrSellerName then
            lstrSellerName = "[无名者]"
            print(lstrSellerName)
        end
        if AHSearch.SearchItem == lstrItemName then
            AHSearch.SearchResult.count = AHSearch.SearchResult.count + 1
            AHSearch.SearchResult.ItemName[AHSearch.SearchResult.count] = lstrItemName
            AHSearch.SearchResult.ItemCount[AHSearch.SearchResult.count] = liItemCount
            AHSearch.SearchResult.ItemBuyout[AHSearch.SearchResult.count] = liBuyoutPrice
            AHSearch.SearchResult.ItemEachPrice[AHSearch.SearchResult.count] = math.ceil(liBuyoutPrice/liItemCount)
            AHSearch.SearchResult.ItemSellerName[AHSearch.SearchResult.count] = lstrSellerName
            if AHSearch.SearchResult.MinEachPrice > AHSearch.SearchResult.ItemEachPrice[AHSearch.SearchResult.count] or AHSearch.SearchResult.MinEachPrice == 0 then
                AHSearch.SearchResult.MinEachPrice = AHSearch.SearchResult.ItemEachPrice[AHSearch.SearchResult.count]
                AHSearch.SearchResult.MinPriceSeller = lstrSellerName
            end
        end
    end
end

function AHSearchItem:QueryEnd()
    if HWstatus.AHSearch ~= 1  then
        return
    end

    if AHSearch.SearchResult.NowRecordingPage == -1 then
        AHSearch.SearchResult.NowRecordingPage = AHSearch.SearchResult.NowPage
    else
        return
    end

    local liPageCount, liTotal = GetNumAuctionItems("list")
    print("liPageCount, liTotal = " .. liPageCount .. "," .. liTotal )
    if not liPageCount or liPageCount == 0 then
        -- 查询无结果
        print("查询无结果 或者 查询完毕")
        AHSearchItem:Stop()
        return
    end

    -- 看看是不是名字都有了
    for liLoop = 1, liPageCount do
        lstrSellerName = (select(13,GetAuctionItemInfo("list", liLoop)))
        if not lstrSellerName then
            -- 没出来，记录重试次数
            AHSearch.SearchResult.RetryCount = AHSearch.SearchResult.RetryCount + 1
            if AHSearch.SearchResult.RetryCount <= AHSearch.SearchResult.MAX_RETRY_COUNT then
                -- 发出同一页的再次搜索
                print("没有名字，再来一次")
                HWstatus.AHSearch = 3
                return
            end
            -- 超过次数，按照无名者记录吧
        end
    end

    -- 写入内容
    print("记录当页查询结果内容")
    AHSearchItem:RecordItem(liPageCount)
    print("本页"..AHSearch.SearchResult.NowPage.."查询完毕")

    HWstatus.AHSearch = 2
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    取消AH中小于指定价格的已经上架的物品      --------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function CancelAH(astrItemName, aiPrice)
    SendBeginData()

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
        SendErrData("MailBoxGetItemDoorNew: 没有待取货物品清单")
        return
    end

    -- 检查是否正在进行
    if MailBoxGetItemCheckNew() ~= 0 then
        NormalPrint("MailBoxGetItemDoorNew: 取货正在进行中")
        SendErrData("MailBoxGetItemDoorNew: 取货正在进行中")
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
        SendErrData("邮箱没有打开")
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
        SendErrData("邮箱没有打开")
        return
    end

    if HWstatus.MailBoxGetItemNew == 10 then
        TakeInboxItem(MailBoxGetItemNew.TblMailID[MailBoxGetItemNew.LoopCount], MailBoxGetItemNew.TblAttachID[MailBoxGetItemNew.LoopCount])
        HWstatus.MailBoxGetItemNew = 20
    end
end

function MailBoxGetItemMachineNew:Waiting()
    if HWstatus.MailBoxGetItemNew == 30 then
        if MailBoxGetItemNew.LoopCount == 1 or getFreeSlotX() <= 4 then
            NormalPrint("********** 信封取货完成 **********")
            MailBoxGetItemMachineNew:Stop()
            SendSuccData()
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
function GetMAILAsItem(astrItemName, aiCount)
    -- aiCount为堆数量
    local liInboxCount, liLoop, iLoopNext, lstrItemName, liMaxCount
    local liItemStackCount

    SendBeginData()
    if not astrItemName or astrItemName == "" then
        print("提供名称")
        SendErrData("提供名称")
        return
    end

    if not aiCount or aiCount == "" then
        print("提供数量")
        SendErrData("提供数量")
        return
    end

    if getFreeSlotX() <= 4 then
        print("背包空间少于4个，不拿东西")
        SendSuccData()
        return
    end

    -- 清空邮箱待取清单
    MailBoxGetItemNew.TblMailID = wipe(MailBoxGetItemNew.TblMailID)
    MailBoxGetItemNew.TblAttachID = wipe(MailBoxGetItemNew.TblAttachID)

    -- 在邮箱中找是否有满足条件的物品
    liItemStackCount = 0
    liInboxCount,_ = GetInboxNumItems()
    for liLoop = 1, liInboxCount do
        for iLoopNext=1, 12 do
            lstrItemName = select(1, GetInboxItem(liLoop, iLoopNext))
            if (lstrItemName) and lstrItemName == astrItemName then
                table.insert(MailBoxGetItemNew.TblMailID, liLoop)
                table.insert(MailBoxGetItemNew.TblAttachID, iLoopNext)
                liItemStackCount = liItemStackCount + 1
                if liItemStackCount == aiCount then
                    break
                end
            end
        end
        if liItemStackCount == aiCount then
            break
        end
    end

    -- 确定是否有符合条件的物品
    if table.getn(MailBoxGetItemNew.TblMailID) > 0 then
        MailBoxGetItemDoorNew()
        return
    end

    SendSuccData()

end

function GetMAILAsItemFull(astrItemName, aiCount, aiSize)
    local liInboxCount, liLoop, iLoopNext, lstrItemName, liMaxCount, liMaxStack, liNowCount
    local liItemStackCount

    SendBeginData()
    if not astrItemName or astrItemName == "" then
        print("提供名称")
        SendErrData("提供名称")
        return
    end

    if not aiCount or aiCount == "" then
        print("提供数量")
        SendErrData("提供数量")
        return
    end

    if getFreeSlotX() <= 4 then
        print("背包空间少于4个，不拿东西")
        SendSuccData()
        return
    end

    -- 清空邮箱待取清单
    MailBoxGetItemNew.TblMailID = wipe(MailBoxGetItemNew.TblMailID)
    MailBoxGetItemNew.TblAttachID = wipe(MailBoxGetItemNew.TblAttachID)

    -- 在邮箱中找是否有满足条件的物品
    liItemStackCount = 0
    liInboxCount,_ = GetInboxNumItems()
    for liLoop = 1, liInboxCount do
        for iLoopNext=1, 12 do
            lstrItemName = (select(1, GetInboxItem(liLoop, iLoopNext)))
            liNowCount = (select(3, GetInboxItem(liLoop, iLoopNext)))
            if (lstrItemName) and lstrItemName == astrItemName then
                liMaxStack = (select(8, GetItemInfo(lstrItemName)))
                --print(liMaxStack)
                if aiSize == liNowCount then
                    table.insert(MailBoxGetItemNew.TblMailID, liLoop)
                    table.insert(MailBoxGetItemNew.TblAttachID, iLoopNext)
                    liItemStackCount = liItemStackCount + 1
                    if liItemStackCount == aiCount then
                        break
                    end
                end
            end
        end
    end

    -- 确定是否有符合条件的物品
    if table.getn(MailBoxGetItemNew.TblMailID) > 0 then
        MailBoxGetItemDoorNew()
    else
        SendSuccData()
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
        SendSuccData()
        return
    end

    -- 检查是否正在进行
    if HWstatus.SendMail > 0 then
        NormalPrint("******** 邮件发送程序正在进行中 ********")
        SendErrData("邮件发送程序正在进行中")
        return
    end

    -- 进入发信状态机
    SendMailMachine:Start()
end

-- 清空邮包table
function CleanMailPackage()
    if HWstatus.SendMail > 0 then
        NormalPrint("******** 邮件发送程序正在进行中 ********")
        SendErrData("邮件发送程序正在进行中")
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
        SendErrData("用参数为空")
        return -1
    end

    -- 看看是不是已经有这个物品（靠背包和slot检查）
    for liLoop = 1, table.getn(SendMailTo.Group) do
        if SendMailTo.ItemBagID[liLoop] == aiBagID and SendMailTo.ItemSlotID[liLoop] == aiSlotID then
            NormalPrint("********** 同样的物品已经在包裹中 **********")
            SendErrData("同样的物品已经在包裹中")
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
        SendErrData("邮箱没开")
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
        SendErrData("邮箱没开")
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
        SendMailNameEditBox:SetText(lstrReceiver)
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
            SendSuccData()
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

    SendBeginData()
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

end

-- 满包才邮寄
function SendItemByNameFull(astrReceiver, astrName)
    local liBagID, liSlotID, lstrLink, lstrItemName, liMaxStack, liNowCount

    SendBeginData()
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
            liNowStack = (select(2, GetContainerItemInfo(liBagID, liSlotID)))
            if (lstrLink) then
                lstrItemName = (select(1, GetItemInfo(lstrLink)))
                liMaxStack = (select(8, GetItemInfo(lstrLink)))
                if (lstrItemName) then
                    if lstrItemName == astrName and liNowStack == liMaxStack then
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

end

-- 按照关键字邮寄蓝色珠宝加工物品
function SendBlueItemByName(astrReceiver, astrGemName)
    local liBagID, liSlotID, lstrLink, lstrItemName, liMaxStack, liNowCount

    SendBeginData()
    if astrGemName == nil then
        SendErrData("宝石名称参数为空")
        NormalPrint("********** 宝石名称参数为空 **********")
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
                    if (string.find(lstrItemName, astrGemName)) and ((select(3,GetItemInfo(lstrItemName))) == 3) then
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

    -- 发送邮件
    SendMailDoor()

end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     遍历背包，获得背包物品名称和数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function ScanBag()
    local iBag, iSlot, oItem
    local iCount
    local iLoop, iFound
    local gItemName = {}
    local gItemCount = {}

    SendBeginData()
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
                    gItemCount[iCount] = getXXcountInBag(gItemName[iCount])
                end
            end
        end
    end

    outStrings = wipe(outStrings)
    for iLoop = 1, #gItemName do
        table.insert(outStrings, gItemName[iLoop])
        table.insert(outStrings, gItemCount[iLoop])
    end
    SendSuccData()
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     获得邮箱中所包含物品名称和数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function ScanInbox()
    local liInboxCount
    local liLoop, liLoopNext, iFound, iLoop
    local lstrItemName
    local gItemName = {}
    local gItemCount = {}

    SendBeginData()
    iCount = 0
    if IsMailBoxOpen() == 0 then
        SendErrData("邮箱没有打开")
        return
    end
    liInboxCount,_ = GetInboxNumItems()
    for liLoop = 1, liInboxCount do
        for iLoopNext=1, 12 do
            lstrItemName = select(1, GetInboxItem(liLoop, iLoopNext))
            if (lstrItemName) then
                -- 看看集合里面有没有这个物品
                iFound = 0
                for iLoop = 1, iCount do
                    if (gItemName[iLoop] == lstrItemName) then
                        iFound = 1
                        gItemCount[iLoop] = gItemCount[iLoop] + (select(3, GetInboxItem(liLoop, iLoopNext)))
                        break
                    end
                end
                if (iFound == 0) then
                    iCount = iCount + 1
                    gItemName[iCount] = lstrItemName
                    gItemCount[iCount] = (select(3, GetInboxItem(liLoop, iLoopNext)))
                end

            end
        end
    end
    outStrings = wipe(outStrings)
    for iLoop = 1, #gItemName do
        table.insert(outStrings, gItemName[iLoop])
        table.insert(outStrings, gItemCount[iLoop])
    end
    SendSuccData()
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
    --print("AH Open")
end
function ahclose()
    if (HWstatus.AHBox == 1) then
        HWstatus.AHBox = 0
    end
    --print("AH Close")
end
function queryend()
    --print("Fire")
    AHSearchItem:QueryEnd()
end

function event_AH_LIST_UPDATE()
--    AHCancelMachine:CancelDone()
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
    --AHPostItem4FirstPost()
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

function SendBeginData()
    frmTest.Text:SetText("Begin")
end

function SendSuccData()
    frmTest.Text:SetText("Success")
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     获得背包中指定物品的数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function getXXcountInBag(asItemName)
    local iBag, iSlot, oItem
    local iCount

    iCount = 0
    for iBag = 0,4 do
        for iSlot = 1,GetContainerNumSlots(iBag) do
            oItem = GetContainerItemLink(iBag, iSlot)
            if (oItem) then
                if (select(1,GetItemInfo(oItem))) == asItemName then
                    iCount = iCount + (select(2, GetContainerItemInfo(iBag, iSlot)))
                end
            end
        end
    end
    return iCount
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     获得邮箱中指定物品的数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function getXXcountInMail(asItemName)
    local liMailCount, liBagCount, liInboxCount, liLoop, iLoopNext, lstrItemName 

    liMailCount = 0
    if (HWstatus.MailBox == 1) then
        liInboxCount,_ = GetInboxNumItems()
        for liLoop = 1, liInboxCount do
            for iLoopNext=1, 12 do
                lstrItemName = select(1, GetInboxItem(liLoop, iLoopNext))
                if (lstrItemName) then
                    if asItemName == lstrItemName then
                        liMailCount = liMailCount + (select(3, GetInboxItem(liLoop, iLoopNext)))
                    end
                end
            end
        end
    end
    return liMailCount
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     获取执行结果     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function SendResult(iNext)
    -- 计算长度
    local strRtv, iLoop, iCount
    local strSeprate
    
    strSeprate = "$"
    SendBeginData()
    strRtv = ""
    for iLoop = 1, #outStrings do
        strRtv = strRtv .. outStrings[iLoop] .. strSeprate
    end

    if string.len(strRtv .. TAG_NEXT_PAGE .. strSeprate) < MAX_TEXT_LENGTH then
        SendData(strRtv)
        return
    end

    strRtv = ""
    NextStr = ""
    iCount = 0
    for iLoop = 1, #outStrings do
        strRtv = strRtv .. outStrings[iLoop] .. strSeprate
        if iLoop + 1 < #outStrings then
            NextStr = outStrings[iLoop + 1] .. strSeprate
        end

        if string.len(strRtv .. NextStr) + string.len(TAG_NEXT_PAGE) > MAX_TEXT_LENGTH then
            iCount = iCount + 1

            -- 是不是需要的页号
            if iCount == iNext then
                SendData(TAG_NEXT_PAGE .. strRtv)
                return
            end

            -- 跳过前面几页，重新计算
            strRtv = ""
        end
    end
    
    -- 循环完毕，还有剩余
    if string.len(strRtv) > 0 then
        SendData(TAG_NEXT_PAGE .. strRtv)
    end
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

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     显示指定物品在邮箱和背包中的数量     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function SetDisplayItemName(name)
    SendBeginData()
    DisplayItemName = name
    SendSuccData()
end

function DispItemCount()

    if DisplayItemName == nil then
        frmDataText:SetText("")
        return
    end
    if DisplayItemName == "" then
        frmDataText:SetText("")
        return
    end
    
    liMailCount = getXXcountInMail(DisplayItemName)
    liBagCount = getXXcountInBag(DisplayItemName)
    frmDataText:SetText(liBagCount .. "$" .. liMailCount)
end


--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     商业技能中做物品     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
function TradeSkillDO(astrName)
    SendBeginData()

    local iLoop, numSkills, skillName, liFound
    liFound = 0
    numSkills = GetNumTradeSkills()
    for iLoop = 1, numSkills do
        skillName = ((select(1,GetTradeSkillInfo(iLoop))))
        if skillName == astrName then
            liFound = 1
            DoTradeSkill(iLoop)
            break
        end
    end
    if (liFound == 0) then
        SendErrData("没找到这个物品")
    else
        SendSuccData()
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------     工具小程序     ----------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- 获得物品名称
function getItemNameByID(astrItemID)
    local lstrName
    lstrName = (select(1,GetItemInfo(astrItemID)))
    return lstrName
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


--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------    拍卖场挂货功能(4.0)      ---------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
HWstatus.AHPostItem = 0                                 -- 0 闲置，10 准备发出挂货指令，20 挂货指令发出，等待结果, 30 正在挂货（这个状态通过前端宏实现）
local AHPostItem4 = {}
AHPostItem4.AH_TIME = 1                                  -- 拍卖时间（对于4.0来说是1、2、3，对于3.3来说是小时*60秒）
AHPostItem4.CUT_PRICE = 1                                -- 砍价幅度

AHPostItem4.ItemBag = 0                                  -- 待挂货物品所在包
AHPostItem4.ItemSlot = 0                                 -- 待挂货物品所在槽
AHPostItem4.ItemLeftStack = 0                            -- 剩余多少堆要挂出去

function AHPostItemDoor(astrItemName, aiSingleItemPrice, aiItemStackSize, aiItemNumStack)
    HWstatus.AHPostItem = 0
    SendBeginData()
    -- 检查参数值
    if astrItemName == nil then
        print("AHPostItem4Door： 要干什么？？说话。。")
        AHPostItem4MachineFail()
        return
    end
     if astrItemName == "" then
        AHPostItem4MachineFail()
        print("AHPostItem4Door： 要干什么？？说话。。")
        return
    end
    if aiSingleItemPrice == nil or aiSingleItemPrice == 0 then
        print("AHPostItem4Door： 参数aiSingleItemPrice=0")
        AHPostItem4MachineFail()
        return
    end
    if aiItemStackSize == nil or aiItemStackSize == 0 then
        print("AHPostItem4Door： 参数aiItemStackSize=0")
        AHPostItem4MachineFail()
        return
    end
    if aiItemNumStack == nil or aiItemNumStack == 0 then
        print("AHPostItem4Door： 参数aiItemNumStack=0")
        AHPostItem4MachineFail()
        return
    end

    -- 看看环境是不是合适
    if IsAHOpen() ~= 1 then
        print("AHPostItem4Door： AH Close")
        AHPostItem4MachineFail()
        return
    end

    -- 按照背包中物品的数量修改输入参数
    local ItemCount = getXXcountInBag(astrItemName)
    if ItemCount == 0 then
        SendSuccData()
        return
    end
    if ItemCount < aiItemStackSize * aiItemNumStack then
        aiItemNumStack = math.floor(ItemCount/aiItemStackSize)
    end
    if ItemCount < aiItemStackSize then
        aiItemNumStack = 1
        aiItemStackSize = ItemCount
    end

    -- 找到指定物品所在包、槽
    AHPostItem4.ItemBag, AHPostItem4.ItemSlot = SearchItem(astrItemName, 0)
    if AHPostItem4.ItemBag == -1 then
        AHPostItem4MachineFail()
        return
    end

    HWstatus.AHPostItem = 10
    AHPostItem4.ItemLeftStack = aiItemNumStack

    -- 做准备工作，把物品从包里面拉出来，放到拍卖框上去
    PickupContainerItem(AHPostItem4.ItemBag, AHPostItem4.ItemSlot)
    ClickAuctionSellItemButton()
    ClearCursor()
    prize = aiSingleItemPrice * aiItemStackSize - AHPostItem4.CUT_PRICE
    StartAuction(prize, prize, AHPostItem4.AH_TIME, aiItemStackSize, aiItemNumStack)
    if aiItemNumStack == 1 then
        HWstatus.AHPostItem = 0
        SendSuccData()
    end
end

function AHPostItem4NextPost()
    if HWstatus.AHPostItem == 10 then
        AHPostItem4.ItemLeftStack = AHPostItem4.ItemLeftStack - 1
        if AHPostItem4.ItemLeftStack == 0 then
            HWstatus.AHPostItem = 0
            SendSuccData()
        end
    end
end

function AHPostItem4MachineFail()
    SendErrData("失败")
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------        收全部信      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
local GetAllMailMachine = LibStub("AceAddon-3.0"):NewAddon("GetAllMail", "AceTimer-3.0")
local GetAllMail = {}
GetAllMail.LeftMail = 0
GetAllMail.Handle = ""

function GetAllMailDoor()
    SendBeginData()
    GetAllMail.LeftMail = (select(2, GetInboxNumItems()))
    print(GetAllMail.LeftMail)
    if GetAllMail.LeftMail == nil then
        GetAllMail:Stop()
        return
    end
    if GetAllMail.LeftMail == 0 then
        GetAllMail:Stop()
        return
    end
    
    GetAllMail.Handle = GetAllMailMachine:ScheduleRepeatingTimer("Run", 0.1)
end

function GetAllMailMachine:Run()
    GetAllMail:Single()
    local MailCount = 0
    MailCount = (select(2, GetInboxNumItems()))
    if (select(1, GetInboxNumItems())) then
        frmMailDataText:SetText((select(1, GetInboxNumItems())))
    end
    if MailCount <= 0 then
        GetAllMail:Stop()
    end
end

function GetAllMail:Stop()
    if GetAllMail.Handle then
        GetAllMailMachine:CancelTimer(GetAllMail.Handle, true)
    end
    SendSuccData()
end

function GetAllMail:Single()
    local liLoop, liInboxCount, lstrItemName, iLoopNext

    liInboxCount,_ = GetInboxNumItems()
    for liLoop = 1, liInboxCount do
        local sender, msgSubject, msgMoney, msgCOD, _, msgItem, _, _, msgText, _, isGM = select(3, GetInboxHeaderInfo(liLoop))
        if not((msgCOD and msgCOD > 0) or (isGM)) then
            for iLoopNext=1, 12 do
                lstrItemName = select(1, GetInboxItem(liLoop, iLoopNext))
                if (lstrItemName) then
                    TakeInboxItem(liLoop, iLoopNext)
                end
            end
            if msgMoney > 0 then
                TakeInboxMoney(liLoop)
            end
            break
        end
    end
end

--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------        珠宝加工+分解（找出来绿色的装备的名字）      ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

function FindGreenEquip(astrGemName)
    SendBeginData()

    if astrGemName == nil then
        SendErrData("物品参数为空")
        NormalPrint("********** 物品参数为空 **********")
        return
    end
    
    local bag, slot, item, itemname
    for bag = 0,4 do
        for slot = 1,GetContainerNumSlots(bag) do
            item = select(7,GetContainerItemInfo(bag,slot))
            if (item) then
                itemname = (select(1,GetItemInfo(item)))
                if (string.find(itemname, astrGemName)) then
                    if ((select(3,GetItemInfo(item))) == 2) then
                        SendData(bag .. "$" ..slot)
                        return 
                    end
                end
            end
        end
    end
    SendData("NONE")
end