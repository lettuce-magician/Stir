local Package = script.Parent.Parent.Fusion

local Fusion = require(Package)
local PubTypes = require(Package.PubTypes)
local unwrap = require(script.Parent.Util.unwrap)

local Hydrate = Fusion.Hydrate

--[=[
    @within Stir
    This function opens another clause inside an `If` statement.
    However unlike the `If` statement, it is not reactive, and
    only updates when the value inside `If` does. However this
    still checks if the passed condition is true before hydrating
    it.

    ```lua
    local State = Value(false)
    local CheckBox = New "TextButton" {
        [If(State)] = { -- Updates whenver the value `State` changes.
            Text = "Activated",
            [ElseIf(State:get() == false)] = { -- if the state value is false
                Text = "Deactivated"
            },
            [Else] = { -- If the state value is any other value
                Text = "What the...."
            }
        },

        [OnEvent "Activated"] = function()
            if math.random(1,20) < 5 then
                State:set(nil)
            else
                State:set(not State:get())
            end
        end
    }
    ```

    @return SpecialKey
]=]
local function ElseIf(conditional: PubTypes.CanBeState<boolean>): PubTypes.SpecialKey
	local elseIfKey = {}
	elseIfKey.type = "SpecialKey"
	elseIfKey.kind = "ElseIf"
	elseIfKey.stage = "observer"
    elseIfKey.condition = conditional

    local function applyProps(apply, props)
        if unwrap(conditional) then
            Hydrate (apply) (props)
        end
    end

	function elseIfKey:internalApply(props: any, applyTo: Instance)
        applyProps(applyTo, props)
    end

    function elseIfKey:apply()
    end

	return elseIfKey
end

return ElseIf
