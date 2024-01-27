class_name FireSignalCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("signal"),
			CardBehaviorArgument.string_name("args?"),
		], 
		[]
	)

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	var targetable : TargetableComponent = inputs[0]
	var target : Node = targetable.get_target()	
	var signal_name : StringName = inputs[1]
	var args : Array = inputs[2]
	target.emit_signal(signal_name, args)
	return []