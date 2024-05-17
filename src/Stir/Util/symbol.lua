return function (Name:string)
	local proxy = {
		-- mimic a specialkey
		type = "SpecialKey",
		kind = "Symbol:"..Name,
		stage = "observer",
		apply = function() end
	}
	
    setmetatable({__tostring = function()
        return Name
	end}, proxy)
	
	table.freeze(proxy)
	
	return proxy
end