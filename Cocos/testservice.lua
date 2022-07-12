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

