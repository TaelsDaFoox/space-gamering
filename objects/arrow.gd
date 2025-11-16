extends Node3D
func _process(delta: float) -> void:
	if Global.targetPos:
		look_at(Global.targetPos)
		visible = true
	else:
		visible=false
