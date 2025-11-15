extends Node
var asteroid = load("res://objects/asteroid.tscn")
func _ready() -> void:
	for i in 500:
		var spawn = null
		spawn = asteroid.instantiate()
		get_parent().call_deferred("add_child",spawn)
