extends Node

var tiles = []
var cafe_spots = []
var map_size = Vector2()

var number_of_parked_cars = 100
var number_of_billboards = 75
var number_of_traffic_cones = 15
var number_of_hydrants = 50
var number_of_streetlamps = 50
var number_of_dumpsters = 25
var number_of_scaffolding = 25
var number_of_cafes = 20


func generate_props(tile_list, size, plazas):
	tiles = tile_list
	map_size = size
	cafe_spots = plazas
	place_cars()
	place_billboards()
	place_traffic_cones()
	place_hydrants()
	place_streetlamps()
	place_scaffolding()
	place_cafes()


func random_tile(tile_count):
	var tile_list = tiles
	var selected_tiles = []
	tile_list.shuffle()
	
	for i in range(tile_count):
		var tile = tile_list[i]
		selected_tiles.append(tile)
	return selected_tiles


func place_cars():
	var tile_list = random_tile(number_of_parked_cars + number_of_dumpsters)
	for i in range(number_of_parked_cars):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_cars", tile, tile_rotation)
		tile_list.pop_front()
	place_dumpsters(tile_list)

sync func spawn_cars(tile, car_rotation):
	var car = preload("res://Props/ParkedCars.tscn").instance()
	car.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	car.rotation_degrees.y = car_rotation
	add_child(car, true)


func place_dumpsters(tile_list):
	for i in range(number_of_dumpsters):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_dumpsters", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_dumpsters(tile, dumpster_rotation):
	var dumpster = preload("res://Props/Dumpster/Dumpster.tscn").instance()
	dumpster.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	dumpster.rotation_degrees.y = dumpster_rotation
	add_child(dumpster, true)


func place_billboards():
	var tile_list = random_tile(number_of_billboards)
	for i in range(number_of_billboards):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_billboards", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_billboards(tile, billboard_rotation):
	var billboard = preload("res://Props/Billboards/Billboard.tscn").instance()
	billboard.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	billboard.rotation_degrees.y = billboard_rotation
	add_child(billboard, true)


func place_traffic_cones():
	var tile_list = random_tile(number_of_traffic_cones)
	for i in range(number_of_traffic_cones):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_traffic_cones", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_traffic_cones(tile, traffic_cones_rotation):
	var trafffic_cones = preload("res://Props/TrafficCones/TrafficCones.tscn").instance()
	trafffic_cones.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	trafffic_cones.rotation_degrees.y = traffic_cones_rotation
	add_child(trafffic_cones, true)


func place_hydrants():
	var tile_list = random_tile(number_of_hydrants)
	for i in range(number_of_hydrants):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_hydrants", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_hydrants(tile, hydrant_rotation):
	var hydrant = preload("res://Props/Hydrant/Hydrant.tscn").instance()
	hydrant.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	hydrant.rotation_degrees.y = hydrant_rotation
	add_child(hydrant, true)


func place_streetlamps():
	var tile_list = random_tile(number_of_streetlamps)
	for i in range(number_of_streetlamps):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_streetlamps", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_streetlamps(tile, lamp_rotation):
	var lamp = preload("res://Props/StreetLamp/StreetLamp.tscn").instance()
	lamp.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	lamp.rotation_degrees.y = lamp_rotation
	add_child(lamp, true)


func place_scaffolding():
	var tile_list = random_tile(number_of_scaffolding)
	for i in range(number_of_scaffolding):
		var tile = tile_list[0]
		var tile_type = get_node("..").get_cell_item(tile.x, tile.y, tile.z)
		var allowed_rotations = $ObjectRotationLookup.lookup_rotation(tile_type)
		if allowed_rotations:
			var tile_rotation = allowed_rotations[randi() % allowed_rotations.size()] * (-1)
			tile.y = tile.y + 0.5
			rpc("spawn_scaffolding", tile, tile_rotation)
		tile_list.pop_front()

sync func spawn_scaffolding(tile, scaffolding_rotation):
	var scaffolding = preload("res://Props/Scaffolding/Scaffolding.tscn").instance()
	scaffolding.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	scaffolding.rotation_degrees.y = scaffolding_rotation
	add_child(scaffolding, true)


func place_cafes():
	cafe_spots.shuffle()
	for i in range(number_of_cafes):
		var tile = cafe_spots[i]
		var building_rotation = tile[0]
		var tile_position = Vector3(tile[1], 0.5,  tile[2])
		var tile_rotation = 0
		
		if building_rotation == 10:
			tile_rotation = 180
		elif building_rotation == 16:
			tile_rotation = 90
		elif building_rotation == 22:
			tile_rotation = 270
		
		rpc("spawn_cafes", tile_position, tile_rotation)


sync func spawn_cafes(tile, cafe_rotation):
	var cafe = preload("res://Props/Cafe/cafe.tscn").instance()
	cafe.translation = Vector3((tile.x * 20) + 10, tile.y, (tile.z * 20) + 10)
	cafe.rotation_degrees.y = cafe_rotation
	add_child(cafe, true)


