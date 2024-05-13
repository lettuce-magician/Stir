local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local Symbols = require(script.Parent.Symbols)
local xtypeof = require(Util.xtypeof)
local Observer = Fusion.Observer
local Hydrate = Fusion.Hydrate

--[=[
	@within Stir
	Has some of the same logic as `If`, however it is more used
	to check if a state object has a specific value.

	```lua
	local State = Value(false)
	local CheckBox = New "TextButton" {
		[Switch(State)] = { -- Updates whenver the value `State` changes.
			[true] = { -- If true
				Text = "Activated"
			},
			[false] = { -- If false
				Text = "Deactivated"
			},
			[Default] = { -- If the state value is any other value
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
local function Switch(state:PubTypes.StateObject<any>): PubTypes.SpecialKey
	local switchKey = {}
	switchKey.type = "SpecialKey"
	switchKey.kind = "If"
	switchKey.stage = "observer"

	local function checkValues(t, apply)
		for k, v in t do
			if state:get() == k and xtypeof(k) ~= "State" then
				Hydrate (apply) (v)
				return
			end
		end

		if t[Symbols.Default] then
			Hydrate (apply) (t[Symbols.Default])
		end
	end

	function switchKey:apply(hydrate: {[any]:{[string]:any}}, applyTo: Instance, cleanupTasks: { PubTypes.Task })
		checkValues(hydrate, applyTo)

		local Destroy = Observer(state):onChange(function()
			checkValues(hydrate, applyTo)
		end)

		table.insert(cleanupTasks, Destroy)
	end

	return switchKey
end

return Switch