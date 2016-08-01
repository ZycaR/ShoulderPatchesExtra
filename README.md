# ShoulderBadgesExtra
**ZycaR (c) 2016**

When the official shoulder badges are not enough and server adminstrators want to reward some players according how they behave on server the shoulder badges extra is the solution. To enable ShoulderBadgesExtra add ``"2bc45759"`` to the list of mods running on server and configure.

Beautiful part is, that it will not override official badge player choose to wear on his shoulder.
## Configuration guide
#### Basics

The configuration of ShoulderBadgesExtra consist of three main parts:
- **Shoulder Badges Texture** .. the image(s) containing tiled shoulder badges
- **Material File** .. the text file which tells the game where to find shoulder badges image and how many rows & columns of badge contains
- **Badges Config File** .. the json file for configuration player->badge relation.

#### Shoulder Badges Texture
*This part cannot be modified with original workshop mod, any modification will be classified as violation of consistency check. To modify this part please contact the author.*


To minimise complexity, disk space and something called *"draw calls"* (internal engine's magic) the badges are tiled in one image. It's preferred to arrange badges into square (i.e. 2x2, 4x4, ...)

> It's not restricted to arrange all badges in one big line, but you will probably suffer with poor performance ...

Please note, that the mod uses not only one but two badges textures. The reason is simple, ns2 engine is not very flexible when it comes to transparency. Therefore one texture **sbe_emissive.dds** contains colour information, the second one **sbe_opac.dds** contains information known as alpha or opacity or transparency.

Emissive file: ``..\models\marine\patches\sbe_emissive.dds``\
Opacity file: ``..\models\marine\patches\sbe_opac.dds``

#### Material File
*This part cannot be modified with original workshop mod, any modification will be classified as violation of consistency check. To modify this part please contact the author.*

Next part of shoulder badges mod is material file. This text file tells engine location, where to find emmisive and opacity texture and describe tilling of badges. Describe how are badges arranged in how many rows and columns.

Material file: ``..\models\marine\patches\shoulder_patch.material``
```
...
sbeOpacityMap = "models/marine/patches/sbe_opac.dds"
sbeEmissiveMap = "models/marine/patches/sbe_emissive.dds"
sbeRows = 2
sbeCols = 2
```

#### Badges Config File
Finally last but not least we have config file description. After reading all those not so enjoyable previous parts (did you actually read them?). If you didn't read them properly then please do. It's highly recommended and will help to understand *badge index section* of config file.

After first run of game with mounted mod, the default config is created:\
Config file: ``%appdata%\Natural Selection 2\ShoulderBadgesConfig.json``

The config part named **BadgeIndex** is dictionary to map "group_name" to "badge index" (will explain later).
To get proper group for player the Shine mod configuration is used. Please note, that shine mod must be properly configured and running on the server. Fortunately when you don't have Shine, or you want to override some crazy badge for specific player you can use Users part of config.

Config part **Users** is another dictionary to assign "group_name" to player by it's "steamid" (overrides Shine config).

Example of config file:
```json
{
  "BadgeIndex":{
    "none":0,
    "admin_group": 1,
    "moderators": 2,
    "idiots": 3
  },
  "Users":{
    "90000000000001":"none",
    "438225": "moderator"
  }
}
```

##### BadgeIndex
BadgeIndex is position of badge on texture. Index with 0 occupied left-top corner, iIndex 1 is second column to right on same top-most row. This continues to bottom-right corner.

> Please always consider index 0 as no-badge position. This index is used by mode to show no badge for not configured players (without group assigned).

### ShoulderBadgesExtra Mod ID - 2573eb73
```sh
Server.exe -mods "2bc45759"
```

### SteamWorkshop link
http://steamcommunity.com/sharedfiles/filedetails/?id=734287705