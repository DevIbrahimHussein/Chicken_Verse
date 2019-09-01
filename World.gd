extends Node

var player_scene = preload('res://Player/Player.tscn')
var input_reader_controller_obj = load('res://phantom_movement/cardinal_input_reader.gd')
var input_controller_obj = load('res://phantom_movement/input_movement.gd')
var frame_action = load('res://phantom_movement/frame_action.gd')

var player_start_pos = Vector2(120, 240)
var level_width = 1700
var watcher
var players = []
var control_readers = []
var camera_anchor
var camera_edge_offset

var game_ended = false

func _ready():
	watcher = $Watcher
	camera_anchor = $Position2D
	camera_edge_offset = camera_anchor.position.x + $Position2D/CameraEdgeIndicator.position.x
	$NewRunTimer.connect("timeout", self, 'restart_run')
	Globals.emitter.connect('game_end', self, 'on_game_end')
	Globals.emitter.connect('game_start', self, 'reset_game')
	reset_game()
	

func reset_game():
	game_ended = false
	control_readers = []
	Globals.completed_runs_count = 0
	restart_run()
	
func on_game_end():
	if (game_ended):
		return
	game_ended = true
	destroy_players()

func restart_run():
	$NewRunTimer.stop()
	destroy_players()
	watcher.init_watchers()
	var current_player = spawn_player(input_controller_obj.new())
	players.append(current_player)
	current_player.set_as_main_player()
	current_player.blink()
	current_player.z_index = 1
	for reader in control_readers:
		reader.reset()
		var modulate_ratio = 0.7
		var phantom_player = spawn_player(reader)
		phantom_player.modulate = Color(modulate_ratio, modulate_ratio, modulate_ratio)
		players.append(phantom_player)
	Globals.emitter.emit('run_start', players.size())
		
func destroy_players():
	for player in players:
		player.queue_free()
	players = []
	
func on_run_end():
	destroy_players()
	$NewRunTimer.start()
	$Position2D/WinChickenCall.play(0)
	Globals.emitter.emit('run_end')

func spawn_player(movement_controller):
	var player = player_scene.instance()
	player.get_node('MoveEngine').set_move_controller(movement_controller)
	player.position = player_start_pos
	add_child(player)
	return player

func _process(delta):
	if (game_ended && Input.is_action_just_pressed("ui_accept")):
		Globals.emitter.emit('game_start')
	var xCamera = camera_anchor.position.x + camera_edge_offset
	var widthViewport = OS.window_size.x
	
	if (players.size() == 0):
		return
	
	for player in players:
		if (player.position.x > level_width):
			player.modulate = Color(1, 1, 1, 0)
			player.deactivate_collisions()
		
	
	var player = current_player()
	if (player.position.x > level_width):
		control_readers.append(watcher.get_reader())
		Globals.completed_runs_count += 1
		on_run_end()
		return
	if (player.position.x < xCamera || player.position.x > xCamera + widthViewport || player.position.y > 350):
		Globals.emitter.emit('game_end')
		return
	
		
func current_player():
	return players[0]