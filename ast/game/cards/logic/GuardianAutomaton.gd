extends CardLogic

static var description : StringName = "When this creature dies, gain 3 health."

func process() -> void:
	var my_stats := IStatisticPossessor.id(instance_owner)
	if my_stats.get_statistic("just_died"):
		var my_player : Player = instance_owner.player
		IStatisticPossessor.id(my_player).modify_statistic("health", 3)



# RevengerAutomaton
# extends CardLogic

# static var description : StringName = "When any friendly creature dies, this creature gains Anger."

# func process() -> void:
#	pass