extends Spatial

func _enter_tree():
	get_tree().paused = true

# spawn myself on my machine
func spawn_local_player():
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(Network.local_player_id)
	new_player.transform = new_player.transform.translated(Vector3(10, 3, 13))
	$Players.add_child(new_player)

# everyone else, spawn me on your machine
remote func spawn_remote_player(id):
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(id)
	new_player.transform = new_player.transform.translated(Vector3(10, 3, 13))
	$Players.add_child(new_player)

func unpause():
	get_tree().paused = false
	spawn_local_player()
	rpc("spawn_remote_player", Network.local_player_id)
	
