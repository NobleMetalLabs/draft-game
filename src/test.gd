class_name Test
extends Node

func _ready() -> void:
	var arr : Array[int] = [2]
	for num in arr:
		print(num)
		arr.append(num * 2)
		if num > 100:
			return
