# 项目插件

### FileHeader

##### New File

> 创建带有默认信息的 **xxx.lua** 文件

```lua
-- @Author: dsh
-- @Date:   2022-07-01 15:44:49
-- @Last Modified by:   dsh
-- @Last Modified time: 2022-07-01 15:44:49
-- @File Name: script/ui/test/xxx.lua
-- @Purpose: 

module("xxx",package.seeall)
```

##### Add Header

> 为指定的文件添加以上默认信息
>
> 在文件中使用自动以该文件为目标



### SGFileHelp

##### New Layer

> Layer模板

```lua
-- @Author: king
-- @Date:   2022-06-28 16:30:45
-- @Last Modified by:   king
-- @Last Modified time: 2022-07-01 15:59:14
-- @File Name: script/ui/test/layerName.lua
-- @Purpose: 

-- 更改所有匹配项：layerName

module ("layerName", package.seeall)

local _bgLayer = nil
local _touchPriority = nil
local _zOrder = nil
local _closeButton = nil
local _bgImg = nil
--/**
-- * init Module
-- */
function init()
	_bgLayer = nil
	_touchPriority = nil
	_zOrder = nil
	_closeButton = nil
	_bgImg = nil
end

-- /**
--  * init widget
--  * @return {void}
--  */
function initWidget()
	_closeButton = _bgLayer:getWidget("backBtn")
	_bgImg = _bgLayer:getWidget("bgImg")
end

--/**
-- * Show Layer
-- */
function showLayer( pTouchPriority, pZorder )
    local layer = layerName.createLayer(pTouchPriority, pZorder)
    MainScene.changeLayer(layer, "layerName")
end

--/**
-- * create Layer
-- */
function createLayer(pTouchPriority, pZorder)
	init()
	_touchPriority = pTouchPriority or -100
	_zOrder = pZorder or 1
	MainScene.setMainSceneViewsVisible(false, false, false)
	_bgLayer = CSLayer:create("ui/xxx/xxx.lua", _touchPriority)
	_bgLayer:setBgWidget("bgImg")
	initWidget()
	addWightEvent()
	localized()
	_bgLayer:registerScriptHandler(onLayerEvent)
	return _bgLayer
end

-- /**
--  * localized widget
--  * @return {void}
--  */
function localized()
	_bgLayer:getWidget("xxxx"):setString(GetLocalizeStringBy("xxxx"))
end

-- /**
--  * _bgLayer node event
--  * @param  {number} pEventType
--  * @return {void}
--  */
function onLayerEvent(pEventType )
	if pEventType == "exit" then

	elseif pEventType == "enter" then

	end
end

-- /**
--  * add widget event
--  */
function addWightEvent()
	_closeButton:registerTapAction(closeButtonAction)
end

--/**
-- * close button event
-- * @param  {number}
-- * @param  {CCMenuItem}
-- */
function closeButtonAction(pButton)
	--back main view ,you can change you layer
	require "script/ui/main/MainBaseLayer"
	local main_base_layer = MainBaseLayer.create()
	MainScene.changeLayer(main_base_layer, "main_base_layer",MainBaseLayer.exit)
	MainScene.setMainSceneViewsVisible(true,true,true)
end
```



##### New Service

> Service模板

```lua
-- @Author: king
-- @Date:   2022-06-28 16:34:54
-- @Last Modified by:   king
-- @Last Modified time: 2022-07-01 15:59:01
-- @File Name: script/ui/test/serviceName.lua
-- @Purpose: 

-- 更改所有匹配项：serviceName

module("serviceName", package.seeall)

--/**
-- * please put php interface doc
-- */
function getInfo( pCallback )
	local requestFunc = function(cbFlag,dictData,bRet)
		if dictData.err == "ok" then
			if pCallback ~= nil then
				pCallback(dictData.ret)
			end
		end
	end
	Network.rpc(requestFunc,"XXXX.getInfo","XXXX.getInfo",nil,true)
end

function ( pArg1, pCallback)
	local requestFunc = function( cbFlag, dictData, bRet )
		if bRet == true then
			if pCallback then
				pCallback(dictData.ret)
			end
		end
	end
	local args = Network.argsHandlerOfTable({pArg1})
	Network.rpc(requestFunc, "", "", args, true)
end
```



##### New Dialog

> Dialog模板

```lua
-- @Author: king
-- @Date:   2022-06-28 16:35:20
-- @Last Modified by:   king
-- @Last Modified time: 2022-06-28 16:35:20
-- @File Name: script/ui/test/dialogName.lua
-- @Purpose: 

-- 更改所有匹配项：dialogName

module("dialogName", package.seeall)

local _bgLayer = nil
local _touchPriority = nil
local _zOrder = nil

--/**
-- * init Module
-- */
function init()
	_bgLayer = nil
end

--/**
-- * Show Layer
-- */
function showLayer( pTouchPriority, pZorder )
    local scene = CCDirector:sharedDirector():getRunningScene()
    local layer = createLayer(pTouchPriority, pZorder)
    scene:addChild(layer,pZorder)
end

--/**
-- * create Layer
-- */
function createLayer(pTouchPriority, pZorder)
	init()
	
	_touchPriority = pTouchPriority or -100
	_zOrder = pZorder or 1

	--background layer
	_bgLayer = CCLayerColor:create(ccc4(11,11,11,166))
    _bgLayer:setTouchEnabled(true)
    _bgLayer:registerScriptTouchHandler(cardLayerTouch,false,_touchPriority-10,true)
    m_layerSize = CCSizeMake(580, 650)
	bgSprite = CCScale9Sprite:create(CCRectMake(100, 80, 10, 20),"images/common/viewbg1.png")
    bgSprite:setContentSize(m_layerSize)
    bgSprite:setAnchorPoint(ccp(0.5,0.5))
    bgSprite:setPosition(ccps(0.5,0.5))
    _bgLayer:addChild(bgSprite)
    setAdaptNode(bgSprite)
    
    --title
    local titlePanel = CCSprite:create("images/common/viewtitle1.png")
	titlePanel:setAnchorPoint(ccp(0.5, 0.5))
	titlePanel:setPosition(bgSprite:getContentSize().width/2, bgSprite:getContentSize().height - 7 )
	bgSprite:addChild(titlePanel)

	local titleLabel = CCRenderLabel:create(GetLocalizeStringBy("key_3087"), g_sFontPangWa, 35, 1, ccc3(0,0,0))
	titleLabel:setColor(ccc3(0xff, 0xe4, 0x00))
	titleLabel:setAnchorPoint(ccp(0.5, 0.5))
	titleLabel:setPosition(ccpsprite(0.5 , 0.5, titlePanel))
	titlePanel:addChild(titleLabel)

	--insert you code
    
    -- close button
    local menuBar = CCMenu:create()
    menuBar:setPosition(ccp(0,0))
    menuBar:setTouchPriority(_touchPriority-10)
    bgSprite:addChild(menuBar)

    local closeBtn = LuaMenuItem.createItemImage("images/common/btn_close_n.png", "images/common/btn_close_h.png" )
	closeBtn:setAnchorPoint(ccp(1, 1))
    closeBtn:setPosition(ccp(m_layerSize.width*1.02, m_layerSize.height*1.02))
	menuBar:addChild(closeBtn)
	closeBtn:registerScriptTapHandler(closeButtonAction)
	return _bgLayer
end


--/**
-- * close button event
-- * @param  {number}
-- * @param  {CCMenuItem}
-- */
function closeButtonAction(pTag, pSender)
	_bgLayer:removeFromParentAndCleanup(true)
    AudioUtil.playEffect("audio/effect/guanbi.mp3")
end
```

##### Add Header

> 与 **FileHeader-Add Header** 功能相同







# 项目标准

### 常用方法

##### printR("xxx")



### 命名方式

### 

































