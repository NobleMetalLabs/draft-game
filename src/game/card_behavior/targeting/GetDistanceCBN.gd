class_name GetDistanceCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.targetable("target1"),
			CardBehaviorArgument.targetable("target2")
		], 
		[
			CardBehaviorArgument.float("distance")
		]
	) 

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	var target_component1 : TargetableComponent = inputs[0]
	var target1 : Node = target_component1.get_targetable()
	var target_component2 : TargetableComponent = inputs[1]
	var target2 : Node = target_component2.get_targetable()
	return [target1.get_position().distance_to(target2.get_position())]