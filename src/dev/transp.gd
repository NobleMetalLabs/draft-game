extends Node


func _ready() -> void:
	var parent : Control = get_parent()
	var label : Label = parent.get_node("%LABEL")
	label.text = "yipee"
