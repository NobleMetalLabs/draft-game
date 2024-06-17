class_name GetSelfCBN
extends CardBehaviorNode

func _init() -> void:
	super("GetSelf",
		[], 
		[
			CardBehaviorArgument.object("self")
		],
	)
	transpilation("instance_owner")