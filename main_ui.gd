extends Control
@onready var deliverLabel = $DeliverLabel
@onready var controls = $ShipControls
@onready var timerLabel = $TimerLabel
@onready var timer = $Timer
func _ready() -> void:
	Global.mainUI=self
func _process(delta: float) -> void:
	timerLabel.text=str(int(timer.time_left/60.0))+"'"+str(int(fmod(timer.time_left,60.0)))+'"'+str(int(fmod(timer.time_left,1.0)*100)).pad_zeros(2)
	if Global.targetStation:
		deliverLabel.text = "Deliver to Station "+Global.targetStation.stationName+"!"
	elif Global.targetPos:
		deliverLabel.text = "Head back to HQ and get a new package!"
	else:
		deliverLabel.text = ""
	controls.visible = Global.zoomDist==20.0
