class_name CardBehaviorGraphTranspiler
extends RefCounted

var card_behavior_graph : CardBehaviorGraph
var output : String 

func init(_card_behavior_graph : CardBehaviorGraph) -> String:
	card_behavior_graph = _card_behavior_graph
	output = ""
	
	header()

	return output

func header() -> void:
	var extension : String = "extends CardLogic"
	var description : String = "static var description = \"%s\"" % card_behavior_graph.description
	a(extension)._cr().a(description)._cr(3)

func body() -> void:
	var signature : String = "func process(_gs : GamefieldState, _er : EffectResolver) -> void:"
	a(signature)._cr()._raise_tabs()

	# ...
	# guard scopes?
	

func a(string : String) -> CardBehaviorGraphTranspiler:
	output += _tabs() + string
	return self

func _cr(count : int = 1) -> CardBehaviorGraphTranspiler:
	var returns : String = "\n".repeat(count)
	output += returns
	return self

var tabs : int = 0
func raise_tabs() -> void: tabs += 1
func lower_tabs() -> void: tabs -= 1
func _tabs() -> String:
	return "\t".repeat(tabs)



