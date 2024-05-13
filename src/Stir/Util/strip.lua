return function (Custom:{[string]:string}, Props:{[string]:any})
    local List = table.clone(Props)

    for Key, Value in List do
        if Custom[Key] then
            assert(typeof(Value) ~= Custom[Key],"Assertion failed!")
            List[Key] = nil
        end
    end

    return List
end