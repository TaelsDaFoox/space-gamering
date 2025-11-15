extends StaticBody3D
var spinSpdCap := 0.3
var spinSpd = Vector3(randf_range(-spinSpdCap,spinSpdCap),randf_range(-spinSpdCap,spinSpdCap),randf_range(-spinSpdCap,spinSpdCap))
func _ready() -> void:
	global_position = Vector3(randf_range(300.0,10000.0),0.0,0.0).rotated(Vector3.UP,randf_range(0,2*PI))
	global_position = global_position.rotated(Vector3.RIGHT,randf_range(0,2*PI))
	global_position = global_position.rotated(Vector3.FORWARD,randf_range(0,2*PI))
	scale = Vector3(randf_range(1.0,5.0),randf_range(1.0,5.0),randf_range(1.0,5.0))
	#print("I do in fact exist")
func _physics_process(delta: float) -> void:
	rotation+=spinSpd*delta
