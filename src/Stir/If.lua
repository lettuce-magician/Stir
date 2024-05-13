local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local xtypeof = require(Util.xtypeof)
local Symbols = require(script.Parent.Symbols)
local unwrap = require(script.Parent.Util.unwrap)

local Observer = Fusion.Observer
local Hydrate = Fusion.Hydrate
local Else = Symbols.Else

--[=[
    @within Stir
    This functions open a conditional statement that reacts to changes of the value.
    It is commonly paired with `ElseIf` and `Else` to create a totally reactive control
    flow.

    ```lua
    local State = Value(false)
    local CheckBox = New "ImageButton" {
        [If(State)] = { -- Updates whenver the value `State` changes.
            Text = "Activated",
            [Else] = { -- If the state value is false
                Text = "Deactivated"
            }
        },

        [OnEvent "Activated"] = function()
            State:set(not State:get())
        end
    }
    ```

    @return SpecialKey
]=]
local function If(conditional: PubTypes.StateObject<boolean>): PubTypes.SpecialKey
	local ifKey = {}
	ifKey.type = "SpecialKey"
	ifKey.kind = "If"
	ifKey.stage = "observer"

    local function applyProps(apply, props)
        if conditional:get() then
            Hydrate (apply) (props)
        else
            for k, v in props do
                if xtypeof(k) ~= "SpecialKey" then continue end

                if k.kind == "ElseIf" then
                    local Result = unwrap(k.condtion)
                    if Result then
                        k:internalApply(v, apply)
                        break
                    end
                end
            end

            local ElseValue = props[Else]
            if ElseValue then
                Hydrate (apply) (ElseValue)
            end
        end
    end

	function ifKey:apply(props: any, applyTo: Instance, cleanupTasks: { PubTypes.Task })
        applyProps(applyTo, props)
        local Deconstruct = Observer(conditional):onChange(function()
            applyProps(applyTo, props)
        end)

        table.insert(cleanupTasks, Deconstruct)
    end

	return ifKey
end

return If
