local Package = script.Parent.Parent.Fusion

local Fusion = require(Package)
local PubTypes = require(Package.PubTypes)

local Hydrate = Fusion.Hydrate

--[=[
    @within Stir
    A shorthand for cloning instances and hydrating them in the spot.

    ```lua
    local ToDuplicate = -- insert here some code that creates an instance --
    local AnDuplicate = Clone (ToDuplicate) {
        Parent = workspace
    }

    print(ToDuplicate == AnDuplicate) --> false
    ```
]=]
local function Clone(Inst:Instance): (Props:PubTypes.PropertyTable) ->(typeof(Inst:Clone()))
    return function (Props:PubTypes.PropertyTable)
        return Hydrate (Inst:Clone()) (Props)
    end
end

return Clone