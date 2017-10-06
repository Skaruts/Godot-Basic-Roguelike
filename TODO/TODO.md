- [ ] >>>	Make Corpse a component, rather than an entity on its own
- [ ] >>>	Revert the player back to a simple entity (not mob - because it's conflicting with mob groups)
- [ ] >>>	Show combat feedback in the UI Log (currently being printed to stdout)

- [ ] >>	Build a UI

- [ ] >>	Implement map objects, obstacles, interactibles
- [ ] >>	Implement items, inventories, enemy drops
- [ ] >>	Implement doors

- [ ] >>	Implement a TileMap node (to see if it performs better, when playing and switching textures)
- [ ] > 	Make mobs move randomly when idling
- [ ] >		Improve the combat system
- [ ] > 	Improve the icon (change it)

- [x] 		add _solid_ property to tiles (stop using collision map)
- [x] 		Convert arrays to 1D arrays (fovmap, tilemap) (noticeable performance gain)
- [x] 		Make the tilemap a dict of vector2 keys, try it out ( `tilemap[Vector2(y, x)]` )
