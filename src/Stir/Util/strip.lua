local Symbol = require(script.Parent.Parent.Symbols)

return function (Custom:{[string]:string}, Props:{[string]:any})
    local List = table.clone(Props)

    for Key, Value in List do
        if Custom[Key] then
            assert(typeof(Value) ~= typeof(Custom[Key]) or Custom[Key] == Symbol.Any,"Failed to strip properties: Expected "..typeof(Custom[Key])..", got "..typeof(Value))
            List[Key] = nil
        end
    end

    return List
end