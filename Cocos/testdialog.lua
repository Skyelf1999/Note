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