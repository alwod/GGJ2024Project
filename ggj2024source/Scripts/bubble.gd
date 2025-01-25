extends Area2D

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
	
func _physics_process(delta):
	position.y -= float_speed
	if (hasCaptured):
		bodyCaptured.position = position
	
func float_upwards():
	pass


func _on_timer_timeout():
	queue_free()
