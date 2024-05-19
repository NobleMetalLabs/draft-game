#class_name MultiplayerManager
extends Node

const ADDRESS : String = "127.0.0.1"
const PORT : int = 9999 

var server : UDPServer = null
var client : PacketPeerUDP = null
var peers : Array[PacketPeerUDP] = []

func host_game() -> void:
	server = UDPServer.new()
	server.listen(PORT)

func join_game() -> void:
	client = PacketPeerUDP.new()
	client.connect_to_host(ADDRESS, PORT)

func _process(_delta : float) -> void:
	if server != null:
		_server_process()
		return
	if client != null:
		_client_process()

func _server_process() -> void:
	server.poll() # Important!
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet : PackedByteArray = peer.get_packet()
		push_warning("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		push_warning("Received data: %s" % [packet.get_string_from_utf8()])
		# Reply so it knows we received the message.
		peer.put_packet(packet)
		# Keep a reference so we can keep contacting the remote peer.
		peers.append(peer)
		AuthoritySourceProvider.authority_source = UDPAuthoritySource.new(server_input, server_output)

	for peer in peers:
		while peer.get_available_packet_count() > 0:
			var packet : PackedByteArray = peer.get_packet()
			server_input(packet)
			server_output.emit(packet)

func server_input(raw : PackedByteArray) -> void:
	push_warning("Server puts raw %s" % [raw])
	for peer in peers:
		peer.put_packet(raw)

signal server_output(raw : PackedByteArray)

var connected : bool = false
func _client_process() -> void:
	if !connected:
		# Try to contact server
		client.put_packet("{}".to_utf8_buffer())
		
	if client.get_available_packet_count() > 0:
		if !connected:
			AuthoritySourceProvider.authority_source = UDPAuthoritySource.new(client_input, client_output)
			connected = true
			return
		var packet : PackedByteArray = client.get_packet()
		push_warning("Client reads %s" % packet)
		client_output.emit(packet)

func client_input(raw : PackedByteArray) -> void:
	push_warning("Client puts raw %s" % [raw])
	client.put_packet(raw)

signal client_output(raw : PackedByteArray)