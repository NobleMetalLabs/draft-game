class_name CardBehaviorGraphTranspiler
extends RefCounted

var card_behavior_graph : CardBehaviorGraph
var output : String 

static func transpile(cbg : CardBehaviorGraph) -> String:
	var ntp := CardBehaviorGraphTranspiler.new()
	ntp._transpile(cbg)
	return ntp.output

func _transpile(_card_behavior_graph : CardBehaviorGraph) -> void:
	card_behavior_graph = _card_behavior_graph
	output = ""
	
	header()
	body()

func header() -> void:
	var extension : String = "extends CardLogic"
	var description : String = "static var description = \"%s\"" % card_behavior_graph.description
	a(extension)._cr().a(description)._cr(2)

func body() -> void:
	var signature : String = "func process(_gs : GamefieldState, _er : EffectResolver) -> void:"
	a(signature)._cr()._raise_tabs()
	var nodes_processed : Array[CardBehaviorNodeInstance] = []
	var nodes_for_pass : Array[CardBehaviorNodeInstance] = []
	for node : CardBehaviorNodeInstance in card_behavior_graph.nodes:
		print("checking node %s" % node.config.name)
		print("node inputs %s" % node.config.input_args.size())
		if node.config.input_args.size() > 1: continue
		var arg_one : CardBehaviorArgument = node.config.input_args[0]
		print("arg one %s" % arg_one.name)
		if arg_one.name != "run": continue
		if not node.argument_values.has("run"): continue
		if node.argument_values["run"] != true: continue
		nodes_for_pass.append(node)
	
	for node : CardBehaviorNodeInstance in nodes_for_pass:
		print("processing node %s" % node.config.name)
		var is_node_run_conditional : bool = _is_node_run_conditional(node)
		if is_node_run_conditional: 
			a("if output of previous")._cr()
			_raise_tabs()
		a(node.transpile())._cr()
		nodes_processed.append(node)
		for other_node : CardBehaviorNodeInstance in card_behavior_graph.nodes:
			if other_node in nodes_processed: continue
			if other_node in nodes_for_pass: continue
			if other_node == node: continue
			if not _are_all_of_nodes_inputs_processed(other_node, nodes_processed): continue
			nodes_for_pass.append(other_node)

	print(nodes_for_pass)


func _are_all_of_nodes_inputs_processed(node : CardBehaviorNodeInstance, nodes_processed : Array[CardBehaviorNodeInstance]) -> bool:
	print("are all inputs processed for node %s?" % node.config.name)
	for edge : CardBehaviorEdge in card_behavior_graph.edges:
		if not edge.end_node == node: continue
		print("checking edge from %s to %s" % [edge.start_node.config.name, edge.end_node.config.name])
		if not edge.start_node in nodes_processed: 
			print("node %s not processed" % edge.start_node.config.name)
			return false
	return true

func _is_node_run_conditional(node : CardBehaviorNodeInstance) -> bool:
	print("is node %s run conditional?" % node.config.name)
	var working_node : CardBehaviorNodeInstance = node
	for edge : CardBehaviorEdge in card_behavior_graph.edges:
		print("checking edge from %s to %s" % [edge.start_node.config.name, edge.end_node.config.name])
		if not edge.end_node == working_node: continue
		if not edge.end_port == 0: continue
		if not edge.start_port == 0: 
			print("node %s has non-run input" % node.config.name)
			return true
	return false
			
func a(string : String) -> CardBehaviorGraphTranspiler:
	print(tabs)
	output += _tabs() + string
	return self

func _cr(count : int = 1) -> CardBehaviorGraphTranspiler:
	var returns : String = "\n".repeat(count)
	output += returns
	return self

var tabs : int = 0
func _raise_tabs() -> void: tabs += 1
func _lower_tabs() -> void: tabs -= 1
func _tabs() -> String:
	return "\t".repeat(tabs)



