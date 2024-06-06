class_name CreatureActivateAction
extends CreatureAction

func _init(_creature : CardOnField) -> void:
	self.creature = _creature

func _to_string() -> String:
	return "CreatureActivateAction(%s)" % self.creature

func to_effect() -> CreatureActivateEffect:
	return CreatureActivateEffect.new(creature)