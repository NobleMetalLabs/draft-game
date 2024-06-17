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
	setup()

	header()
	body()

var node_to_edges : Dictionary = {} # [CardBehaviorNodeInstance, Array[CardBehaviorEdge]]
func setup() -> void:
	for node : CardBehaviorNodeInstance in card_behavior_graph.nodes:
		node_to_edges[node] = []
	for edge : CardBehaviorEdge in card_behavior_graph.edges:
		node_to_edges[edge.start_node].append(edge)
		node_to_edges[edge.end_node].append(edge)

func header() -> void:
	var extension : String = "extends CardLogic"
	var description : String = "static var description = \"%s\"" % card_behavior_graph.description
	a(extension)._cr().a(description)._cr(2)

func body() -> void:
	var signature : String = "func process(_gs : GamefieldState, _er : EffectResolver) -> void:"
	a(signature)._cr()._raise_tabs()

	_get_node_expressions()

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
	
	var stack := _go_deep_on_a_mf_node(nodes_for_pass[0])
	_expression_evaluation_on_a_stack_on_a_band_on_god(stack)

	print(nodes_for_pass)

var node_instances_to_expression : Dictionary = {} # [CardBehaviorNodeInstance, String]
func _get_node_expressions() -> void:
	for node : CardBehaviorNodeInstance in card_behavior_graph.nodes:
		node_instances_to_expression[node] = node.transpile()

func _go_deep_on_a_mf_node(node : CardBehaviorNodeInstance) -> Array[CardBehaviorNodeInstance]:
	print("going deep on node %s" % node.config.name)
	var the_things_we_r_gonna_do_stack : Array[CardBehaviorNodeInstance] = [node]
	var shit_that_is_alr : Array[CardBehaviorNodeInstance] = [node]
	for node_that_is_alr : CardBehaviorNodeInstance in shit_that_is_alr:
		for other_node : CardBehaviorNodeInstance in card_behavior_graph.nodes:
			if other_node in shit_that_is_alr: continue
			if other_node == node_that_is_alr: continue
			if not _are_all_of_nodes_inputs_processed(other_node, shit_that_is_alr): continue
			print("node %s is good to go" % other_node.config.name)
			shit_that_is_alr.append(other_node)
			the_things_we_r_gonna_do_stack.push_back(other_node)
	print("alr we went deep heres what we got")
	print(the_things_we_r_gonna_do_stack.map(func(_node : CardBehaviorNodeInstance) -> String: return _node.config.name))
	return the_things_we_r_gonna_do_stack

func _expression_evaluation_on_a_stack_on_a_band_on_god(stack : Array[CardBehaviorNodeInstance]) -> void:
	var lil_guy : CardBehaviorNodeInstance = stack.pop_back()
	var his_expression_when : String = node_instances_to_expression[lil_guy]
	print("filling for exp '%s'" % his_expression_when)
	var things_we_need_strings : Array = (his_expression_when.split("<") as Array).slice(1).map(func(st_string : String) -> String: return st_string.left(st_string.find(">")))
	print(things_we_need_strings)
	var things_we_need_exps : Array[String] = []
	for thing_we_need_name : String in things_we_need_strings:
		print("getting source for '%s'" % thing_we_need_name)
		var found : String = ""
		for edge : CardBehaviorEdge in node_to_edges[lil_guy]:
			if not edge.end_node == lil_guy: continue
			if lil_guy.config.input_args[edge.start_port].name != thing_we_need_name: continue
			found = node_instances_to_expression[edge.start_node]
		if found == "":
			if lil_guy.argument_values.has(thing_we_need_name):
				var arg : CardBehaviorArgument = (lil_guy.config.input_args + lil_guy.config.option_args).filter(func(_arg : CardBehaviorArgument) -> bool: return _arg.name == thing_we_need_name)[0]
				if arg.meta.has("options"):
					found = arg.meta['options'][lil_guy.argument_values[thing_we_need_name]]
				else:
					found = str(lil_guy.argument_values[thing_we_need_name])
			else:
				push_error("could not find source for '%s'" % thing_we_need_name)
		things_we_need_exps.append(found)
		print("found '%s'" % found)
	print(things_we_need_exps)

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



