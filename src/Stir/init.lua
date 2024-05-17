local Fusion = require(script.Parent.Fusion)
local unwrap = require(script.Util.unwrap)

local Computed = Fusion.Computed

local function MakeCondition(fn)
    return function (v1,v2)
        return Computed(function()
            return fn(v1,v2) == true
        end)
    end
end

local Symbols = require(script.Symbols)

--- @class Stir
--- The base table for every utilty.
local Stir =  {
    Component = require(script.Component),
    Template = require(script.Template),
    Child = require(script.Child),
    unwrap = require(script.Util.unwrap),
    Switch = require(script.Switch),
    Bind = require(script.Bind),
    AttributeBind = require(script.AttributeBind),
    If = require(script.If),
    ElseIf = require(script.ElseIf),
	Else = Symbols.Else,
	Each = require(script.Each),
	Iter = require(script.Iter),
    Form = require(script.Form),
    Clone = require(script:FindFirstChild("Clone")),
    Observe = require(script.Observe),
    Default = Symbols.Default,
    Any = Symbols.Any,

    Conditions = {
        Equals = MakeCondition(function(v1,v2)
            return unwrap(v1) == unwrap(v2)
        end),
        NotEquals = MakeCondition(function(v1,v2)
            return unwrap(v1) ~= unwrap(v2)
        end),
        Greater = MakeCondition(function(v1,v2)
            return unwrap(v1) > unwrap(v2)
        end),
        Lesser = MakeCondition(function(v1,v2)
            return unwrap(v1) < unwrap(v2)
        end),
        GreaterEquals = MakeCondition(function(v1,v2)
            return unwrap(v1) >= unwrap(v2)
        end),
        LesserEquals = MakeCondition(function(v1,v2)
            return unwrap(v1) <= unwrap(v2)
        end),
    }
}

--- @within Stir
--- @type Symbol userdata
--- Symbols like `Default` and `Else` are used for some special table keys

--[=[
    @within Stir
    @prop Conditions {Equals: (v1:StateObject,v2:StateObject)->(Computed),NotEquals: (v1:StateObject,v2:StateObject)->(Computed),Greater: (v1:StateObject,v2:StateObject)->(Computed),Lesser: (v1:StateObject,v2:StateObject)->(Computed),GreaterEquals: (v1:StateObject,v2:StateObject)->(Computed),LesserEquals: (v1:StateObject,v2:StateObject)->(Computed)}
    A few presets computed presets that can be used inside the `If` specialkey.
]=]

--[=[
    @within Stir
    @prop Default Symbol
    Used inside `Switch` blocks, it will apply the properties it's passed as long as all
    the other cases inside the block fails.
]=]

--[=[
    @within Stir
    @prop Else Symbol
    Used inside `If` blocks, self-explinatory.
]=]

--[=[
    @within Stir
    @prop Any Symbol
    Used inside [Stir.Component] and [Stir.Template] for setting a value that can receive any type.
]=]

return Stir