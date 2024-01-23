class_name CountCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.bool("pInput"), 
			CardBehaviorArgument.bool("sInput"),
			CardBehaviorArgument.int("delta"),
		], 
		[
			CardBehaviorArgument.int("result")
		]
	)

# func process(inputs : Array) -> Array:
	#return []