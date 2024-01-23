class_name FilterTargetsCBN
extends CardBehaviorNode

#TODO: This will be a nightmare
func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
	[
		CardBehaviorArgumentArray.targetable("input"),
		CardBehaviorArgument.string_name("field"),
		CardBehaviorArgument.string_name("value"),
	], 
	[
		CardBehaviorArgumentArray.targetable("result"),
	]) 