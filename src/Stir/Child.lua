local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)

local Hydrate = Fusion.Hydrate

--[=[
	@within Stir
	@function Child

	This function is very useful when in pairs with `Hydrate`.
	What it simply does is that it hydrates the child of the
	current instance by name. If the child does not exist it
	will throw an error.

	```lua
	local Frame = New "Frame" {
		[Children] = {
			New "UIStroke" {}
		}
	}

	print(Frame.UIStroke.Color) -- 0, 0, 0

	Hydrate (Frame) {
		[Child "UIStroke"] = {
			Color = Color3.new(1,1,1)
		}
	}

	print(Frame.UIStroke.Color) -- 1, 1, 1
	```

	@param childName string
	@return SpecialKey
]=]
local function Child(childName: string): PubTypes.SpecialKey
	local childKey = {}
	childKey.type = "SpecialKey"
	childKey.kind = "Child"
	childKey.stage = "descendants"

	function childKey:apply(child: any, applyTo: Instance)
		local Inst = applyTo:FindFirstChild(childName)
        assert(Inst, "No child named "..childName)

        Hydrate (Inst) (child)
    end

	return childKey
end

return Child
