extends CharacterBody3D
@onready var interactArea := $InteractArea
var textbox = load("res://Textbox.tscn")
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if not Global.currentVehicle and interactArea.has_overlapping_bodies():
			Global.zoomDist=10.0
			Global.currentVehicle=self
			var spawn = textbox.instantiate()
			spawn.textqueue = "this means that the code is working, apparently"
			get_parent().add_child(spawn)
		elif Global.currentVehicle==self:
			get_parent().get_node("TextboxUI").queue_free()
			Global.currentVehicle=null
