class_name OperationCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.bool("num1"), 
			CardBehaviorArgument.bool("num2"),
			CardBehaviorArgument.string_name("operation"),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

# func process(inputs : Array) -> Array:
	#return []