extends CSGCombiner3D
func _ready() -> void:
	global_position = Vector3(randf_range(2000.0,8000.0),0.0,0.0).rotated(Vector3.UP,randf_range(0,2*PI))
	global_rotation.y=randf_range(0,2*PI)
	Global.stationPositions.append(global_position)
