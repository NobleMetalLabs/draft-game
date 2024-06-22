extends CardLogic

static var description : StringName = "Target creature attacks itself."

func process(_gs : GamefieldState, _effect_resolver : EffectResolver) -> void:
	var my_stats := IStatisticPossessor.id(instance_owner)
	if my_stats.get_statistic(Genesis.Statistic.HAS_TARGET):
		var target : ITargetable = my_stats.get_statistic(Genesis.Statistic.TARGET)
		var target_card : CardOnField = target.get_object()
		AuthoritySourceProvider.authority_source.request_action(
			CreatureAttackAction.new(
				target_card, target_card, IStatisticPossessor.id(target).get_statistic(Genesis.Statistic.STRENGTH)
			)
		)
		
# Gain Experience
# extends CardLogic

# static var description : StringName = "Whenever Target Creature attacks, it gains +1 power."

