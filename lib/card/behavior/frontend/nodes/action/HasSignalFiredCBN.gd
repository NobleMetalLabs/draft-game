class_name HasSignalFiredCBN
extends CardBehaviorNode

func _init() -> void:
	super("HasSignalFired",
		[
			CardBehaviorArgument.targetable("target"), 
			CardBehaviorArgument.string_name("signal"),
		], 
		[
			CardBehaviorArgument.bool("has_fired"),
		]
	)

