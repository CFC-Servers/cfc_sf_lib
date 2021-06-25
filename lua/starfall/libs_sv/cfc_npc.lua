return function( instance )

local checktype = instance.CheckType
local checkluatype = SF.CheckLuaType
local npc_methods, npc_meta, nwrap, nunwrap = instance.Types.Npc.Methods, instance.Types.Npc, instance.Types.Npc.Wrap, instance.Types.Npc.Unwrap
local ent_methods, ent_meta, ewrap, eunwrap = instance.Types.Entity.Methods, instance.Types.Entity, instance.Types.Entity.Wrap, instance.Types.Entity.Unwrap

local function canUseNPCCore( ply )
    return ply:IsAdmin()
end

local function getNPC( self )
    local ent = nunwrap( self )
    if ent:IsValid() then return ent end

    SF.Throw( "Entity is not valid.", 3 )
end

local function getEntity( self )
    local ent = eunwrap( self )
    if ent:IsValid() then return ent end

    SF.Throw( "Entity is not valid.", 3 )
end

local function checkAccess( ply )
    if not canUseNPCCore( ply ) then SF.Throw( "You must be an admin to use this function!", 2 ) end
end


--- Sets the scale of an NPC.
-- @param number Scale - The new scale for the NPC
-- @param number Time - Optional, the time it takes for the NPC to reach its new size
function npc_methods:setScale( scale, time )
    checkAccess( instance.player )

    local npc = getNPC( self )

    checkluatype( scale, TYPE_NUMBER )
    if time then checkluatype( time, TYPE_NUMBER ) end
    checktype( self, npc_meta )

    npc:SetModelScale( scale, time )
end

--- Gets the scale of an NPC.
-- @return number Scale - The NPC's scale
function npc_methods:getScale()
    local npc = getNPC( self )
    return npc:GetModelScale()
end

--- Sets the health of an NPC.
-- @param number Health - The new health for the NPC
function npc_methods:setHealth( health )
    checkAccess( instance.player )

    local npc = getNPC( self )

    checkluatype( health, TYPE_NUMBER )
    checktype( self, npc_meta )

    npc:SetHealth( health )
end

--- Sets the max health of an NPC.
-- @param number MaxHealth - The new max health for the NPC
function npc_methods:setMaxHealth( maxHealth )
    checkAccess( instance.player )

    local npc = getNPC( self )

    checkluatype( maxHealth, TYPE_NUMBER )
    checktype( self, npc_meta )

    npc:SetMaxHealth( maxHealth )
end

--- Sets the damage multiplier of an NPC.
-- @param number Multiplier - The new damage multiplier for the NPC
function npc_methods:setDamageMultiplier( multiplier )
    checkAccess( instance.player )

    local npc = getNPC( self )

    checkluatype( multiplier, TYPE_NUMBER )
    checktype( self, npc_meta )

    npc.cfcE2LibNpcDamageMultiplier = multiplier
end

--- Gets the damage multiplier of an NPC.
-- @return number Multiplier - The NPC's damage multiplier
function npc_methods:getDamageMultiplier()
    local npc = getNPC( self )
    checktype( self, npc_meta )

    return npc.cfcE2LibNpcDamageMultiplier or 1
end

--- Sets the mapping name of an entity. Useful for things like NPC:fireInput().
-- @param string MappingName - The entity's mapping name
function ent_methods:setMappingName( name )
    checkAccess( instance.player )

    local ent = getEntity( self )

    checkluatype( name, TYPE_STRING )
    checktype( self, ent_meta )

    ent:SetName( name )
end

--- Returns the mapping name of an entity.
-- @return string MappingName - The entity's mapping name
function ent_methods:getMappingName()
    local ent = getEntity( self )
    checktype( self, ent_meta )

    return ent:GetName()
end

--- Fires an input on an NPC. More information on these can be found here: https://developer.valvesoftware.com/wiki/Inputs_and_Outputs, and the NPC's inputs can usually be found on its Valve Developer Wiki page.
-- @param string Input - Input name
-- @param any Param - Optional, parameter to pass with the input. Can be a string, bool, or number
-- @param number Delay - Optional, the delay before the input is fired
function npc_methods:fireInput( input, param, delay )
    checkAccess( instance.player )

    checkluatype( input, TYPE_STRING )
    if delay then checkluatype( delay, TYPE_NUMBER ) end

    local npc = getNPC( self )
    checktype( self, npc_meta )

    npc:Fire( input, param, delay )
end

--- Sets a global squad on an NPC. NPCs in squads will stick together and help eachother out.
-- @param string SquadName - The name of the NPC's squad
function npc_methods:setGlobalSquad( squadName )
    checkAccess( instance.player )

    checkluatype( squadName, TYPE_STRING )

    local npc = getNPC( self )
    checktype( self, npc_meta )

    npc:SetKeyValue( "squadname", squadName )
end

--- Gets the global squad name of an NPC.
-- @return string SquadName - The name of the NPC's squad
function npc_methods:getGlobalSquad()
    local npc = getNPC( self )
    checktype( self, npc_meta )

    return npc:GetKeyValues().squadname
end

--- Sets the weapon proficiency of an NPC. Must be a number from 0 to 4.
-- @param number WeaponProficiency - The weapon proficiency of an NPC, must be in a range of 0 to 4, inclusive.
function npc_methods:setWeaponProficiency( weaponProficiency )
    checkAccess( instance.player )

    checkluatype( weaponProficiency, TYPE_NUMBER )

    local npc = getNPC( self )
    checktype( self, npc_meta )

    npc:SetCurrentWeaponProficiency( math.Clamp(weaponProficiency, 0, 4) )
end

--- Gets the global squad name of an NPC.
-- @return number WeaponProficiency - The weapon proficiency of an NPC, from 0 to 4.
function npc_methods:getWeaponProficiency()
    local npc = getNPC( self )
    checktype( self, npc_meta )

    return npc:GetCurrentWeaponProficiency()
end

end
