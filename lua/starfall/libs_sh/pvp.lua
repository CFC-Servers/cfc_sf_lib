SF.RegisterLibrary( "pvp" )

return function( instance )

local pvp_library = instance.Libraries.pvp
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

local function isInPvp( ply )
    return getPly( ply ):GetNWBool( "CFC_PvP_Mode", false )
end

local function inFaction( ply )
    local id = ply:GetNWString( "FactionID", nil )

    if not id or id == "0" then
        return false
    end

    return true
end

--- Returns a table of all online players currently in Pvp mode.	
-- @return Table of players in Pvp mode
function pvp_library.getPvpers()
    local pvpers = {}

    for _, ply in pairs( player.GetHumans() ) do
        if ply:GetNWBool( "CFC_PvP_Mode", false ) then
            table.insert( pvpers, ply )
        end
    end

    return pvpers
end

--- Returns a table of all online players currently in Build mode.	
-- @return Table of players in Build mode
function pvp_library.getBuilders()
    local builders = {}

    for _, ply in pairs( player.GetHumans() ) do
        if not ply:GetNWBool( "CFC_PvP_Mode", false ) then
            table.insert( builders, ply )
        end
    end

    return builders
end

-- isInPvp
--- Returns true if the player is in Pvp mode, false otherwise.
-- @param ply Player
-- @return True or False
function pvp_library.playerIsInPvp( ply )
    checktype( ply, ply_meta )

    return isInPvp( ply )
end

--- Returns true if the player is in Pvp mode, false otherwise.	
-- @return True or False
function player_methods:isInPvp()
    checktype( self, ply_meta )

    return isInPvp( self )
end

-- isInBuild
--- Returns true if the player is in Build mode, false otherwise.
-- @param ply Player
-- @return True or False
function pvp_library.playerIsInBuild( ply )
    checktype( ply, ply_meta )

    return not isInPvp( ply )
end

--- Returns true if the player is in Pvp mode, false otherwise.
-- @return True or False
function player_methods:isInBuild()
    checktype( self, ply_meta )

    return not isInPvp( self )
end

-- factionID
--- Returns the player's faction ID.
-- @param ply Player
-- @return Faction ID as a string.
function pvp_library.getPlayerFactionID( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):GetNWString( "FactionID", nil )
end

--- Returns the player's faction ID.
-- @return Faction ID as a string.
function player_methods:getFactionID()
    checktype( self, ply_meta )

    return getPly( self ):GetNWString( "FactionID", nil )
end

-- factionRank
--- Returns a string of the player's faction rank.
-- @param ply Player
-- @return Faction rank as a string.
function pvp_library.getPlayerFactionRank( ply )
    checktype( ply, ply_meta )

    return getPly( ply ):GetNWString( "FactionRank", nil )
end

--- Returns a string of the player's faction rank.
-- @return Faction rank as a string.
function player_methods:getFactionRank()
    checktype( self, ply_meta )

    return getPly( self ):GetNWString( "FactionRank", nil )
end

-- isInFaction
--- Returns true if the player is in a faction, false otherwise.
-- @param ply Player
-- @return True or false
function pvp_library.isPlayerInFaction( ply )
    checktype( ply, ply_meta )

    return inFaction( getPly( ply ) )
end

--- Returns true if the player is in a faction, false otherwise.
-- @return True or false
function player_methods:isInFaction()
    checktype( self, ply_meta )

    return inFaction( getPly( self ) )
end

end
