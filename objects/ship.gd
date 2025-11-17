extends RigidBody3D
@onready var interactArea := $InteractArea
@export var thrustSpeed:= 0.5
@export var rotateSpeed :=2.0
@onready var fire := $ThrusterFire
@onready var firetimer = $ThrusterFire/Timer
@onready var thrustSFX = $ThrusterSound
var player
func _ready() -> void:
	player = get_parent().get_node("Player")
	Global.ship = self

func _physics_process(delta: float) -> void:
	fire.scale.x=1.5+sin((firetimer.time_left/firetimer.wait_time)*PI*8)/2
	fire.scale.y=fire.scale.x
	fire.scale.z=1.5-sin((firetimer.time_left/firetimer.wait_time)*PI*8)/2
	if Global.currentVehicle==self:
		gravity_scale=0.0
		var thrust_input := Input.get_action_strength("Thrust")
		if thrust_input:
			fire.visible=true
			if not thrustSFX.playing:
				thrustSFX.playing=true
		else:
			fire.visible=false
			thrustSFX.playing=false
		var rotate_input := Input.get_vector("left","right","forward","backward")
		rotation-=Vector3(rotate_input.y,rotate_input.x,0.0)*delta*rotateSpeed
		linear_velocity+=thrustSpeed*Vector3(0.0,0.0,thrust_input).rotated(self.transform.basis.x,self.rotation.x).rotated(self.transform.basis.y,self.rotation.y).rotated(self.transform.basis.z,self.rotation.z)
	else:
		fire.visible=false
		thrustSFX.playing=false
		gravity_scale=1.0
	rotation.z= lerp_angle(rotation.z,0.0,delta)
	angular_velocity=angular_velocity.lerp(Vector3.ZERO,delta*1)
	linear_velocity=linear_velocity.lerp(Vector3.ZERO,delta/5) #why does space have air resistance? uh. gameplay
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if not Global.currentVehicle and interactArea.has_overlapping_bodies():
			Global.zoomDist=20.0
			Global.currentVehicle=self
			var posBuffer = player.global_position
			var rotBuffer = player.global_rotation
			var player2 = player.duplicate()
			player.get_parent().remove_child(player)
			add_child(player2)
			player2.global_position = posBuffer
			player2.global_rotation= rotBuffer
			player=player2
		elif Global.currentVehicle==self:
			Global.currentVehicle=null
			var posBuffer = player.global_position
			var rotBuffer = player.global_rotation
			var player2 = player.duplicate()
			remove_child(player)
			get_parent().add_child(player2)
			player2.global_position = posBuffer
			player2.global_rotation=Vector3.ZERO #rotBuffer
			player=player2
