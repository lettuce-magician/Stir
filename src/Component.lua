local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Util.types)
local Hydrate = Fusion.Hydrate
local xtypeof = require(Package.Utility.xtypeof)
local hasProp = require(Util.hasProp)

--[=[
    @function Component
    @within Stir

    Creates a component, which is essentially a piece of a UI Element
    inside a function that can be built by calling it with the specified
    arguments, however, this makes it easier to apply validation.

    `Allowed` params indicates the properties that are inside that component,
    the structure of the table should be the property name as key and their
    type in the form of a string as value. If the table includes a property
    of the instance that the component returns, it will automatically hydrate
    it (*this does not apply to events*), to allow the parameter to get any type,
    set it to "any".

    `Callback` is the callback that returns the component itself, it receives
    all the allowed properties, incluinding instance properties.
    ```lua
    local Button = Component({Text="string", Activated="function"}, function(Props)
        return New "TextButton" {
            [OnEvent "Activated"] = Props.Activated
        }
    end)

    local Test = Button {
        Text = "Hello World!",
        Activated = function()
            print("Clicked!")
        end
    }

    print(Test.Text) --> Hello World!
    ```
    :::info
    Just reinforcing: this is almost no different from simply creating a function
    and returning an instance created by Fusion, this just adds
    type validation and auto-hydration.
    :::

    @param Allowed {[string]: TypeNames}
    @param Callback (Props: PropertyTable) -> (T)}
    @return (Props: PropertyTable)->(T)
]=]
local Component = function<T>(Allowed:{[string]:PubTypes.TypeNames}, Callback:(Props:{[string]:any})->(T))
    return function (Props:{[string]:any})
        for k, v in Props do
			assert(xtypeof(k) == "string", "Cannot have symbols or other types than string as keys.")
            assert(Allowed[k], "Property does not exist: "..k)
			assert(xtypeof(v) == Allowed[k] or Allowed[k] == "any", "Incorrect property type for '"..k.."': Expected "..tostring(Allowed[k])..", got "..typeof(v))
        end

        local Inst = Callback(Props)

        local ToHydrate = {}
        for k, v in Props do
            if hasProp(Inst, k) then
                ToHydrate[k] = v
            end
        end

        return Hydrate (Inst) (ToHydrate)
    end
end

return Component