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
    field: (self:any, name:string) -> (Value<any>),
    get: (self:any)->(Submission),
    onSubmit: (self:any, callback:(Submission))->(()->()),
    onPost: (self:any, callback:({[string]:any})->()) -> (()->()),
    onError: (self:any, callback:({[string]:any})->()) -> (()->()),
}

type Set<T> = {[T]: any}
export type Symbol = {
	type: string,
	name: string
}

export type Animatable =
	number |
	CFrame |
	Color3 |
	ColorSequenceKeypoint |
	DateTime |
	NumberRange |
	NumberSequenceKeypoint |
	PhysicalProperties |
	Ray |
	Rect |
	Region3 |
	Region3int16 |
	UDim |
	UDim2 |
	Vector2 |
	Vector2int16 |
	Vector3 |
	Vector3int16

export type Task =
	Instance |
	RBXScriptConnection |
	() -> () |
	{destroy: (any) -> ()} |
	{Destroy: (any) -> ()} |
	{Task}

export type Version = {
	major: number,
	minor: number,
	isRelease: boolean
}

export type Dependency = {
	dependentSet: Set<Dependent>
}

export type Dependent = {
	update: (Dependent) -> boolean,
	dependencySet: Set<Dependency>
}

export type StateObject<T> = Dependency & {
	type: string,
	kind: string,
	get: (StateObject<T>, asDependency: boolean?) -> T
}

export type CanBeState<T> = StateObject<T> | T

export type Value<T> = StateObject<T> & {
	-- kind: "State" (add this when Luau supports singleton types)
 	set: (Value<T>, newValue: any, force: boolean?) -> ()
}

export type Computed<T> = StateObject<T> & Dependent & {
	-- kind: "Computed" (add this when Luau supports singleton types)
}

export type ForPairs<KO, VO> = StateObject<{ [KO]: VO }> & Dependent & {
	-- kind: "ForPairs" (add this when Luau supports singleton types)
}

export type ForKeys<KO, V> = StateObject<{ [KO]: V }> & Dependent & {
	-- kind: "ForKeys" (add this when Luau supports singleton types)
}
export type ForValues<K, VO> = StateObject<{ [K]: VO }> & Dependent & {
	-- kind: "ForKeys" (add this when Luau supports singleton types)
}

export type Tween<T> = StateObject<T> & Dependent & {
	-- kind: "Tween" (add this when Luau supports singleton types)
}

export type Spring<T> = StateObject<T> & Dependent & {
	-- kind: "Spring" (add this when Luau supports singleton types)
	-- Uncomment when ENABLE_PARAM_SETTERS is enabled
	-- setPosition: (Spring<T>, newValue: Animatable) -> (),
	-- setVelocity: (Spring<T>, newValue: Animatable) -> (),
	-- addVelocity: (Spring<T>, deltaValue: Animatable) -> ()
}
export type Observer = Dependent & {
  	onChange: (Observer, callback: () -> ()) -> (() -> ())
}
export type SpecialKey = {
	type: string,
	kind: string,
	stage: string,
	apply: (SpecialKey, value: any, applyTo: Instance, cleanupTasks: {Task}) -> ()
}
export type Children = Instance | StateObject<Children> | {[any]: Children}
export type PropertyTable = {[string | SpecialKey]: any}

return {}