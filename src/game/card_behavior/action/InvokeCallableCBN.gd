class_name InvokeCallableCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("name"),
			CardBehaviorArgument.string_name("args?"),
		], 
		[]
	)

# func process(inputs : Array) -> Array:
	#return []