extends Node
var asteroid = load("res://objects/asteroid.tscn")
func _ready() -> void:
	for i in 500:
		var spawn = null
		spawn = asteroid.instantiate()
		get_parent().call_deferred("add_child",spawn)
		get_tree().process_frame
		spawn.global_position = Vector3(100.0,0.0,0.0).rotated(Vector3.UP,randi_range(0,2*PI))
