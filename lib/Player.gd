class_name Player
extends Node

var freeze_cooldown
func start_freeze_cooldown() -> void:
	freeze_cooldown = get_tree().create_timer(60)
