class_name RequestTargetsCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[], 
		[CardBehaviorArgumentArray.targetable("attacker")],
	)

# func process(inputs : Array) -> Array:
	#return []