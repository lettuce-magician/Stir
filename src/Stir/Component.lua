--!nonstrict

local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
--local PubTypes = require(Util.types)
local Hydrate = Fusion.Hydrate
local Symbol = require(script.Parent.Symbols)
local xtypeof = require(Util.xtypeof)
local hasProp = require(Util.hasProp)

--[=[
    @function Component
    @within Stir

    Creates a component, which is essentially a piece of a UI Element
    inside a function that can be built by calling it with the specified
    arguments, however, this makes it easier to apply validation.

    `Allowed` params indicates the properties that are inside that component,
    the structure of the table should be the property name as key and default
    value/type (defining the value will auto-select its type). 
    If the table includes a property of the instance that the component returns, 
    it will automatically hydrate it (*this does not apply to events*). To allow
    the parameter to accept any type, set it to [Stir.Any].

    `Callback` is the callback that returns the component itself, it receives
    all the allowed properties, incluinding instance properties, alongside their 
    typings for autocompleting.

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
    typings, validation and auto-hydration.
    :::

    @param Allowed {[string]: TypeNames}
    @param Callback (Props: PropertyTable) -> (T)}
    @return (Props: PropertyTable)->(T)
]=]

local function Component<T>(Allowed:T, Callback:(Props:T)->(any)):(Props:T)->(any)
    return function (Props:T)
        for k, v in Props :: any do
			assert(xtypeof(k) == "string", "Cannot have symbols or other types than string as keys.")
            assert((Allowed::any)[k], "Property does not exist: "..k)
			assert(xtypeof(v) == xtypeof((Allowed::any)[k]) or (Allowed::any)[k] == Symbol.Any, "Incorrect property type for '"..k.."': Expected "..tostring((Allowed::any)[k])..", got "..typeof(v))
        end

        local Inst = Callback(Props)

        local ToHydrate = {}
        for k, v in Props::any do
            if hasProp(Inst, k) then
                ToHydrate[k] = v
            end
        end

        return Hydrate (Inst) (ToHydrate)
    end
end

return Component