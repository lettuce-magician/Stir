local function hasProp(Inst:Instance, Name:string)
    local Ok, Res = pcall(function()
        return Inst[Name]
    end)

	if not Ok then
		Res = false
	end

    return Res
end

return hasProp