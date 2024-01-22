class_name MostRecentAttackerCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[CardBehaviorArgument.targetable("subject")], 
		[CardBehaviorArgument.targetable("attacker")],
	)

# func process(inputs : Array) -> Array:
	#return []