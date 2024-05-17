local Fusion = require(script.Parent.Parent.Fusion)
local Hydrate = Fusion.Hydrate
--local types = require(script.Parent.Util.types)

local strip = require(script.Parent.Util.strip)

--[=[
    @within Stir
    @function Template

    Templates are like Components, except they accept
    any instance property + custom properties that are handled
    inside of itself. This is quite useful when
    creating a base for different components that have
    a similar structure.

    `Custom` have the same structure as `Allowed` in *Components*,
    same thing for `Callback`

    ```lua
    local BaseButton = Template({Type="string"}, function(Props)
        return New (Props.Type.."Button") {}
    end)

    local Image = BaseButton {Type="Image"}
    local Text = BaseButton {Type="Text"}

    print(Image.ClassName) --> ImageButton
    print(Text.ClassName)  --> TextButton
    ```

    @param Custom {[string]: TypeNames}
    @param Callback (Props: PropertyTable) -> (T)
    @return function
]=]
local Template = function<T,I>(Custom:T, Callback:(Props:T)->(any))
    return function (Props:T)
        return Hydrate (Callback(Props::any)) (strip(Custom::any,Props::any))
    end
end

return Template