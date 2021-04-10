return function( instance )
local game_library = instance.Libraries.game
local checktype = instance.CheckType
local player_methods = instance.Types.Player.Methods
local ply_meta, punwrap = instance.Types.Player, instance.Types.Player.Unwrap

local function getPly( this )
    local ent = punwrap( this )

    if ent:IsValid() then
        return ent
    else
        SF.Throw( "Player is not valid.", 3 )
    end
end

local memCacheTime = 0.1
local lastMemCountTime = CurTime()
local cachedMemAmount = collectgarbage( "count" )

--- Returns total kilobytes of memory currently in use by Lua.
-- @name game_library.luaMemoryUsage
-- @class function
-- @shared
-- @return number Kilobytes of memory in use.
function game_library.luaMemoryUsage()
    if CurTime() < lastMemCountTime + memCacheTime then
        return cachedMemAmount
    end

    cachedMemAmount = collectgarbage( "count" )
    return cachedMemAmount
end

--- Returns the packet loss of the player.
-- @server
-- @return number Packets lost
function player_methods:getPacketLoss()
    checktype( self, ply_meta )
    return getPly( self ):PacketLoss()
end

end
