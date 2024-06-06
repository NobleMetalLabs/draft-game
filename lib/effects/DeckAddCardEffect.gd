class_name DeckAddCardEffect
extends PlayerEffect

var card : ICardInstance
var as_marked : bool
var keep_stats : bool
var keep_moods : bool

func _init(_player : Player, _card : ICardInstance, _as_marked : bool = true, _keep_stats : bool = false, _keep_moods : bool = false) -> void:
	self.player = _player
	self.card = _card
	self.as_marked = _as_marked
	self.keep_stats = _keep_stats
	self.keep_moods = _keep_moods
	
func _to_string() -> String:
	return "DeckAddCardEffect(%s,%s,%s,%s)" % [self.player, self.card, self.keep_stats, self.keep_moods]

func resolve(effect_resolver : EffectResolver) -> void:
	var previous_object_owner : Object = self.card.get_object()
	
	var idents : Array[Identifier] = [card]
	if keep_stats:
		idents.append(IStatisticPossessor.id(self.card))
	if keep_moods:
		idents.append(IMoodPossessor.id(self.card))
	var card_in_deck := CardInDeck.new(idents)
	player.deck.add_card(card_in_deck)

	var card_stats := IStatisticPossessor.id(card)

	if previous_object_owner != null:
		if previous_object_owner is CardInHand:
			self.player.cards_in_hand.erase(previous_object_owner)
			card_stats.set_statistic(Genesis.Statistic.IS_IN_HAND, false)
		if previous_object_owner is CardOnField:
			self.player.cards_on_field.erase(previous_object_owner)
			card_stats.set_statistic(Genesis.Statistic.IS_ON_FIELD, false)
		previous_object_owner.queue_free()
	card_stats.set_statistic(Genesis.Statistic.IS_IN_DECK, true)
	
	if self.as_marked:
		card_stats.set_statistic(Genesis.Statistic.IS_MARKED, true)
		card_stats.set_statistic(Genesis.Statistic.WAS_JUST_MARKED, true)
		var was_just_marked_expire_effect := SetStatisticEffect.new(
			card_stats, Genesis.Statistic.WAS_JUST_MARKED, false
		)
		was_just_marked_expire_effect.requester = self.requester
		effect_resolver.request_effect(was_just_marked_expire_effect)