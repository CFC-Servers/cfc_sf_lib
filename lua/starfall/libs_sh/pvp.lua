--- PvP library for getting PvP mode and faction information.
-- @name pvp
-- @class library
-- @libtbl pvp_library
SF.RegisterLibrary( "pvp" )

return function( instance )

local pvp_library = instance.Libraries.pvp
local checktype = instance.CheckType
local player_methods = instance.Types.Player.Methods
local ply_meta, punwrap, plywrap = instance.Types.Player, instance.Types.Player.Unwrap, instance.Types.Player.Wrap
local add = SF.hookAdd

local function getPly( this )
    local ent = punwrap( this )

    if ent:IsValid() then
        return ent
    else
        SF.Throw( "Player is not valid.", 3 )
    end
end

--- Returns a table of all online players currently in Pvp mode.
-- @return Table of players in Pvp mode
function pvp_library.getPvpers()
    local pvpers = {}

    for _, ply in pairs( player.GetHumans() ) do
        if ply:IsInPvp() then
            table.insert( pvpers, plywrap( ply ) )
        end
    end

    return pvpers
end

--- Returns a table of all online players currently in Build mode.
-- @return Table of players in Build mode
function pvp_library.getBuilders()
    local builders = {}

    for _, ply in pairs( player.GetHumans() ) do
        if ply:IsInBuild() then
            table.insert( builders, plywrap( ply ) )
        end
    end

    return builders
end

-- IsInPvp
--- Returns true if the player is in Pvp mode, false otherwise.
-- @param ply Player
-- @return Boolean, is the player in Pvp mode
function pvp_library.playerIsInPvp( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):IsInPvp()
end

--- Returns true if the player is in Pvp mode, false otherwise.
-- @return Boolean, is the player in Pvp mode
function player_methods:IsInPvp()
    checktype( self, ply_meta )

    return getPly( self ):IsInPvp()
end

-- IsInBuild
--- Returns true if the player is in Build mode, false otherwise.
-- @param ply Player
-- @return Boolean, is the player in Build mode
function pvp_library.playerIsInBuild( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):IsInBuild()
end

--- Returns true if the player is in Build mode, false otherwise.
-- @return Boolean, is the player in Build mode
function player_methods:IsInBuild()
    checktype( self, ply_meta )

    return getPly( self ):IsInBuild()
end

--- Called when player enters pvp
-- @shared
-- @name playerEnterPvp
-- @class hook
-- @param Player ply Player Entering PvP
add( "CFC_PvP_PlayerEnterPvp", "playerenterpvp" )

--- Called when player exits pvp
-- @shared
-- @name playerExitPvp
-- @class hook
-- @param Player ply Player Exiting PvP
add( "CFC_PvP_PlayerExitPvp", "playerexitpvp" )
    return getPly( self ):IsInBuild()
end
