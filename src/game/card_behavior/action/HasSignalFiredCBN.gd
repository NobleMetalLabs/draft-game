class_name HasSignalFiredCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("signal"),
		], 
		[
			CardBehaviorArgument.bool("has_fired"),
		]
	)

# func process(inputs : Array) -> Array:
	#return []