class_name CreatureLeaveFieldEffect
extends CreatureEffect

var source : ICardInstance
var destination : Genesis.CardZone
var reason : Genesis.LeaveFieldReason

func _init(_requester : Object, _creature : ICardInstance, _source : ICardInstance, _destination : Genesis.CardZone = Genesis.CardZone.DECK, _reason : Genesis.LeaveFieldReason = Genesis.LeaveFieldReason.DIED) -> void:
	self.requester = _requester
	self.creature = _creature
	self.source = _source
	self.destination = _destination
	self.reason = _reason

func _to_string() -> String:
	return "CreatureLeaveFieldEffect(%s,%s,%s)" % [self.creature, self.source, self.reason]

func resolve(effect_resolver : EffectResolver) -> void:
	var card_stats := IStatisticPossessor.id(self.creature)
	var card_object : Variant = self.creature.get_object()

	if card_object is CardOnField:
		self.player.cards_on_field.erase(card_object)
		card_stats.set_statistic(Genesis.Statistic.IS_ON_FIELD, false)
		self.player.cards_in_limbo.append(self.creature)
		
		match self.destination:
			Genesis.CardZone.DECK:
				var player_owner : Player = self.creature.player
				effect_resolver.request_effect(DeckAddCardEffect.new(
					self, player_owner, ICardInstance.id(self.creature)
				))
			Genesis.CardZone.HAND:
				var player_owner : Player = self.creature.player
				# effect_resolver.request_effect(HandAddCardEffect.new(
				# 	self, player_owner, ICardInstance.id(self.creature)
				# ))
			Genesis.CardZone.FIELD:
				assert(false, "bro is trippin")
	else:
		pass
		#reverse mode