extends Node


var thread = Thread.new()
var thread2 = Thread.new()

var network_position = Vector3.ZERO
var udp := PacketPeerUDP.new()
var connected = false
var DIR = OS.get_executable_path().get_base_dir()
var interpreter_path = "/home/sujith/Documents/programs/venv/bin/python"
var pyscript_path = ''
var udp_terminated = false
var _temp_message
var _split_message

func _ready():
	udp.connect_to_host("127.0.0.1", 8000)
	thread.start(python_thread)
	thread2.start(my_function)

func my_function():
	while true:
		if udp.get_available_packet_count() > 0:
			_temp_message = udp.get_packet().get_string_from_utf8()
			udp.put_packet('connected'.to_utf8_buffer())
			if _temp_message == "stop":
				udp_terminated = true
			elif _temp_message == "none":
				pass
			else:
				_split_message = _temp_message.split(",")
				var net_x = float(_split_message[0])
				var net_y = float(_split_message[1])
				var net_z = float(_split_message[2])
				network_position = Vector3(net_x, net_y, net_z)/10                                                       
				#print(network_position)
				connected = true
		else:
			udp.put_packet('dummy'.to_utf8_buffer())


func python_thread():
	var output = []
	print('thread function')
	pyscript_path = "/home/sujith/Documents/programs/stream_3d_2.py"

	OS.execute(interpreter_path, [pyscript_path], output)
	print(output)
