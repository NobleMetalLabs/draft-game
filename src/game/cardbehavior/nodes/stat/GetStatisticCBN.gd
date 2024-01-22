class_name GetStatisticCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
	[
		CardBehaviorArgument.targetable("target"), 
		CardBehaviorArgument.string_name("stat_name"),
	], 
		[CardBehaviorArgument.string_name("value")],
	)

# func process(inputs : Array) -> Array:
	#return []