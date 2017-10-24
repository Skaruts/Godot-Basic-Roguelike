I wondered how Godot would fare in making a roguelike, and I ended up with this. This is not a serious project: it's just a learning experiment that I may or may not keep working on, somewhat in the same vein of the [RogueBasin tutorial](http://www.roguebasin.com/index.php?title=Complete_Roguelike_Tutorial,_using_python%2Blibtcod&oldid=42760).

If you feel this might be a starting point for you, feel free to use it. But beware: I'm a potentially noobish programmer and not so experienced in Godot or roguelike/game deving, so there may be messy code, redundant code, inconsistent coding practices, etc.

I decided to do most of it through code, because it seemed to make more sense to me that way.

All bitmap fonts are rough WIPs and were created by me with [Aseprite](https://www.aseprite.org/) (with a bit of very useful help from [Grid Sage Games](http://www.gridsagegames.com/blog/2014/09/font-creation/)).



#### **_Currently, the controls are:_**
|key 				| action|
|---|---|
|**Q**				| Quit
|**F**				| Shake Camera (for no reason, just a useless test)
|**SPACE**			| Generate new map (currently using a fixed seed)
|**WASD / Arrows**	| Move character
|**PgUp / PgDown**	| Switch font
|**1**				| (debug) Toggle all debugging visuals 
|**2 / H**			| (debug) Toggle mob HP info 
|**3** 	 			| (debug) Toggle BSP leafs 
|**4** 	 			| (debug) Toggle rooms 
|**5**				| (debug) Toggle hallways 
|**6**				| (debug) Toggle room info 


#### **_Gameplay:_**
I wouldn't call this a game, but you can move around and kill mobs by moving toward them. They will attack you if you're standing adjacent to them, and they can also attack you diagonally, not at all because I have no clue how to change that, but because it's only fair! :+1:

There's nothing but Orcs and Trolls in the map, for now.
