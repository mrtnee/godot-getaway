extends Popup

onready var player_list = $VBoxContainer/CenterContainer/ItemList

func _ready():
	player_list.clear()

func refresh_players(players):
	player_list.clear()
	for player_id in players:
		var player = players[player_id]["player_name"]
		player_list.add_item(player, null, false)
