extends CharacterBody3D
#@onready var camera = $Camera3D
@onready var camPivot = $SpringArm3D
@export var move_speed :=10
@export var mouse_sensitivity:=0.005
@export var gravityForce = 10.0
@export var jumpForce = 10.0
@onready var playerModel = $PlayerModel
@onready var anim = $PlayerModel/AnimationPlayer
func _physics_process(delta: float) -> void:
	if Global.currentVehicle:
		camPivot.spring_length=lerpf(camPivot.spring_length,Global.zoomDist,delta*30)
	else:
		playerModel.rotation.y=camPivot.rotation.y+PI
		camPivot.spring_length=lerpf(camPivot.spring_length,0.0,delta*30)
	var input_dir = Input.get_vector("left","right","forward","backward")
	input_dir = input_dir.rotated(-camPivot.rotation.y)
	if Global.currentVehicle:
		input_dir=Vector2.ZERO
	velocity.x=input_dir.x*move_speed
	velocity.z=input_dir.y*move_speed
	if velocity.length()>0.0:
		anim.play("Walk",0.2,velocity.length()/3)
	else:
		anim.play("Idle",0.2)
	if is_on_floor():
		if velocity.y<0.0:
			velocity.y=0.0
	elif not Global.currentVehicle:
		velocity.y-=gravityForce*delta
	move_and_slide()
	playerModel.visible=camPivot.spring_length>3.0
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("lock mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("unlock mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camPivot.rotation.y-=event.relative.x*mouse_sensitivity
		camPivot.rotation.x-=event.relative.y*mouse_sensitivity
		camPivot.rotation.x= clampf(camPivot.rotation.x,-PI/2,PI/2)
	if event.is_action_pressed("jump") and not Global.currentVehicle:
		velocity.y=jumpForce
