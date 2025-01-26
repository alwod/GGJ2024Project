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

		if body is RigidBody2D:
			var rigid_body: RigidBody2D = body
			rigid_body.set_freeze_enabled(true);
			rigid_body.set_physics_process(false)
			rigid_body.set_process(false)
	if(body.is_in_group("bubble_destoryer")):
		destroy()
	
func _physics_process(delta):
	position.y -= float_speed
	if (hasCaptured):
		if bodyCaptured is RigidBody2D:
			PhysicsServer2D.body_set_state(
 				bodyCaptured.get_rid(),
				PhysicsServer2D.BODY_STATE_TRANSFORM,
				Transform2D.IDENTITY.translated(global_position)
			)

		bodyCaptured.position = global_position
	
func float_upwards():
	pass

func destroy():
	if bodyCaptured && bodyCaptured is RigidBody2D:
		var rigid_body: RigidBody2D = bodyCaptured
		rigid_body.set_freeze_enabled(false)
		rigid_body.set_physics_process(true)
		rigid_body.set_process(true)

	queue_free()
	
func _on_timer_timeout():
	destroy()
