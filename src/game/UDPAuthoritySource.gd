class_name UDPAuthoritySource
extends AuthoritySource

var input : Callable
var output : Signal

func _init(_input : Callable, _output : Signal) -> void:
	input = _input
	output = _output

func _ready() -> void:
	output.connect(
		func(raw : PackedByteArray) -> void:
			print("Output signal recieved")
			var string : String = raw.get_string_from_utf8()
			print("Recieved action %s" % string)
			var action : Action = ActionSerializer.deserialize_action(string)
			reflect_action.emit(action)
	)

func request_action(action : Action) -> void:
	print(action)
	var string : String = ActionSerializer.serialize_action(action)
	print(string)
	input.call(string.to_utf8_buffer())
