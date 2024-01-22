class_name CompareCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.bool("a"), 
			CardBehaviorArgument.bool("b"),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

# func process(inputs : Array) -> Array:
	#return []