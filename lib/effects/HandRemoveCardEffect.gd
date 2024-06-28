class_name HandRemoveCardEffect
extends HandEffect

var card : ICardInstance
var destination : Genesis.CardZone
var leave_reason : Genesis.LeaveHandReason

func _init(_requester : Object, _player : Player, _card : ICardInstance, _destination : Genesis.CardZone, _leave_reason : Genesis.LeaveHandReason) -> void:
	self.requester = _requester
	self.player = _player
	self.card = _card
	self.leave_reason = _leave_reason

func _to_string() -> String:
	return "HandRemoveCardEffect(%s,%s,%s,%s)" % [self.player, self.card, self.leave_reason, self.animation]

func resolve(effect_resolver : EffectResolver) -> void:
	var card_stats := IStatisticPossessor.id(self.creature)
	var card_object : Variant = self.creature.get_object()

	if card_object is CardInHand:
		self.player.cards_in_hand.erase(card_object)
		card_stats.set_statistic(Genesis.Statistic.IS_IN_HAND, false)
		self.player.cards_in_limbo.append(self.creature)
		
		match self.destination:
			Genesis.CardZone.DECK:
				var player_owner : Player = self.creature.player
				effect_resolver.request_effect(DeckAddCardEffect.new(
					self, player_owner, ICardInstance.id(self.creature)
				))
			Genesis.CardZone.FIELD:
				effect_resolver.request_effect(CreatureSpawnEffect.new(
					self, card,
				))
			Genesis.CardZone.HAND:
				assert(false, "bro is trippin")
	else:
		pass
		#reverse mode

	var card_instance := ICardInstance.id(self.card)
	IStatisticPossessor.id(self.card).set_statistic(Genesis.Statistic.IS_IN_HAND, false)

	if leave_reason == Genesis.LeaveHandReason.DISCARDED or leave_reason == Genesis.LeaveHandReason.BURNED:
		effect_resolver.request_effect(DeckAddCardEffect.new(
			self.requester, self.player, card_instance
		))

		if leave_reason == Genesis.LeaveHandReason.BURNED:
			effect_resolver.request_effect(HandAddCardEffect.new(
				self.requester, self.player
			))
	if leave_reason == Genesis.LeaveHandReason.PLAYED:
		effect_resolver.request_effect(CreatureSpawnEffect.new(
			self.requester, card_instance
		))

	Router.client_ui.refresh_hand_ui() #This doesn't act completely as expected. Cards can't be nowhere, so they remain in the last location while statistics report a limbo state. 
	# Basically a card not in the hand may still render in the hand.
	# This is generally indiciative of below.
	# TODO: Remove UI updates from effect resolution. EffectResolver should provide effects to ClientUI wholesale, and ClientUI should handle them seperately.
	
