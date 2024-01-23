class_name CardBehaviorArgument
extends Resource

var type : StringName
var name : StringName

func _init() -> void:
	push_error("CardBehaviorArgument is not to be instanced manually. Use the static functions to create new instances.")

static func int(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "int"
	argument.name = _name
	return argument

static func float(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "float"
	argument.name = _name
	return argument

static func bool(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "bool"
	argument.name = _name
	return argument

static func string_name(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "StringName"
	argument.name = _name
	return argument

static func area(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "Area2D"
	argument.name = _name
	return argument

static func targetable(_name : StringName) -> CardBehaviorArgument:
	var argument : CardBehaviorArgument = CardBehaviorArgument.new()
	argument.type = "TargetableComponent"
	argument.name = _name
	return argument