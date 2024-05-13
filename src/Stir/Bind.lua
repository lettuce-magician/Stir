local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local hasProp = require(script.Parent.Util.hasProp)

local Value = Fusion.Value

--[=[
    @within Stir
    @function Bind

    Binds a value to a property, and whenever the property
    updates, it also updates. Yes, `Out` exists however this
    is useful when you're just getting a property and you don't
    want to use Hydration for it, like getting Humanoid's Health.

    ```lua
    local Health = Bind(Humanoid, "Health")
    local MaxHealth = Bind(Humanoid, "MaxHealth")
    ```
    @param Inst Instance
    @param Prop string
    @return Value
]=]

local function Bind(Inst:Instance, Prop:string): PubTypes.Value<typeof(Inst[Prop])>
    assert(hasProp(Inst, Prop), "Assertion failed!")
    local bind = Value(Inst[Prop])

    Inst:GetPropertyChangedSignal(Prop):Connect(function()
        bind:set(Inst[Prop])
    end)

    return bind
end

return Bind