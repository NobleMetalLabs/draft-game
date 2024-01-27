class_name InvokeCallableCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("name"),
			CardBehaviorArgument.string_name("args?"),
		], 
		[]
	)

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	var target_component : TargetableComponent = inputs[0]
	var target : Node = target_component.get_targetable()
	var name : String = inputs[1]
	var args : Array = inputs[2]
	target.callv(name, args)	
	return []