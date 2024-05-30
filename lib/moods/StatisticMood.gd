class_name StatisticMood
extends Mood

var statistic : StringName
var effect : Mood.MoodEffect
var source : ICardInstance
var amount : int

func _init(_statistic : StringName, _effect : Mood.MoodEffect, _source : ICardInstance, _amount : int = 1) -> void:
	self.statistic = _statistic
	self.effect = _effect
	self.source = _source
	self.amount = _amount