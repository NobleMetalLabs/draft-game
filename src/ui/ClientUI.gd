class_name ClientUI
extends Control

@onready var card_info_panel : CardInfoPanel = $"%CARD-INFO-PANEL"
@onready var target_sprite : Sprite2D = $TargetSprite
@onready var hand_ui : HandUI = $"%HAND-UI"

@export var gamefield : Gamefield

func _input(event : InputEvent) -> void:
	if not event is InputEventKey: return
	if Input.is_action_just_pressed("ui_inspect"):
		if hand_ui.hovered_hand_card != null:
			card_info_panel.set_card_metadata(hand_ui.hovered_hand_card.metadata)
			card_info_panel.display()
		else:
			var hovered_card : ICardInstance = ICardInstance.id(gamefield.get_hovered_card())
			if hovered_card != null:
				card_info_panel.set_card_metadata(hovered_card.metadata)
				card_info_panel.display()
				#update_target_sprite(hovered_card.target)
			else:
				card_info_panel.undisplay()
				#update_target_sprite(null)

func get_hovered_card() -> ICardInstance:
	var gc : ICardInstance = ICardInstance.id(gamefield.get_hovered_card())
	var hnd : ICardInstance = ICardInstance.id(hand_ui.hovered_hand_card)
	if gc != null: return gc
	if hnd != null: return hnd
	return null

func refresh_hand_ui() -> void:
	hand_ui._refresh_hand()

func update_target_sprite(target : ICardInstance) -> void:
	target = target.get_object()
	if target == null: target_sprite.hide()
	else:
		target_sprite.show()
		target_sprite.position = target.position

func _create_card_ghost(hand_card : CardInHand) -> void:
	var new_card_ghost := CardGhost.new(hand_card)
	self.add_child(new_card_ghost, true)
	
	new_card_ghost.was_placed.connect(
		func(_position : Vector2) -> void:
			var new_card := CardOnField.new(gamefield, [
				ICardInstance.id(hand_card),
				IStatisticPossessor.id(hand_card),
				IMoodPossessor.id(hand_card),
			])
			AuthoritySourceProvider.authority_source.request_action(
				CreatureSpawnAction.new(
					new_card,
					_position,
				)
			)
			AuthoritySourceProvider.authority_source.request_action(
				HandRemoveCardAction.new(
					Router.gamefield.players[0],
					hand_card,
					Genesis.LeaveReason.PLAYED,
					Genesis.CardRemoveAnimation.PLAY,
				)
			)
	)
