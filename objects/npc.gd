extends CharacterBody3D
@onready var interactArea := $InteractArea
@export_enum("Recipient","Sender") var npcType := "Recipient"
var textbox = load("res://Textbox.tscn")
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if not Global.currentVehicle and interactArea.has_overlapping_bodies():
			Global.zoomDist=10.0
			Global.currentVehicle=self
			var spawn = textbox.instantiate()
			if npcType == "Sender":
				if not Global.targetStation:
					var selectedStation = Global.stations[randi_range(0,Global.stations.size()-1)]
					Global.targetPos=selectedStation.npc.global_position
					Global.targetStation = selectedStation
					spawn.textqueue = Global.deliveryDialogue[randi_range(0,Global.deliveryDialogue.size()-1)].replacen("[S]",selectedStation.stationName)
				else:
					spawn.textqueue="Hey, deliver that package you're holding before you take another one!"
				spawn.header = "Rhea 2 (the sequel)"
			if npcType == "Recipient":
				if Global.targetStation and get_parent() == Global.targetStation:
					spawn.textqueue = "am recipient yes hello hii hiiii hello hiiiii"
					Global.targetPos=Global.homePos
					Global.targetStation=null
				else:
					if Global.targetStation:
						spawn.textqueue = "Huh? No, this package isn't mine... It's addressed to Station [S].".replacen("[S]",Global.targetStation.stationName)
					else:
						spawn.textqueue = "Hm? No, I don't have any packages to deliver..."
			get_parent().add_child(spawn)
		elif Global.currentVehicle==self:
			get_parent().get_node("TextboxUI").queue_free()
			Global.currentVehicle=null
