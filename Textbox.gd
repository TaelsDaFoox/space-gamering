extends Control
@export var header:="Johnathan McPlaceholder"
@export var textqueue := ""
var textProgress :=0.0
@onready var nameLabel = $Name
@onready var textLabel = $Text
@export var textSpeed :=100.0
func _process(delta: float) -> void:
	nameLabel.text = header
	textProgress+=delta*textSpeed
	textLabel.text=textqueue.left(floor(textProgress))
