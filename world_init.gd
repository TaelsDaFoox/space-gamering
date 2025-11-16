extends Node
var asteroid = load("res://objects/asteroid.tscn")
var station = load("res://objects/delivery_station.tscn")
func _ready() -> void:
	for i in 500:
		var spawn = asteroid.instantiate()
		get_parent().call_deferred("add_child",spawn)
	for i in 10:
		var spawn = station.instantiate()
		get_parent().call_deferred("add_child",spawn)
