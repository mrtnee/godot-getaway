extends VehicleBody

const MAX_STEER_ANGLE = 0.35
const STEER_SPEED = 1.5

const MAX_ENGINE_FORCE = 250
const MAX_BREAK_FORCE = 10
const MAX_SPEED = 30

var steer_target = 0.0		# where do I want the wheels to go
var steer_angle = 0.0		# where are the wheels now

sync var players = {}
var player_data = {"steer": 0, "engine": 0, "brakes": 0, "position": null}

func _ready():
	players[name] = player_data
	players[name].position = transform
	
	if not is_local_Player():
		$Camera.queue_free()

func is_local_Player():
	return name == str(Network.local_player_id)

func _physics_process(delta):
	if is_local_Player():
		drive(delta)
	if not get_tree().is_network_server():
		transform = players[name].position
	
	steering = players[name].steer
	engine_force = players[name].engine
	brake = players[name].brakes

func drive(delta):
	var steering_value = apply_steering(delta)
	var throttle = apply_throttle()
	var brakes = apply_brakes()
	
	update_server(name, steering_value, throttle, brakes)

func apply_steering(delta):
	var steer_val = 0
	var left = Input.get_action_strength("steer_left")
	var right = Input.get_action_strength("steer_right")
	
	if left:
		steer_val = left
	else:
		steer_val = -right
	
	steer_target = steer_val * MAX_STEER_ANGLE
	
	if steer_target < steer_angle:
		steer_angle -= STEER_SPEED * delta
	elif steer_target > steer_angle:
		steer_angle += STEER_SPEED * delta
	
	return steer_angle

func apply_throttle():
	var throttle_val = 0.0
	var forward = Input.get_action_strength("forward")
	var backward = Input.get_action_strength("backward")
	
	if linear_velocity.length() < MAX_SPEED:
		if forward:
			throttle_val = forward
		else:
			throttle_val = -backward
		
	
	
	return throttle_val * MAX_ENGINE_FORCE

func apply_brakes():
	var break_val = 0.0
	var break_strength = Input.get_action_strength("break")
	
	if break_strength:
		break_val = break_strength
	
	return break_val * MAX_BREAK_FORCE

func update_server(id, steering_value, throttle, brakes):
	if not get_tree().is_network_server():
		rpc_unreliable_id(1, "manage_clients", id, steering_value, throttle, brakes)
	else:
		manage_clients(id, steering_value, throttle, brakes)

sync func manage_clients(id, steering_value, throttle, brakes):
	players[id].steer = steering_value
	players[id].engine = throttle
	players[id].brakes = brakes
	players[id].position = transform
	rset_unreliable("players", players)
