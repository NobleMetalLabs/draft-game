class_name GetStatisticCBN
extends CardBehaviorNode

func _init() -> void:
	super("GetStatistic",
	[
		#CardBehaviorArgument.targetable("target"), 
		CardBehaviorArgument.tiered_indexed_options_statstic(),
	], 
	[
		CardBehaviorArgument.variant("value")
	],
	[
		CardBehaviorArgument.indexed_options("domain",
			[
				CardBehaviorArgument.ArgumentType.INT,
				CardBehaviorArgument.ArgumentType.FLOAT,
				CardBehaviorArgument.ArgumentType.BOOL,
				CardBehaviorArgument.ArgumentType.STRING_NAME,
			]
		),
	]
	)

