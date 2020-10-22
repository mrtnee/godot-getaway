extends Spatial

func resize_border(tile_size, grid_map_width, grid_map_depth):
	rpc("make_border", tile_size, grid_map_width, grid_map_depth)

sync func make_border(tile_size, grid_map_width, grid_map_depth):
	var wall_width = tile_size * grid_map_width
	var wall_depth = tile_size * grid_map_depth
	
	$N_Wall.translation = Vector3(wall_width/2, $N_Wall.height/2, -1)
	$S_Wall.translation = Vector3(wall_width/2, $S_Wall.height/2, wall_depth+1)
	$W_Wall.translation = Vector3(-1, $W_Wall.height/2, wall_depth/2)
	$E_Wall.translation = Vector3(wall_width+1, $E_Wall.height/2, wall_depth/2)
	
	$N_Wall.width = wall_width
	$S_Wall.width = wall_width
	$W_Wall.width = wall_depth
	$E_Wall.width = wall_depth
	
	for child in get_children():
		child.use_collision = true
