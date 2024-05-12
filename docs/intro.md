import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Installation
The module can be used both in Studio and using a external text editor using Rojo.

<Tabs>
<TabItem value="1" label="Roblox Studio" default>

1. Go to the [Releases](https://github.com/lettuce-magician/Stir/releases) page in the github repository
2. Download the **model file** (a file ending in `.rbxm`).
3. After downloading it, drag 'n' drop it in Studio and insert the modules in anywhere you want (just make sure they are always toghter).

</TabItem>

<TabItem value="2" label="Wally (Rojo/External Editor)">

0. Install wally using `aftman`.
1. Use `wally init` on your project if you haven't yet.
2. Add this to your `wally.toml` file:
```bash
Stir = "lettuce-magician/stir@1.0.0"
```
3. Run `wally install`
4. Done! Just make sure to insert the `Packages` folder into your `project.json` file and you'll be able to use it.

</TabItem>

</Tabs>

## After Installing...
Check out these articles to get started on using Stir:
* [API Docs](/api)