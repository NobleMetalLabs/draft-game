class_name ClientUI
extends Control

@onready var temp_card_scn : PackedScene = preload("res://scn/objects/TempCard.tscn")

# debug
var shift_reg_meta : CardMetadata = preload("res://ast/cards/ShiftRegister.tres")

func _on_button_button_down() -> void:
	var new_temp_card : TempCard = temp_card_scn.instantiate() 
	new_temp_card.metadata = shift_reg_meta
	self.add_child(new_temp_card, true)
