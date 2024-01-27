class_name GetSelfCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[], 
		[CardBehaviorArgument.targetable("self")]
	)

# func process(api : CardBehaviorAPI, inputs : Array) -> Array:
	#return [api.get_self()]