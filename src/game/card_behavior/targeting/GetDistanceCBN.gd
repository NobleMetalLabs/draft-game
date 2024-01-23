class_name GetDistanceCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.targetable("target1"),
			CardBehaviorArgument.targetable("target2")
		], 
		[
			CardBehaviorArgument.float("distance")
		]
	) 