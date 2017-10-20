I wondered how Godot would fare in making a roguelike, and I ended up with this. This is not a serious project: it's just a learning experiment that I may never even finish, although I'd like to eventually take it somewhere close to the [RogueBasin tutorial](http://www.roguebasin.com/index.php?title=Complete_Roguelike_Tutorial,_using_python%2Blibtcod&oldid=42760), if I feel motivated to, and when other projects don't keep me busy. I'm following that tutorial more as a guide for what to do next, not necessarily for how to implement things.

If you feel this might be a starting point for you, feel free to use it. But beware: I am only human, a potentially noobish programmer, and not so experienced in Godot or in roguelike/game deving, so use it at your own risk. There may be messy code, redundant code, etc. Also, since this is a WIP, there may be inconsistent coding practices wherever I haven't cleaned up the code.

I decided to do a lot of stuff through code that seemed to make more sense to me that way. I decided against using a TileMap, especially, because I don't really enjoy creating tilesets in Godot, and also because the maps are supposed to be procedurally generated anyway (although I'm interested in testing how that could be done using a TileMap, so I may try that in the future).

All bitmap fonts are rough WIPs and were created by me with Aseprite (with a bit of very useful help from [Grid Sage Games](http://www.gridsagegames.com/blog/2014/09/font-creation/)).



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
I don't even call this a game yet. You can move around and kill mobs. 

Move towards a mob to attack. Mobs attack you if you're standing adjacent to them, and they can also attack you diagonally, not at all because I have no clue how to change that, but because it's only fair! :+1:

There's nothing but Orcs and Trolls in the map, for now.
