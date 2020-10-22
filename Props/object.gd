extends RigidBody

var has_finished_spawning = false


func _on_Timer_timeout():
	queue_free()


func _on_body_entered(body):
	var groups = body.get_groups()
	if not $AudioStreamPlayer3D.playing and groups.has('player'):
		$AudioStreamPlayer3D.play()


func _on_sleeping_state_changed():
	if not sleeping and has_finished_spawning:
		$Timer.start()
	else:
		has_finished_spawning = true
