class_name CreatureLeaveFieldEffectCBN
extends CardBehaviorNode

func _init() -> void:
	super("CreatureLeaveFieldEffect",
		[
			CardBehaviorArgument.object("creature"),
			CardBehaviorArgument.object("source"),
			CardBehaviorArgument.indexed_options("reason",
				Genesis.LeaveFieldReason.keys()
			),
		],
	)

