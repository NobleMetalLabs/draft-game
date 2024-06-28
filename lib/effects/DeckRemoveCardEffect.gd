class_name DeckRemoveCardEffect
extends DeckEffect

var card : ICardInstance
var destination : Genesis.CardZone
var leave_reason : Genesis.LeaveHandReason

func _init(_requester : Object, _player : Player, _card : ICardInstance, _destination : Genesis.CardZone, _leave_reason : Genesis.LeaveHandReason) -> void:
	self.requester = _requester
	self.player = _player
	self.card = _card
	self.destination = _destination
	self.leave_reason = _leave_reason

func _to_string() -> String:
	return "DeckRemoveCardEffect(%s,%s,%s,%s)" % [self.player, self.card, self.leave_reason, self.animation]

func resolve(effect_resolver : EffectResolver) -> void:
	var card_stats := IStatisticPossessor.id(self.card)
	var card_object : Variant = self.card.get_object()

	if card_object is CardInDeck:
		self.player.cards_on_field.erase(card_object)
		card_stats.set_statistic(Genesis.Statistic.IS_IN_DECK, false)
		self.player.cards_in_limbo.append(self.card)
		
		match self.destination:
			Genesis.CardZone.FIELD:
				effect_resolver.request_effect(CreatureSpawnEffect.new(
					self, self.card
				))
			Genesis.CardZone.HAND:
				effect_resolver.request_effect(DeckAddCardEffect.new(
					self, self.player, self.card
				))
			Genesis.CardZone.DECK:
				assert(false, "bro is trippin")
	else:
		pass
		#reverse mode