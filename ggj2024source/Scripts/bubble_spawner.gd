extends Area2D

@onready var timer_node = $Timer
@export var bubble: PackedScene
@export var spawn_delay: float = 2
var rng = RandomNumberGenerator.new()

func _ready():
	timer_node.wait_time = spawn_delay

func gen_random_pos():
	var rect : Rect2 = $CollisionShape2D.shape.get_rect()
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	var pos = Vector2(x,y) 
	return pos

func spawn_bubble():
	var bubbleNode = bubble.instantiate()
	bubbleNode.global_position = gen_random_pos()
	bubbleNode.set_bubble_settings(rng.randf_range(10, 16), rng.randf_range(6, 10))
	add_child(bubbleNode)


func _on_timer_timeout():
	print("bubble spawned")
	spawn_bubble()
