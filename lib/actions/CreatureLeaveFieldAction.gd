class_name CreatureLeaveFieldAction
extends CreatureAction

var source : ICardInstance
var reason : Genesis.LeaveFieldReason

func _init(_creature : ICardInstance, _source : ICardInstance, _reason : Genesis.LeaveFieldReason) -> void:
	self.creature = _creature
	self.source = _source
	self.reason = _reason

func _to_string() -> String:
	return "CreatureLeaveFieldAction(%s,%s,%s)" % [self.creature, self.source, self.reason]

func to_effect() -> CreatureLeaveFieldEffect:
	return CreatureLeaveFieldEffect.new(self, creature, source, reason)