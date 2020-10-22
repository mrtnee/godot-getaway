extends Control

onready var NameText = $VBoxContainer/CenterContainer/GridContainer/NameText
onready var port = $VBoxContainer/CenterContainer/GridContainer/PortText
onready var selected_ip = $VBoxContainer/CenterContainer/GridContainer/IPText

var is_cop = false

func _ready():
	NameText.text = Saved.save_data["player_name"]
	port.text = str(Network.DEFAULT_PORT)
	selected_ip.text = Network.DEFAULT_IP

func _on_HostButton_pressed():
	Network.selected_port = int(port.text)
	Network.create_server()
	get_tree().call_group("HostOnly", "show")
	create_waiting_room()

func _on_JoinButton_pressed():
	Network.selected_port = int(port.text)
	Network.selected_ip = selected_ip.text
	Network.connect_to_server()
	create_waiting_room()


func _on_NameText_text_changed(new_text):
	Saved.save_data["player_name"] = NameText.text
	Saved.save_game()

func create_waiting_room():
	$WaitingRoom.popup_centered()
	$WaitingRoom.refresh_players(Network.players)


func _on_ReadyButton_pressed():
	Network.start_game()


func _on_TeamCheck_toggled(button_pressed):
	is_cop = button_pressed
