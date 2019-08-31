extends Node



var player_scene = preload('res://Player/Player.tscn')
var input_reader_controller_obj = load('res://phantom_movement/cardinal_input_reader.gd')
var input_controller_obj = load('res://phantom_movement/input_movement.gd')
var frame_action = load('res://phantom_movement/frame_action.gd')

var watcher
var players = []
var control_readers = []

var game_ended = false

func _ready():
	watcher = $Watcher
	$RunTimer.connect("timeout", self, 'restart_level')
	Globals.emitter.connect('game_end', self, 'on_game_end')
	reset_game()
	

func reset_game():
	game_ended = false
	control_readers = []
	restart_level()
	Globals.emitter.emit('game_start')
	

func on_game_end():
	if (game_ended):
		return
	game_ended = true
	destroy_players()
	print('Dead')

func restart_level():
	$RunTimer.stop()
	destroy_players()
	watcher.init_watchers()
	players.append(spawn_player(input_controller_obj.new()))
	for reader in control_readers:
		reader.reset()
		var phantom_player = spawn_player(reader)
		phantom_player.modulate = Color(0.6, 0.6, 0.6)
		players.append(phantom_player)
	Globals.emitter.emit('run_start')
		
func destroy_players():
	for player in players:
		player.queue_free()
	players = []
	
func on_run_end():
	destroy_players()
	$RunTimer.start()
	Globals.emitter.emit('run_end')

func spawn_player(movement_controller):
	var player = player_scene.instance()
	player.get_node('MoveEngine').set_move_controller(movement_controller)
	player.position = Vector2(80, 120)
	add_child(player)
	return player

func _process(delta):
	if (players.size() == 0):
		return
	
	for player in players:
		if (player.position.x > 600):
			player.modulate = Color(1, 1, 1, 0)
			
	if (current_player().position.x > 600):
		control_readers.append(watcher.get_reader())
		on_run_end()
		
func current_player():
	return players[0]