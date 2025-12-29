# Pull-Up Panels

A Project Zomboid mod that adds the option to collapse UI panels towards their
bottom.


## Installation

Copy the contents of the `Source` folder to the `mods` folder of your Project
Zomboid installation. This is usually located under the `%USERPROFILE%\Zomboid`
path. Once this is done, the mod has to be enabled in the game's mod menu.


## Usage

The mod modifies the panel collapsing logic to make them collapse downwards
whenever the panel's closer to the bottom of the screen than the top.

![The available states.](Documentation/states.png?raw=true)


## Compatibility

The mod was developed for version 41.78.16 and 42.13.1 of Project Zomboid. It is
known to be incompatible with other windowing mods, like Windows Everywhere.


## Known Issues and Limitations

- In some cases panels might get stuck off-screen, which requires the deletion
  of the `%USERPROFILE%\Zomboid\Lua\layout.ini` file to fix.
- Panels which dynamically change their height (skills, health, device options,
  etc.) will collapse to the bottom of their current height. These panels can
  also move around when loading into a game from the downwards collapse state.
- Panels which are forced to open in a certain state (crafting, building, etc.)
  will move around on subsequent openings from the downwards collapse state.
- The mod's effect on the controller UI or the accessibility settings was not
  tested.
- The mod's effect on multiplayer was not tested, but it's most likely required
  to be installed on the server and every client to function correctly.
- Some vanilla bugs are inherited, like the make up panel's pin button randomly
  not appearing or the generator panel vanishing when collapsed.


## License

For the Project Zomboid licensing terms, please see Indie Stone's official
[blog post](https://projectzomboid.com/blog/support/terms-conditions/).


## Credits

The vanilla code and collapse icon included in the mod were made by Indie Stone.
The mod was developed by Gabor Soos.


## Version History

- Version 0.4.0, December 29th, 2025
  - The third pinning state was removed, collapse direction now gets determined
    whether the panel is closer to the top or the bottom of the screen.
  - Made the mod compatible with version 42.13.1 of Project Zomboid.

- Version 0.3.0, December 28th, 2022
  - Made the mod compatible with version 41.78.16 of Project Zomboid.
  - Fixed the bug where the inventory panel would snap off-screen when using the
    place item action. Thanks, Lino.

- Version 0.2.0, September 18th, 2022
  - Made the mod compatible with version 41.73 of Project Zomboid.

- Version 0.1.0, December 8th, 2021
  - The initial release.
