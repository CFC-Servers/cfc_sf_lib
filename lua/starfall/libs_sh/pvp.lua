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
        if ply:isInPvp() then
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
        if ply:isInBuild() then
            table.insert( builders, plywrap( ply ) )
        end
    end

    return builders
end

-- isInPvp
--- Returns true if the player is in Pvp mode, false otherwise.
-- @param ply Player
-- @return Boolean, is the player in Pvp mode
function pvp_library.playerIsInPvp( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):isInPvp()
end

--- Returns true if the player is in Pvp mode, false otherwise.	=
-- @return Boolean, is the player in Pvp mode
function player_methods:isInPvp()
    checktype( self, ply_meta )

    return getPly( self ):isInPvp()
end

-- isInBuild
--- Returns true if the player is in Build mode, false otherwise.
-- @param ply Player
-- @return Boolean, is the player in Build mode
function pvp_library.playerIsInBuild( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):isInBuild()
end

--- Returns true if the player is in Build mode, false otherwise.
-- @return Boolean, is the player in Build mode
function player_methods:isInBuild()
    checktype( self, ply_meta )

    return getPly( self ):isInBuild()
end

--CFC_PvP_PlayerEnterPvp
-- @name CFC_PvP_PlayerEnterPvp
-- @class hook
-- @shared
-- @param Player ply Player Entering PvP
add( "CFC_PvP_PlayerEnterPvp" )

--CFC_PvP_PlayerExitPvp
-- @name CFC_PvP_PlayerExitPvp
-- @class hook
-- @shared
-- @param Player ply Player Exiting PvP
add( "CFC_PvP_PlayerExitPvp" )

end
