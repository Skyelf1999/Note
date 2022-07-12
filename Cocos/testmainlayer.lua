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