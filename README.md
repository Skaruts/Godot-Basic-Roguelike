This a learning project that I'm doing on spare time (from other projects) to see what I can come up with in Godot, in terms of making a roguelike. I'm doing this somewhat in the same vein of the [RogueBasin tutorial](http://www.roguebasin.com/index.php?title=Complete_Roguelike_Tutorial,_using_python%2Blibtcod&oldid=42760).

If you feel like you'd like to use it as a starting point, feel free to do so. But beware: I'm a potentially noobish programmer and not so experienced in Godot or roguelike/game deving, so there may be messy code, redundant code, inconsistent coding practices, etc.

All graphical assets are rough WIPs created by me with [Aseprite](https://www.aseprite.org/) (with a bit of very useful help from [Grid Sage Games](http://www.gridsagegames.com/blog/2014/09/font-creation/) for the bitmap fonts), and [Krita](https://krita.org/en/).


#### **_Currently, the controls are:_**
|key 				| action|
|---|---|
|**Q**				| Quit
|**F**				| Shake Camera (for no reason, just a useless test)
|**SPACE**			| Generate new map (currently using a fixed seed, in autoload/settings.gd)
|**WASD / Arrows**	| Move character
|**PgUp / PgDown**	| Switch font
|**1**				| (debug) Toggle all debugging visuals 
|**2 / H**			| (debug) Toggle mob HP info 
|**3** 	 			| (debug) Toggle BSP leafs 
|**4** 	 			| (debug) Toggle rooms 
|**5**				| (debug) Toggle hallways 
|**6**				| (debug) Toggle room info 


#### **_Gameplay:_**
I wouldn't call this a game, but you can move around and kill mobs by moving toward them. They will attack you if you're standing adjacent to them. There's nothing but Orcs and Trolls in the map, for now.
