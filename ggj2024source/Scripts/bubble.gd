extends Area2D
class_name Bubble

@export var float_speed := 2.0
var hasCaptured = false
var bodyCaptured

func set_bubble_settings(destory_time, speed):
	$Timer.wait_time = destory_time
	float_speed = speed
	
func _on_body_entered(body):
	if(body.is_in_group("bubbleable")):
		hasCaptured = true;
		bodyCaptured = body

		if body.name == "Duck":
			var duck: Duck = body
			duck.set_freeze_enabled(true);
			duck.set_physics_process(false)
			duck.set_process(false)
	
func _physics_process(delta):
	position.y -= float_speed
	if (hasCaptured):
		if bodyCaptured.name == "Duck":
			PhysicsServer2D.body_set_state(
 				bodyCaptured.get_rid(),
				PhysicsServer2D.BODY_STATE_TRANSFORM,
				Transform2D.IDENTITY.translated(global_position)
			)

		bodyCaptured.position = global_position
	
func float_upwards():
	pass


func _on_timer_timeout():
	if bodyCaptured && bodyCaptured.name == "Duck":
		var duck: Duck = get_node("/root/Game/Duck")
		duck.set_freeze_enabled(false)
		duck.set_physics_process(true)
		duck.set_process(true)

	queue_free()
