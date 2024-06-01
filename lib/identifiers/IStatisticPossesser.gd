class_name IStatisticPossessor
extends Identifier
## 統計情報を持つクラスのインターフェース

static func id(node : Node) -> IStatisticPossessor:
	if node is Identifier:
		node = node.get_object()
	if node == null: return null
	if not node.has_node("IStatisticPossessor"): return null
	return node.get_node("IStatisticPossessor")

const DEFAULTS : Dictionary = {
	"health" : 10,
}

var _statistic_db : Dictionary

func _init() -> void:
	self.name = "IStatisticPossessor"
	_statistic_db = {}

func get_statistic(statistic_name : Genesis.Statistic) -> Variant:
	var value : Variant = _statistic_db.get(statistic_name, DEFAULTS.get(statistic_name, null))
	var mp_sibling := IMoodPossessor.id(self)
	if mp_sibling != null:
		return mp_sibling._get_statistic(statistic_name, value)
	return value

func set_statistic(statistic_name : Genesis.Statistic, value : Variant) -> void:
	print("%s set to %s" % [statistic_name, value])
	_statistic_db[statistic_name] = value

func modify_statistic(statistic_name : Genesis.Statistic, value : Variant) -> void:
	var current_value : Variant = get_statistic(statistic_name)
	var new_value : Variant = current_value + value
	set_statistic(statistic_name, new_value)
