local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local xtypes = require(Util.xtypeof)
local Hydrate = Fusion.Hydrate
local Observer = Fusion.Observer

--[=[
	@within Stir
	Each is used for looping through a key/value pair table and adding children or adding specific
	properties. If the passed value is a state, then everytime the state updates, it will react
	accordingly.

	```lua
	New "Frame" {
		New "UIGridLayout" {}
		[Each(Settings)] = function(Key,Value)
			return New "TextLabel" {
				Text = Key..": "..Value
			}
		end
	}
	```

	:::warning
	`Each` uses `pairs` for looping through the table, meaning list elements will not
	appear sequencially. In that case, use `Iter` instead for lists and sequencial
	values.
	:::
]=]
local function Each(dict:PubTypes.CanBeState<{[string]:any}>): PubTypes.SpecialKey
	local eachKey = {}
	eachKey.type = "SpecialKey"
	eachKey.kind = "Each"
	eachKey.stage = "observer"

	local Assigned = {}
	local CurrentChildren = {}

	function eachKey:apply(exec: (Key:string,Value:any)->PubTypes.PropertyTable, applyTo: Instance, cleanupTasks)
		if xtypes(dict) == "State" and not table.find(Assigned,applyTo) then
			table.insert(Assigned,applyTo)
			table.insert(cleanupTasks, Observer(dict):onChange(function()
				Fusion.cleanup(CurrentChildren)
				table.clear(CurrentChildren)
				eachKey:apply(exec,applyTo)
			end))
		end

		for Key, Value in dict do
			local Result = exec(Key,Value)
			if typeof(Result) == "Instance" then
				table.insert(CurrentChildren, Result)
				Hydrate (applyTo) {
					[Fusion.Children] = Result
				}
			else
				Hydrate (applyTo) (Result)
			end
		end
    end

	return eachKey
end

return Each
