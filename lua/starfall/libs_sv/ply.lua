return function( instance )


local checktype = instance.CheckType
local checkluatype = SF.CheckLuaType
local player_methods = instance.Types.Player.Methods
local weapon_methods = instance.Types.Weapon.Methods
local ply_meta, punwrap = instance.Types.Player, instance.Types.Player.Unwrap
local ang_meta, awrap, aunwrap = instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
local vec_meta, vwrap, vunwrap = instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
local wep_meta, wwrap, wunwrap = instance.Types.Weapon, instance.Types.Weapon.Wrap, instance.Types.Weapon.Unwrap
local col_meta, cwrap, cunwrap = instance.Types.Color, instance.Types.Color.Wrap, instance.Types.Color.Unwrap
local veh_meta, vehwrap, vehunwrap = instance.Types.Vehicle, instance.Types.Vehicle.Wrap, instance.Types.Vehicle.Unwrap

local function getPly( this )
    local ent = punwrap( this )

    if ent:IsValid() then
        return ent
    end

    SF.Throw( "Player is not valid.", 3 )
end

local function noAccess( message )
    return SF.Throw( message or "You don't have access to that function!" )
end

local function checkPlyCorePerms( ply )
    if not ply:IsAdmin() then return noAccess() end
end

--- Sets the health of a player.
-- @param number Health
function player_methods:setHealth( health )
    checkPlyCorePerms( instance.player )

    checkluatype( health, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetHealth( health )
end

--- Sets the maximum health of a player. (i.e. How much health a Medkit can heal you to)
-- @param number MaxHealth
function player_methods:setMaxHealth( maxHealth )
    checkPlyCorePerms( instance.player )

    checkluatype( maxHealth, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetMaxHealth( maxHealth )
end

--- Sets the suit armor of a player.
-- @param number SuitArmor
function player_methods:setArmor( armor )
    checkPlyCorePerms( instance.player )

    checkluatype( armor, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetArmor( armor )
end

--- Sets the jump power of a player. Default value is 200.
-- @param number JumpPower
function player_methods:setJumpPower( jumpPower )
    checkPlyCorePerms( instance.player )

    checkluatype( jumpPower, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetJumpPower( jumpPower )
end

--- Sets the slow walking speed of a player. This is when you're using +WALK. Default value is 100.
-- @param number WalkSpeed
function player_methods:setSlowWalkSpeed( slowWalkSpeed )
    checkPlyCorePerms( instance.player )

    checkluatype( slowWalkSpeed, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetSlowWalkSpeed( slowWalkSpeed )
end

--- Sets the regular walking speed of a player. This is when you're just holding W/A/S/D and not using +WALK. Default value is 200.
-- @param number WalkSpeed
function player_methods:setWalkSpeed( walkSpeed )
    checkPlyCorePerms( instance.player )

    checkluatype( walkSpeed, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetWalkSpeed( walkSpeed )
end

--- Sets the crouch speed multiplier of a player. This is a number from 0-1. Default is 0.3.
-- @param number Multiplier
function player_methods:setCrouchSpeedMultiplier( walkSpeed )
    checkPlyCorePerms( instance.player )

    checkluatype( walkSpeed, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetCrouchedWalkSpeed( walkSpeed )
end

--- Sets the running speed of a player. This is when you're holding SHIFT. Default value is 400.
-- @param number RunSpeed
function player_methods:setRunSpeed( runSpeed )
    checkPlyCorePerms( instance.player )

    checkluatype( runSpeed, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetRunSpeed( runSpeed )
end

--- Sets the gravity multiplier of a player. Passing 0 will reset it to its default value of 1.
-- @param number Gravity
function player_methods:setGravity( gravity )
    checkPlyCorePerms( instance.player )

    checkluatype( gravity, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetGravity( gravity )
end

--- Sets the position of a player.
-- @param vector Position
function player_methods:setPos( pos )
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    local position = vunwrap( pos )
    ply:SetPos( position )
end

--- Forces a player to enter a vehicle.
-- @param entity vehicle
function player_methods:enterVehicle( veh )
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )
    checktype( veh, veh_meta )

    local ply = getPly( self )
    if ply:InVehicle() then ply:ExitVehicle() end

    local vehicle = vehunwrap( veh )
    ply:EnterVehicle( vehicle )
end

--- Forces a player to exit their current vehicle.
function player_methods:exitVehicle()
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    if not ply:InVehicle() then return end

    ply:ExitVehicle()
end

--- Sets the player color of a player.
-- @param vector PlayerColor
function player_methods:setPlayerColor( colorV )
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    local playerColorV = vunwrap( colorV ) -- SetPlayerColor takes a vector with x,y,z being between 0-1
    ply:SetPlayerColor( playerColorV )
end

--- Sets the model of a player.
-- @param string Model
function player_methods:setPlayerModel( model )
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    if type( model ) ~= "string" then
        SF.Throw( "Model must be a string!", 2 )
    end

    local ply = getPly( self )
    ply:SetModel( model )
end

--- Sets the eye angles of a player.
-- @param angle EyeAngles
function player_methods:setEyeAngles( ang )
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    local angle = aunwrap( ang )
    ply:SetEyeAngles( angle )
end

--- Strips all ammo from a player.
function player_methods:stripAmmo()
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:StripAmmo()
end

--- Sets the ammo of the player. Ammo ID can either be a number or a string. Refer to the keys given from the Player:getAmmo() table for numeric IDs.
-- @param any AmmoID
-- @param number Amount
function player_methods:setAmmo( ammoId, amount )
    checkPlyCorePerms( instance.player )

    if type( ammoId ) ~= "string" and type( ammoId ) ~= "number" then
        SF.Throw( "Ammo ID must either be a string or a number!", 2 )
    end

    checkluatype( amount, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:SetAmmo( amount, ammoId )
end

--- Gives ammo to the player. Ammo ID can either be a number or a string. Refer to the keys given from the Player:getAmmo() table for numeric IDs.
-- @param any AmmoID
-- @param number Amount
-- @param bool HidePopup
function player_methods:giveAmmo( ammoId, amount, hidePopup )
    checkPlyCorePerms( instance.player )

    if type( ammoId ) ~= "string" and type( ammoId ) ~= "number" then
        SF.Throw( "Ammo ID must either be a string or a number!", 2 )
    end

    checkluatype( amount, TYPE_NUMBER )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:GiveAmmo( amount, ammoId, hidePopup )
end

--- Prints a message to the specified players chat.
-- @param ... printArgs Values to print. Colors before text will set the text color
function player_methods:chatPrint( ... )
    checkPlyCorePerms( instance.player )
    checktype( self, ply_meta )

    local args = {}

    for i,v in pairs( { ... } ) do
        if debug.getmetatable( v ) == col_meta then
            args[i] = cunwrap( v )
        else
            args[i] = tostring( v )
        end
    end

    local ply = getPly( self )

    net.Start( "starfall_print" )
    net.WriteBool( false )
    net.WriteUInt( #args, 32 )

    for _, v in pairs( args ) do
        net.WriteType( v )
    end

    net.Send( ply )
end

--- Respawns the player.
function player_methods:spawn()
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:Spawn()
end

--- Strips the player from all weapons.
function player_methods:stripWeapons()
    checkPlyCorePerms( instance.player )

    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:StripWeapons()
end

--- Strips a specific weapon class from the player.
-- @param string WeaponClass
function player_methods:stripWeapon( class )
    checkPlyCorePerms( instance.player )

    checkluatype( class, TYPE_STRING )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:StripWeapon( class )
end

--- Gives the player a weapon by class.
-- @param string WeaponClass
function player_methods:give( class )
    checkPlyCorePerms( instance.player )

    checkluatype( class, TYPE_STRING )
    checktype( self, ply_meta )

    local ply = getPly( self )
    ply:Give( class )
end

--- Sets how much ammo the weapon has in its primary clip. It is possible to exceed the weapon's regular max clip ammount with this function.
-- @param number Ammo
function weapon_methods:setClip1( amount )
    checkPlyCorePerms( instance.player )

    checkluatype( amount, TYPE_NUMBER )
    checktype( self, wep_meta )

    local ply = wunwrap( self )
    ply:SetClip1( amount )
end

--- Sets how much ammo the weapon has in its secondary clip.
-- @param number Ammo
function weapon_methods:setClip2( amount )
    checkPlyCorePerms( instance.player )

    checkluatype( amount, TYPE_NUMBER )
    checktype( self, wep_meta )

    local ply = wunwrap( self )
    ply:SetClip2( amount )
end

end
