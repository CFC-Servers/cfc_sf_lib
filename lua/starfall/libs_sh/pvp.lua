return function( instance )

local pvp_library = instance.Libraries.pvp
local checktype = instance.CheckType
local player_methods = instance.Types.Player.Methods
local ply_meta, punwrap = instance.Types.Player, instance.Types.Player.Unwrap

local function getply( this )
    local ent = punwrap( this )

    if ent:IsValid() then
        return ent
    else
        SF.Throw( "Player is not valid.", 3 )
    end
end

function pvp_library.getPvpers()
    local pvpers = {}

    for _, ply in pairs( player.GetHumans() ) do
        if ply:GetNWBool( "CFC_PvP_Mode", false ) then
            table.insert( pvpers, ply )
        end
    end

    return pvpers
end

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
function pvp_library.playerIsInPvp( ply )
    checktype( ply, ply_meta )

    return ply:GetNWBool( "CFC_PvP_Mode", false )
end

function player_methods:isInPvp()
    checktype( self, ply_meta )

    return self:GetNWBool( "CFC_PvP_Mode", false )
end

-- isInBuild
function pvp_library.playerIsInBuild( ply )
    checktype( ply, ply_meta )

    return not ply:GetNWBool( "CFC_PvP_Mode", false )
end

function player_methods:isInBuild()
    checktype( self, ply_meta )

    return not self:GetNWBool( "CFC_PvP_Mode", false )
end

-- factionID
function pvp_library.getFactionID( ply )
    checktype( ply, ply_meta )

    return ply:GetFactionID()
end

function player_methods:getFactionID()
    checktype( self, ply_meta )

    return self:GetFactionID()
end

-- factionRank
function pvp_library.getFactionRank( ply )
    checktype( ply, ply_meta )

    return ply:GetFactionRank()
end

function player_methods:getFactionRank()
    checktype( self, ply_meta )

    return self:GetFactionRank()
end

-- isInFaction
function pvp_library.isInFaction( ply )
    checktype( ply, ply_meta )

    return ply:IsInFaction()
end

function player_methods:isInFaction()
    checktype( self, ply_meta )

    return self:IsInFaction()
end

end
