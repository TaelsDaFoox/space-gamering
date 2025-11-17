extends CharacterBody3D
@onready var interactArea := $InteractArea
@onready var anim = $PlayerModel/AnimationPlayer
var selectedStation
var challenge = 0
@export_enum("Recipient","Sender") var npcType := "Recipient"
var textbox = load("res://Textbox.tscn")
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if not Global.currentVehicle and interactArea.has_overlapping_bodies():
			anim.play("Inventory",0.2)
			Global.zoomDist=10.0
			Global.currentVehicle=self
			var spawn = textbox.instantiate()
			if npcType == "Sender":
				if not Global.targetStation:
					Global.deliveryExpired=false
					selectedStation = Global.stations[randi_range(0,Global.stations.size()-1)]
					challenge=randi_range(0,2)
					spawn.textqueue = Global.deliveryDialogue[randi_range(0,Global.deliveryDialogue.size()-1)].replacen("[S]",selectedStation.stationName)
					if challenge == 0:
						spawn.textqueue=spawn.textqueue+" And deliver it QUICK, This needs to be delivered RIGHT NOW!"
				else:
					spawn.textqueue="Hey, deliver that package you're holding before you take another one!"
				spawn.header = "Rhea"
			if npcType == "Recipient":
				spawn.header = "Station "+get_parent().stationName+" Employee"
				if Global.targetStation and get_parent() == Global.targetStation:
					spawn.textqueue = Global.recieveDialogue[randi_range(0,Global.recieveDialogue.size()-1)]
					Global.targetPos=Global.homePos
					Global.targetStation=null
					if Global.mainUI and not Global.mainUI.get_node("Timer").is_stopped():
						Global.mainUI.get_node("Timer").stop()
				else:
					if Global.targetStation:
						spawn.textqueue = "Huh? No, this package isn't mine... It's addressed to Station [S].".replacen("[S]",Global.targetStation.stationName)
					else:
						spawn.textqueue = "Hm? No, I don't have any packages to deliver..."
			get_parent().add_child(spawn)
		elif Global.currentVehicle==self:
			if npcType == "Sender" and not Global.targetStation:
				Global.targetPos=selectedStation.npc.global_position
				Global.targetStation = selectedStation
				if challenge == 0:
						if Global.mainUI:
							Global.mainUI.get_node("Timer").start()
			anim.play("Idle",0.2)
			get_parent().get_node("TextboxUI").queue_free()
			Global.currentVehicle=null
func _process(delta: float) -> void:
	if Global.player:
		global_rotation.y=lerp_angle(global_rotation.y,-Vector2(Global.player.global_position.x,Global.player.global_position.z).angle_to_point(Vector2(global_position.x,global_position.z))-(PI/2),delta)
func _ready() -> void:
	anim.play("Idle",0.2)
