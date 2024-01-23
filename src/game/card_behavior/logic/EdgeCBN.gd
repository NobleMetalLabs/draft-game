class_name EdgeCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.bool("input"), 
			CardBehaviorArgument.int("length"),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

# func process(inputs : Array) -> Array:
	#return []