local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local Observer = Fusion.Observer
local PubTypes = require(Util.types)

--- @class Rollback
--- Rollback is a very useful class when it comes to debugging,
--- it logs everytime an state object changes it's value, alongside
--- providing the time metrics.

--[=[
	@within Rollback
	@interface RollbackLog
	.Value any
	.Time number
	.Tick number

	A table that is returned by [Rollback:get].
	`Value` is obviously the value that was registered at that time.
	`Time` is the time in seconds of when the log was registered relative to the time the Rollback object was created.
	`Tick` is the *absolute* time of when the log was registered in Unix Epoch.
]=]

local class = {}
class.type = "State"
class.kind = "Rollback"
class.__index = class

--- @within Rollback
--- Clears all the logs while updating to get a new log as a starting point.
function class:clear()
	table.clear(self.Register)
	self.Current = 0
	self:update(self.State:get())
end

--- @within Rollback
--- Tries to append a new log in the rollback and uses it as it's new 
--- value.
--- If the current value of the state object has the same
--- value as the last log, it will simply not append it 
--- (except when `force` is true).
function class:update(Val:any,force:boolean)
	if self.Register[#self.Register].Value == Val and not force then return end

	table.insert(self.Register, {
		Value = Val,
		Time = os.time()-self.BaseTime,
		Tick = tick()
	})
end

--- @within Rollback
--- Returns a log by index in the rollback.
--- If `index` is not passed then it will return
--- the last value that was registered.
function class:get(index:number)
	return self.Register[index or #self.Register]
end

--- @within Rollback
--- Returns all the logs registered in the Rollback.
function class:list()
	return self.Register
end

--- @within Rollback
--- Returns the total number of logs inside the Rollback.
function class:count()
	return #self.Register
end

--[=[ 
	@within Stir
	Creates a [Rollback] object, which captures whenever a state changes
	and logs it's value inside.

	```lua
	local Number = Value(0)
	local Roll = Rollback(Number)

	while task.wait(1) do
		Number:set(Number:get()+1)
		print(Roll:get(), Roll:get(Roll:count()-1))
	end
	```
]=]
local function Rollback<T>(State:PubTypes.StateObject<T>)
	local self = setmetatable({
		Register = {},
		State = State,
		BaseTime = os.time(),
	}, class)

	Observer(State):onChange(function()
		self:update(State:get())
	end)

	self:update(State:get())

	return self
end

return Rollback