class_name OperationCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.bool("num1"), 
			CardBehaviorArgument.bool("num2"),
			CardBehaviorArgument.string_name("operation"),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

# func process(api : CardBehaviorAPI, inputs : Array) -> Array:
	#return []