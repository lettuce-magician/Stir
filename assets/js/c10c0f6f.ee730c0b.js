"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[392],{91831:e=>{e.exports=JSON.parse('{"functions":[{"name":"clear","desc":"Clears the last result and all property values.\\r","params":[],"returns":[],"function_type":"method","source":{"line":30,"path":"src/Stir/Form.lua"}},{"name":"field","desc":"Creates a value bound to a field inside the Form. Can be used alongside `Out` to get user input.\\r","params":[{"name":"name","desc":"","lua_type":"string"}],"returns":[{"desc":"","lua_type":"PubTypes.Value<any>\\r\\n"}],"function_type":"method","source":{"line":37,"path":"src/Stir/Form.lua"}},{"name":"submit","desc":"Submits the form, returning the result of the submission.","params":[],"returns":[{"desc":"","lua_type":"Submission"}],"function_type":"method","source":{"line":49,"path":"src/Stir/Form.lua"}},{"name":"get","desc":"Returns the result of the last submission, submitting one if it was cleared or does not exist.","params":[],"returns":[{"desc":"","lua_type":"Submission"}],"function_type":"method","source":{"line":92,"path":"src/Stir/Form.lua"}},{"name":"onSubmit","desc":"Binds a callback for when the form is submitted, the callback will still be ran if there are\\nvalidation errors on the result. Returns a function that disconnects the callback from the\\nsignal.","params":[{"name":"fn","desc":"","lua_type":"(result:PubTypes.Submission)->()"}],"returns":[{"desc":"","lua_type":"()->()\\r\\n"}],"function_type":"method","source":{"line":106,"path":"src/Stir/Form.lua"}},{"name":"onPost","desc":"Binds a callback for when the form is posted, meaning it is completely fine\\nwith zero fatal errors from the validators. Returns a function that disconnects the callback from the\\nsignal.","params":[{"name":"fn","desc":"","lua_type":"(data:{[string]:any})->()"}],"returns":[{"desc":"","lua_type":"()->()\\r\\n"}],"function_type":"method","source":{"line":116,"path":"src/Stir/Form.lua"}},{"name":"onError","desc":"Binds a callback that runs whenever an validation error (fatal or non-fatal) on a form field\\nfails, passing the errors that the form submission had.","params":[{"name":"fn","desc":"","lua_type":"(data:{[string]:string})->()"}],"returns":[{"desc":"","lua_type":"()->()\\r\\n"}],"function_type":"method","source":{"line":125,"path":"src/Stir/Form.lua"}},{"name":"_addListener","desc":"Used internally for registering onSubmit and onError callbacks.\\r","params":[{"name":"name","desc":"","lua_type":"string"},{"name":"callback","desc":"","lua_type":"()->()"}],"returns":[],"function_type":"method","private":true,"source":{"line":132,"path":"src/Stir/Form.lua"}},{"name":"_triggerListeners","desc":"Used internally for trigerring onSubmit and onError.\\r","params":[{"name":"name","desc":"","lua_type":"string"},{"name":"...","desc":"","lua_type":"any"}],"returns":[],"function_type":"method","private":true,"source":{"line":144,"path":"src/Stir/Form.lua"}}],"properties":[],"types":[{"name":"Submission","desc":"","fields":[{"name":"id","lua_type":"string","desc":""},{"name":"valid","lua_type":"boolean","desc":""},{"name":"post","lua_type":"boolean","desc":""},{"name":"data","lua_type":"{[string]:any}","desc":""},{"name":"error","lua_type":"{[string]:string}","desc":""}],"source":{"line":27,"path":"src/Stir/Form.lua"}}],"name":"Form","desc":"A state object that helps when creating UIs that depend too much on user input.","source":{"line":15,"path":"src/Stir/Form.lua"}}')}}]);