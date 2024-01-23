class_name AllTargetsInAreaCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[CardBehaviorArgument.area("area")], 
		[CardBehaviorArgumentArray.targetable("hits")],
	)