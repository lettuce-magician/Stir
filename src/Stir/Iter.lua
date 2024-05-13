local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local Hydrate = Fusion.Hydrate

--[=[
	@within Stir
	Iter has the same function as [Stir.Each], however it applies the
	values of the list sequencially, instead of randomly.

	```lua
	New "Frame" {
		New "UIGridLayout" {}
		[Iter(PlayerList)] = function(Key,Value)
			return New "TextLabel" {
				Text = Value
			}
		end
	}
	```

	:::warning
	`Iter` will not work on dicts and table keys that are not numbers. Use `Each` for this case instead.
	:::
]=]
local function Iter(list:{any}): PubTypes.SpecialKey
	local iterKey = {}
	iterKey.type = "SpecialKey"
	iterKey.kind = "Iter"
	iterKey.stage = "observer"

	function iterKey:apply(exec: (Key:string,Value:any)->PubTypes.PropertyTable, applyTo: Instance)

		for Key, Value in ipairs(list) do
			local Result = exec(Key,Value)
			if typeof(Result) == "Instance" then
				Hydrate (applyTo) {
					[Fusion.Children] = Result
				}
			else
				Hydrate (applyTo) (Result)
			end
		end

	end

	return iterKey
end

return Iter
