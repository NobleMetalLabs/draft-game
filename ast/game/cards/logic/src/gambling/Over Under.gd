extends CardLogic

static var description : StringName = "Targetted creature is placed in it's owners deck, third from the top."

func process(_gs : GamefieldState, effect_resolver : EffectResolver) -> void:
	var my_stats := IStatisticPossessor.id(instance_owner)
	if my_stats.get_statistic(Genesis.Statistic.HAS_TARGET):
		var target : ICardInstance = my_stats.get_statistic(Genesis.Statistic.TARGET)
		effect_resolver.request_effect(
			DeckAddCardEffect.new(
				instance_owner,
				target.player,
				target,
				false,
				false,
				false,
				2,
			)
		)
	
	