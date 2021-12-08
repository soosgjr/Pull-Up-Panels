# Pull-Up Panels

A Project Zomboid mod that adds the option to collapse UI panels towards their
bottom.


## Installation

Copy the contents of the `Source` folder to the `mods` folder of your Project
Zomboid installation. This is usually located under the `%USERPROFILE%\Zomboid`
path. Once this is done, the mod has to be enabled in the game's mod menu.


## Usage

The mod adds a third pinning state to collapsible UI panels. Switching to this
will cause the panels to collapse downwards instead. A slight difference
compared to the vanilla functionality is that the pin button now will display
the current state instead of the one you're switching to.

![The available states.](Documentation/states.png?raw=true)


## Compatibility

The mod was developed for version 41.56 of Project Zomboid.


## Known Issues and Limitations

- Tabbed panels which dynamically change their height (info, skills, health,
  etc.) will collapse to the bottom of the currently selected tab.
- The make up panel inherits the vanilla bug where the pin button sometimes
  won't appear.
- The mod's effect on the controller UI was not tested.


## License

For the Project Zomboid licensing terms, please see Indie Stone's official
[blog post](https://projectzomboid.com/blog/support/terms-conditions/).


## Credits

The vanilla code and collapse icon included in the mod were made by Indie Stone.
The mod was developed by Gabor Soos.


## Version History

- Version 0.1.0, December 8th, 2021
  - The initial release.
