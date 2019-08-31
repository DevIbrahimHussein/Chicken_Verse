extends Node

var player_scene = preload('res://Player/Player.tscn')
var input_reader_controller_obj = load('res://phantom_movement/cardinal_input_reader.gd')
var input_controller_obj = load('res://phantom_movement/input_movement.gd')
var frame_action = load('res://phantom_movement/frame_action.gd')

var watcher
var players = []
var control_readers = []

func _ready():
	watcher = $Watcher
	restart_level()

func restart_level():
	watcher.init_watchers()
	$Position2D.position.x = 0
	for player in players:
		player.queue_free()
	players = []
	players.append(spawn_player(input_controller_obj.new()))
	for reader in control_readers:
		reader.reset()
		var phantom_player = spawn_player(reader)
		phantom_player.modulate = Color(0.6, 0.6, 0.6)
		players.append(phantom_player)

func spawn_player(movement_controller):
	var player = player_scene.instance()
	player.get_node('MoveEngine').set_move_controller(movement_controller)
	player.position = Vector2(80, 120)
	add_child(player)
	return player

func _process(delta):
	if (current_player().position.x > 600):
		control_readers.append(watcher.get_reader())
		restart_level()
		
func current_player():
	return players[0]