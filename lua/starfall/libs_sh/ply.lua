return function( instance )


local checktype = instance.CheckType
local player_methods = instance.Types.Player.Methods
local weapon_methods = instance.Types.Weapon.Methods
local ply_meta, punwrap = instance.Types.Player, instance.Types.Player.Unwrap
local builtins_library = instance.env


local function getPly( this )
    local ent = punwrap( this )
    
    if ent:IsValid() then
        return ent
    end
    
    SF.Throw( "Player is not valid.", 3 )
end


local function canUsePlyCore( ply )
    return ply:IsAdmin()
end


--- Gets the slow walking speed of a player. This is when you're using +WALK.
-- @return Slow-walk speed of the player
function player_methods:getSlowWalkSpeed()
    checktype( self, ply_meta )
    local ply = getPly( self )
    
    return ply:GetSlowWalkSpeed()
end


--- Gets the regular walking speed of a player. This is when you're just holding W/A/S/D and not using +WALK.
-- @return Walk speed of the player
function player_methods:getWalkSpeed()
    checktype( self, ply_meta )
    local ply = getPly( self )
    
    return ply:GetWalkSpeed()
end


--- Gets the regular crouched walking speed of a player. This is a multiplier from 0-1.
-- @return Crouched walk speed multiplier of the player
function player_methods:getCrouchSpeedMultiplier()
    checktype( self, ply_meta )
    local ply = getPly( self )
    
    return ply:GetCrouchedWalkSpeed()
end


--- Gets the gravity multiplier of a player.
-- @return Gravity of the player
function player_methods:getGravity()
    checktype( self, ply_meta )
    local ply = getPly( self )
    
    return ply:GetGravity()
end


--- Gets the ammo table of a specific player, displaying all their ammo they currently have. Similar to Player:getAmmoCount(), but returns a table of all their ammo instead of just one.
-- @return A table containing all the player's ammo
function player_methods:getAmmo()
    checktype( self, ply_meta )
    local ply = getPly( self )
    
    return ply:GetAmmo()
end


--- Gets the name (string ID) of an ammo, given an ID. Refer to the keys given from the Player:getAmmo() table for numeric IDs.
-- @param number ID
-- @return The name of the given ammo ID
function builtins_library.getAmmoName( id )
    return game.GetAmmoName( id ) 
end


--- Gets the ID (numerical ID) of an ammo, given its name. Inverse of getAmmoName(id)
-- @param string Name
-- @return The ID of the given ammo name
function builtins_library.getAmmoID( name )
    return game.GetAmmoID( name )
end

--- Prints coloured/multicoloured text to any client with permission.
function builtins_library.fPrint( cColour, cText )
    chat.AddText( cColour, cText ) -- I'm pretty sure that this will print to the client that runs the starfall, not exactly sure how to fix this so please let me know if you have an idea!
end
end
