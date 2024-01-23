class_name GetSelfCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[], 
		[CardBehaviorArgument.targetable("self")]
	)

# func process(inputs : Array) -> Array:
	#return [api.get_self()]