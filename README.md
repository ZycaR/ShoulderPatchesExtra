# ShoulderPatchesExtra
**ZycaR (c) 2016**

When the official shoulder patches are not enough and server administrators want to reward some players according how they behave on server the shoulder patches extra is the solution. To enable ShoulderPatchesExtra add ``"2bc45759"`` to the list of mods running on server and configure.

## Configuration guide
#### Basics

The configuration of ShoulderPatchesExtra consist of three main parts:
- **Shoulder Patches Texture** .. the image(s) containing tiled shoulder patches
- **Material File** .. the text file which tells the game where to find shoulder patches image and how many rows & columns of patch contains
- **Patches Config File** .. the json file for configuration player->patch relation.

#### Shoulder Patches Texture
*This part cannot be modified with original workshop mod, any modification will be classified as violation of consistency check. To modify this part please contact the author.*

To minimise complexity, disk space and something called *"draw calls"* (internal engine's magic) the patches are tiled in one image. It's preferred to arrange patches into square (i.e. 2x2, 4x4, ...)

> It's not restricted to arrange all patches in one big line, but you will probably suffer with poor performance ...

Patches image file: ``..\models\marine\patches\ShoulderPatchesExtra.dds``

##### Patch position and index
Patch index is position of patch on texture. Index with 0 occupied left-top corner, Index 1 is second column to right on same top-most row. This continues to bottom-right corner.
> Please always consider index 0 as no-patch position. This index is used by mode to show no patch for not configured players (without group assigned).

#### Material File
*This part cannot be modified with original workshop mod, any modification will be classified as violation of consistency check. To modify this part please contact the author.*

Next part of shoulder patches mod is material file. This text file tells engine location, where to find texture and describe tilling of patches. Describe how are patches arranged in how many rows and columns.

Material file: ``..\models\marine\patches\shoulder_patch.material``
```
...
spePatchesMap = "models/marine/patches/ShoulderPatchesExtra.dds"
speRows = 4
speCols = 16
```

#### Patches Config File
Last but not least we have config file description. After reading all those not so enjoyable previous parts (did you actually read them?). If you didn't read them properly then please do. It's highly recommended and will help to understand some sections of config file.

After first run of game with mounted mod, the default config is created:\
Config file: ``%appdata%\Natural Selection 2\ShoulderPatchesConfig.json``

The config part named **PatchGroups** contains list of "group_name" with assigned patches. You can use either "Patch" for single patch assignment or plural "Patches" to assign collection of patches to group.

PatchGroups section contains specific group **DefaultGroup** where you can specify globally available patches for everyone.

Config part **PatchUsers** is collection of user configurations. User configuration section uses SteamId as a key. User configuration can contain one "group_name" and one or more it's own patches.

The result set of patches available for specific player is aggregation of:
 - patches specified in user's configuration
 - patches from group where player is assigned assigned
 - and patches from special group "DefaultGroup".

*Example below: Player with SteamID "438225" have available these patches: "Awesome", "Moderator_1", "Moderator_2" and "Generic".*

Player with more than one patch available, can customize look in standard "Customize Player" menu.

The similar principle is applied if Server have enabled **Shine** mod. Configuration is then moved to UserConfig.json file instead of build in config file. Please note, that once a shine mod is properly configured and running on the server ShoulderPatch mod will ignore ShoulderPatchesConfig.json file.

Example of config file:
```json
{
  "PatchGroups":{
    "DefaultGroup": {
		"Patch": "Generic"
	},
    "admin_group": {
		"Patch": "Admin"
	},
    "moderators": {
		"Patches": ["Moderator_1, "Moderator_2"]
	}
  },
  "PatchUsers":{
    "90000000000001":{
		"Patches": ["noname"]
    },
    "438225": {
		"Group": "moderators",
		"Patch": "Awesome"
  }
}
```

### ShoulderPatchesExtra Mod ID - 2573eb73
```sh
Server.exe -mods "2bc45759"
```

### SteamWorkshop link
http://steamcommunity.com/sharedfiles/filedetails/?id=734287705