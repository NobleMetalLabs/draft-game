extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Button").pressed.connect(save_file)

func save_file() -> void:
	var path : String = "res://src/dev/transp.gd"
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_line("extends Node")
	file.store_line("\n")
	file.store_line("func _ready() -> void:")
	file.store_line("\tvar parent : Control = get_parent()")
	file.store_line("\tvar label : Label = parent.get_node(\"%LABEL\")")
	file.store_line("\tlabel.text = \"%s\"" % [get_node("LineEdit").get_text()])
	file.close()

	var script : Script = load(path)
	var script_instance : Node = script.new()
	self.add_child(script_instance)