class_name FilterTargetsCBN
extends CardBehaviorNode

#TODO: This will be a nightmare
func _init() -> void:
	super(
	[
		CardBehaviorArgumentArray.targetable("input"),
		CardBehaviorArgument.string_name("field"),
		CardBehaviorArgument.variant("value", 
			[
				"int",
				"float",
				"StringName",
			]
		),
	], 
	[
		CardBehaviorArgumentArray.targetable("result"),
	]) 

# func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
# 	var hits : Array = []
# 	var targetables : Array = inputs[0]
# 	var field : String = inputs[1]
# 	var value : Variant = inputs[2]
# 	for tgtble : TargetableComponent in targetables:
# 		var target : Node = tgtble.get_target()
# 		if target.get(field) == value:
# 				hits.append(target)
# 	return [hits]