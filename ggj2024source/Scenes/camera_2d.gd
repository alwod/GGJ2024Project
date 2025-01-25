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
	#zoom = clamp(Vector2(-1, -1), Vector2(result, result), Vector2(0.01, 0.01))
	print(zoom)

	
