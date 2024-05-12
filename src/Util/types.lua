local Package = script.Parent.Parent.Parent.Fusion

local Fusion = require(Package)
local PubTypes = require(Package.PubTypes)

export type Submission = {
    id: string,
    valid: boolean,
    post: boolean,
    data: {[string]:any},
    error: {[string]:any}
}
export type TypeNames = "string"|"number"|"boolean"|"Instance"|"Vector2"|"Vector3"|"UDim"|"UDim2"
export type Form = {
    clear: (self:any)->(),
    submit: (self:any)->(Submission),
    field: (self:any, name:string) -> (PubTypes.Value<any>),
    get: (self:any)->(Submission),
    onSubmit: (self:any, callback:(Submission))->(()->()),
    onPost: (self:any, callback:({[string]:any})->()) -> (()->()),
    onError: (self:any, callback:({[string]:any})->()) -> (()->()),
}

return {}