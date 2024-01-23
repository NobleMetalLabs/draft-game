class_name FireSignalCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("signal"),
			CardBehaviorArgument.string_name("args?"),
		], 
		[]
	)

# func process(inputs : Array) -> Array:
	#return []