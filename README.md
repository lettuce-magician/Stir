<div align="center">

<img src="Stir.svg" width=100px height=100px/>

# Stir
A collection of Fusion States and Utilities that improve the developer experience.
<h3><a href="https://lettuce-magician.github.io/Stir/"><u>View docs →</u></a></h3>

---

### Code Snippets

</div>

**Components**
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
**Reactive Statements**
```lua
local State = Value(false)
local CheckBox = New "ImageButton" {
    [If(State)] = { -- Updates whenver the value `State` changes.
        Text = "Activated",
        [Else] = { -- If the state value is false
            Text = "Deactivated"
        }
    },
    [OnEvent "Activated"] = function()
        State:set(not State:get())
    end
}
```
**Child Hydration**
```lua
local Frame = New "Frame" {
	[Children] = {
		New "UIStroke" {}
	}
}

print(Frame.UIStroke.Color) --> 0, 0, 0

Hydrate (Frame) {
	[Child "UIStroke"] = {
		Color = Color3.new(1,1,1)
	}
}

print(Frame.UIStroke.Color) --> 1, 1, 1
```

## Notices
- Pull Requests and Issues are welcome! I read all of them.
