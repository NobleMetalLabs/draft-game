class_name CBEditorGraphNode
extends GraphNode

var node_internal : CardBehaviorNodeInstance

func _init(_node_internal : CardBehaviorNodeInstance, _pos : Vector2) -> void:
	self.node_internal = _node_internal
	self.position_offset = _pos
	self.size = Vector2.ONE

	self.title = _node_internal.config.name
	self.resizable = true
	_setup_graphnode()

func _setup_graphnode() -> void:
	_setup_options()
	_setup_outputs()
	_setup_inputs()

func _setup_meta() -> void:
	pass

enum ArgType {
	INPUT,
	OUTPUT,
	OPTION
}

func __new_dummy() -> Control:
	# I LOVE GODOT ENGINE!!!!!
	var cap_cont := Control.new()
	cap_cont.name = "_".repeat(self.get_child_count())
	cap_cont.size_flags_vertical = Control.SIZE_EXPAND_FILL
	cap_cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return cap_cont

func __new_label(text : StringName, type : ArgType) -> Label:
	var label := Label.new()
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	match (type):
		ArgType.INPUT:
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT 
		ArgType.OUTPUT:
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT 
		ArgType.OPTION:
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = text
	return label

func __get_value_or_default(arg : CardBehaviorArgument) -> Variant:
	var argument_values : Dictionary = node_internal.argument_values
	if argument_values.has(arg.name):
		return argument_values[arg.name]
	var argument_type : CardBehaviorArgument.ArgumentType = arg.type
	if argument_type == CardBehaviorArgument.ArgumentType.VARIANT:
		argument_type = __get_domain()
	match (argument_type):
		CardBehaviorArgument.ArgumentType.INT:
			return 0
		CardBehaviorArgument.ArgumentType.FLOAT:
			return 0.0
		CardBehaviorArgument.ArgumentType.BOOL:
			return false
		CardBehaviorArgument.ArgumentType.STRING_NAME:
			return ""
		_:
			return null

func __set_domain(index: int ) -> void:
	node_internal.argument_values["domain"] = index
	print("domain set to %s" % CardBehaviorArgument.ArgumentType.keys()[index])

func __get_domain() -> CardBehaviorArgument.ArgumentType:
	var domain_arg : CardBehaviorArgument = node_internal.config.option_args[0]
	var domain_index : int = node_internal.argument_values["domain"]
	return domain_arg.meta["options"][domain_index]

func __get_control(arg : CardBehaviorArgument, type : ArgType) -> Control:
	var arg_capsule := PanelContainer.new()
	arg_capsule.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	arg_capsule.size_flags_vertical = Control.SIZE_EXPAND_FILL
	arg_capsule.add_theme_stylebox_override("panel", StyleBoxEmpty.new())
	var arg_cont : Control = HBoxContainer.new()
	arg_cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	arg_cont.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var label : Label = __new_label(arg.name, type)
	arg_cont.add_child(label)
	
	print("creating control for %s with type %s" % [arg.name, CardBehaviorArgument.ArgumentType.keys()[arg.type]])
	var argument_type : CardBehaviorArgument.ArgumentType = arg.type
	if argument_type == CardBehaviorArgument.ArgumentType.VARIANT:
		argument_type = __get_domain()
		print("(as %s)" % CardBehaviorArgument.ArgumentType.keys()[argument_type])
	match (argument_type):
		CardBehaviorArgument.ArgumentType.INT:
			if arg.name == "domain":
				arg_cont = OptionButton.new()
				var arg_type_int_to_key : Dictionary = {}
				for arg_type : StringName in CardBehaviorArgument.ArgumentType.keys():
					arg_type_int_to_key[CardBehaviorArgument.ArgumentType[arg_type]] = arg_type
				for arg_option : int in arg.meta["options"]:
					arg_cont.add_item(arg_type_int_to_key[arg_option].to_pascal_case())
				arg_cont.selected = __get_value_or_default(arg)
				label.queue_free()
				arg_capsule.add_child(arg_cont)
				return arg_capsule
			if type != ArgType.OUTPUT:
				if arg.meta.has("options"):
					var option_button := OptionButton.new()
					option_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					option_button.size_flags_vertical = Control.SIZE_EXPAND_FILL
					for arg_option : Variant in arg.meta["options"]:
						option_button.add_item(str(arg_option).to_pascal_case())
					option_button.selected = __get_value_or_default(arg)
					arg_cont.add_child(option_button)
				else:
					var spinbox := SpinBox.new()
					spinbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
					spinbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
					spinbox.allow_greater = true
					spinbox.allow_lesser = true
					spinbox.value = __get_value_or_default(arg)
					arg_cont.add_child(spinbox)	
		CardBehaviorArgument.ArgumentType.FLOAT:
			if type != ArgType.OUTPUT:
				var spinbox := SpinBox.new()
				spinbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				spinbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
				spinbox.allow_greater = true
				spinbox.allow_lesser = true
				spinbox.value = __get_value_or_default(arg)
				spinbox.step = 0.01
				arg_cont.add_child(spinbox)
		CardBehaviorArgument.ArgumentType.BOOL:
			if type != ArgType.OUTPUT:
				var checkbox := CheckBox.new()
				checkbox.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN if type == ArgType.INPUT else Control.SIZE_SHRINK_END
				checkbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
				if node_internal.argument_values.has(arg.name):
					checkbox.button_pressed = __get_value_or_default(arg)
				arg_cont.add_child(checkbox)
		CardBehaviorArgument.ArgumentType.STRING_NAME:
			if type != ArgType.OUTPUT:
				var line_edit := LineEdit.new()
				line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				line_edit.expand_to_text_length = true
				label.size_flags_horizontal = Control.SIZE_SHRINK_END
				if node_internal.argument_values.has(arg.name):
					line_edit.text = __get_value_or_default(arg)
				arg_cont.add_child(line_edit)
	if type != ArgType.OPTION:
		arg_cont.move_child(label, -1)
	arg_capsule.add_child(arg_cont)
	return arg_capsule

func _setup_options() -> void:
	var option_args : Array[CardBehaviorArgument] = node_internal.config.option_args	
	var has_domain_option : bool = false
	var domain_option : OptionButton = null

	for option : CardBehaviorArgument in option_args:
		var cont : Control = __get_control(option, ArgType.OPTION)
		if option.name == "domain":
			has_domain_option = true
			domain_option = cont.get_child(0)
		self.add_child(cont)
		
	if has_domain_option:
		domain_option.item_selected.connect(
			func(index : int) -> void:
				self.__set_domain(index)
				self._setup_inputs(true)
				self._setup_outputs(true)
		)
	
	if option_args.size() > 0:
		self.add_child(__new_dummy())

func _setup_inputs(overwrite : bool = false) -> void:
	var index_offset : int = -1
	if not overwrite: index_offset = self.get_child_count()
	else:
		if self.get_input_port_count() > 0:
			index_offset = self.get_input_port_slot(0)
	var input_args : Array[CardBehaviorArgument] = node_internal.config.input_args
	print(index_offset)
	for i in range(input_args.size()):
		var slot_index : int = index_offset + i
		var input_arg_cont : Control = __get_control(input_args[i], ArgType.INPUT)
		
		if overwrite:
			var existing : Control = self.get_child(slot_index)
			for child in existing.get_children():
				child.free()
			for child in input_arg_cont.get_children():
				child.reparent(existing)
		else:
			self.add_child(input_arg_cont)

		var input_arg : CardBehaviorArgument = input_args[i]
		var arg_type : CardBehaviorArgument.ArgumentType = input_arg.type
		if arg_type == CardBehaviorArgument.ArgumentType.VARIANT:
			arg_type = __get_domain()
		self.set_slot_enabled_left(slot_index, true)
		self.set_slot_type_left(slot_index, arg_type)
		self.set_slot_color_left(slot_index, CardBehaviorArgument.ArgumentColors[arg_type])

	if input_args.size() > 0 and not overwrite:
		self.add_child(__new_dummy())

func _setup_outputs(overwrite : bool = false) -> void:
	var index_offset : int = -1
	if not overwrite: index_offset = self.get_child_count()
	else:
		if self.get_output_port_count() > 0:
			index_offset = self.get_output_port_slot(0)
	var output_args : Array[CardBehaviorArgument] = node_internal.config.output_args
	print(index_offset)
	for i in range(output_args.size()):
		var slot_index : int = index_offset + i
		var output_arg_cont : Control = __get_control(output_args[i], ArgType.OUTPUT)
		
		if overwrite:
			var existing : Control = self.get_child(slot_index)
			for child in existing.get_children():
				child.free()
			for child in output_arg_cont.get_children():
				child.reparent(existing)
		else:
			self.add_child(output_arg_cont)

		var output_arg : CardBehaviorArgument = output_args[i]
		var arg_type : CardBehaviorArgument.ArgumentType = output_arg.type
		if arg_type == CardBehaviorArgument.ArgumentType.VARIANT:
			arg_type = __get_domain()
		self.set_slot_enabled_right(slot_index, true)
		self.set_slot_type_right(slot_index, arg_type)
		self.set_slot_color_right(slot_index, CardBehaviorArgument.ArgumentColors[arg_type])

	if output_args.size() > 0 and not overwrite:
		self.add_child(__new_dummy())
