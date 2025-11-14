extends RigidBody3D
@onready var shipArea := $ShipArea
var player
func _ready() -> void:
	player = get_parent().get_node("Player")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
			var posBuffer = player.global_position
			var rotBuffer = player.global_rotation
			var player2 = player.duplicate()
			player.get_parent().remove_child(player)
			add_child(player2)
			player2.global_position = posBuffer
			player2.global_rotation= rotBuffer
