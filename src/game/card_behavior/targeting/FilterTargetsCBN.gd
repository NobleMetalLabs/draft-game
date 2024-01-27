class_name FilterTargetsCBN
extends CardBehaviorNode

#TODO: This will be a nightmare
func _init() -> void:
	super(
	[
		CardBehaviorArgumentArray.targetable("input"),
		CardBehaviorArgument.string_name("field"),
		CardBehaviorArgument.string_name("value"),
	], 
	[
		CardBehaviorArgumentArray.targetable("result"),
	]) 