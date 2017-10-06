# A basic Roguelike made in Godot

I wondered how Godot would fare in making a roguelike, and I ended up with this. This is not a serious project: it's just a learning experiment that I may never even finish. I would like to take it as far as the [RogueBasin tutorial](http://www.roguebasin.com/index.php?title=Complete_Roguelike_Tutorial,_using_python%2Blibtcod&oldid=42760), if I keep feeling motivated to.

If you feel this might be a good starting point for you, feel free to use it.

I decided to do a lot of stuff through code that seemed to make more sense to me that way. I decided against using a TileMap, especially, because I don't really enjoy creating tilesets in Godot, and also because the maps are supposed to be procedurally generated anyway (although I'm interested in testing if the TileMap performs better than my implementation, so I may come to experiment with implementing it through code too).

I am only human, a noobish programmer, and not very experienced in Godot or in roguelike deving. Use this at your own risk.

All bitmap fonts are WIP and were created by me with Aseprite (with a bit of very useful help from [Grid Sage Games](http://www.gridsagegames.com/blog/2014/09/font-creation/)).



## **_Currently, the controls are:_**
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


### **_Gameplay:_**
Move towards an enemy to attack. Enemies attack you if you're standing adjacent to them. They can also attack you diagonally, not at all because I have no clue how to change that, but because it's only fair! :+1:

There's nothing but Orcs and Trolls in the map, for now.


