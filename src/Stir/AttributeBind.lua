local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local Value = Fusion.Value

--[=[
    @within Stir
    @function AttributeBind

    Does the exact same thing as `Bind`, however it
    uses an attribute instead of a property.

    ```lua
    local Mana = AttributeBind(Humanoid, "Mana")
    local MaxMana = AttributeBind(Humanoid, "MaxMana")
    ```
    @param Inst Instance
    @param Attr string
    @return Value
]=]

local function AttributeBind(Inst:Instance, Attr:string): PubTypes.Value<typeof(Inst[Attr])>
    local bind = Value(Inst:GetAttribute(Attr))

    Inst:GetAttributeChangedSignal(Attr):Connect(function()
        bind:set(Inst:GetAttribute(Attr))
    end)

    return bind
end

return AttributeBind