class_name ModifyStatisticCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
	[
		CardBehaviorArgument.targetable("target"), 
		CardBehaviorArgument.string_name("stat_name"),
		CardBehaviorArgument.string_name("amount"),
	], [],
	)

# func process(inputs : Array) -> Array:
	#return []