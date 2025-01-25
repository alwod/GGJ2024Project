extends Area2D

@export var bubble: PackedScene
var rng = RandomNumberGenerator.new()


func gen_random_pos():
	var rect : Rect2 = $CollisionShape2D.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	var pos = Vector2(x,y) + global_position
	return pos

func spawn_bubble():
	var bubbleNode = bubble.instantiate()
	bubbleNode.position = gen_random_pos()
	bubbleNode.set_bubble_settings(rng.randf_range(10, 16), rng.randf_range(3, 6))
	add_child(bubbleNode)
	
func _on_timer_timeout():
	spawn_bubble()
