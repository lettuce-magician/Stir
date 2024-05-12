local Package = script.Parent.Parent.Fusion

local Fusion = require(Package)
local PubTypes = require(Package.PubTypes)

local Observer = Fusion.Observer

--[=[
    @within Stir
    A shorthand for using `Observer:onChange`, can also make it so it runs the
    callback when the callback is binded.

    ```lua
    local TimesChanged = 0
    Observe(someState,function()
        TimesChanged += 1
    end, true) -- RunOnBind is true.
    print(TimesChanged) --> 1
    ```
]=]
local function Observe(State:PubTypes.StateObject<any>, Fn:()->(), RunOnBind:boolean?): ()->()
    local Destroy = Observer(State):onChange(Fn)

    if RunOnBind then
        task.spawn(Fn)
    end

    return Destroy
end

return Observe