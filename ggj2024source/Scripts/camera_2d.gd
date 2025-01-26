extends Camera2D

@export var fish: Node2D
@export var duck: Node2D

func similarity_fraction(u: Vector2, v: Vector2) -> float:
	# Calculate the Euclidean distance
	var distance = u.distance_to(v)
	# Return the fraction that decreases as distance increases
	return 1 / (1 + distance) * 300
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var u = fish.position
	var v = duck.position
	var result = similarity_fraction(u, v)	
	zoom = Vector2(result, result)
	# Stops the camera from zooming out too much. 
	# Change the first vector with smaller numbers to increase max zoom-out range.
	# Don't recommend going higher than 0.09
	zoom = zoom.clamp(Vector2(0.3, 0.3), Vector2(0.4, 0.4))
	
	# Finds the vector that is halfway between the fish and duck
	var middle_point = u.lerp(v, 0.5)
	global_position = middle_point

	
