extends Control

@onready var ce : TextEdit = $"%TEXT-EDIT"

func _ready() -> void:
	var file_access := FileAccess.open("res://ast/game/cards/logic/gcb/guardian_automaton.gcb", FileAccess.READ)
	var dict : Dictionary = file_access.get_var()
	file_access.close()
	var cbg : CardBehaviorGraph = CardBehaviorGraphSerializable.from_dict(dict).deserialize()
	var transp : String = CardBehaviorGraphTranspiler.transpile(cbg)
	ce.text = transp
