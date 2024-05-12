local HttpService = game:GetService("HttpService")

local Package = script.Parent.Parent.Fusion
local Util = script.Parent.Util

local Fusion = require(Package)
local PubTypes = require(Package.PubTypes)
local types = require(Util.types)

local Value = Fusion.Value

--[=[
    @class Form
    A state object that helps when creating UIs that depend too much on user input.
]=]--
local class = {}
class.type = "State"
class.kind = "Form"
class.__index = class

--- @within Form
--- @interface Submission
--- .id string
--- .valid boolean
--- .post boolean
--- .data {[string]:any}
--- .error {[string]:string}

--- @within Form
--- Clears the last result and all property values.
function class:clear()
    self.result = nil
    self.props = {}
end

--- @within Form
--- Creates a value bound to a field inside the Form. Can be used alongside `Out` to get user input.
function class:field(name:string): PubTypes.Value<any>
    assert(self.validators[name], "No property named '"..name.."'")
    assert(self.props[name] == nil, "The property "..name.." is already in use.")

    self.props[name] = Value()

    return self.props[name]
end

--- @within Form
--- Submits the form, returning the result of the submission.
--- @return Submission
function class:submit()
    local result = {
        id = HttpService:GenerateGUID(),
        data = {},
        valid = true,
        post = true,
        errors = {},
    }

    local function canPost(toggle:boolean, why:string)
		result.post = toggle
		return toggle, (if toggle == false then why else nil)
    end

	for k, v in pairs(self.props) do
		v = v:get()
		local Validate, Error = self.validators[k](v,canPost)
        if not Validate then
            result.valid = false
            result.errors[k] = Error or true
        else
            result.data[k] = v
        end
    end

    self:_triggerListeners("submitListeners", result)

    if result.post then
        self:_triggerListeners("postListeners", result.data)
    end

    if not result.valid then
        self:_triggerListeners("errorListeners", result.errors)
    end

    self.result = result

    return result
end

--- @within Form
--- Returns the result of the last submission, submitting one if it was cleared or does not exist.
--- @return Submission
function class:get(): types.Submission
    if self.result == nil then
        self:submit()
    end

    return self.result
end

--[=[
    @within Form
    Binds a callback for when the form is submitted, the callback will still be ran if there are
    validation errors on the result. Returns a function that disconnects the callback from the
    signal.
]=]
function class:onSubmit(fn:(result:types.Submission)->()): ()->()
    return self:_addListener("submitListeners", fn)
end

--[=[
    @within Form
    Binds a callback for when the form is posted, meaning it is completely fine
    with zero fatal errors from the validators. Returns a function that disconnects the callback from the
    signal.
]=]
function class:onPost(fn:(data:{[string]:any})->()): ()->()
    return self:_addListener("postListeners", fn)
end

--[=[
    @within Form
    Binds a callback that runs whenever an validation error (fatal or non-fatal) on a form field
    fails, passing the errors that the form submission had.
]=]
function class:onError(fn:(data:{[string]:string})->()): ()->()
    return self:_addListener("errorListeners", fn)
end

--- @within Form
--- @private
--- Used internally for registering onSubmit and onError callbacks.
function class:_addListener(name:string, callback:()->())
	local UUID = HttpService:GenerateGUID()
    self[name][UUID] = callback

    return function ()
        self[name][UUID] = nil
    end
end

--- @within Form
--- @private
--- Used internally for trigerring onSubmit and onError.
function class:_triggerListeners(name:string, ...:any)
    for _, callback in self[name] do
        task.spawn(callback, ...)
    end
end

--[=[
    @within Stir
    Creates a Form object, which is used for creating stuff like login pages
    and quizes.

    The first argument is a dictionary, with Form Field names as keys, and
    their validation function as values. The validator functions gets two parameters:
    The value that was submitted and a function that decides whenver the field will
    be allowed to post. The validator function needs to return a boolean which indicates
    if there are errors on the validated value, and an error message if there is an error.

    ```lua
    local LoginPage = Form {
        Password = function(CurrentValue:string, CanPost:(boolean, string)->(boolean, string))
            return CanPost(#CurrentValue >= 8, "Password must be atleast 8 characters long!")
        end
    }

    LoginPage:onSubmit(function(result)
        print(result)
    end)

    LoginPage:onPost(function()
        print("Password posted successfully!")
    end)

    LoginPage:onError(function(errors)
        print(errors)
    end)

    New "TextBox" {
        [Out "Text"] = LoginPage:field "Password"
    }

    New "TextButton" {
        [OnEvent "Activated"] = function()
            LoginPage:submit()
        end
    }
    ```

    @return Form
]=]
local function Form(validators:{[string]:(any, (boolean)->())->(boolean)}): types.Form
   local self = setmetatable({
    props = {},
    validators = validators,
    submitListeners = {},
    errorListeners = {},
    postListeners = {}
   }, class)

   return self
end

return Form