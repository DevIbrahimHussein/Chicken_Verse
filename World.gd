extends Node

var player_scene = preload('res://Player/Player.tscn')
var input_reader_controller_obj = load('res://phantom_movement/cardinal_input_reader.gd')
var input_controller_obj = load('res://phantom_movement/input_movement.gd')
var frame_action = load('res://phantom_movement/frame_action.gd')

func _ready():
	var player = player_scene.instance()
	player.get_node('MoveEngine').set_move_controller(input_controller_obj.new())
	player.position = Vector2(80, 120)
	add_child(player)

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		var watcher = $Watcher
		var player = player_scene.instance()
		player.get_node('MoveEngine').set_move_controller(watcher.get_reader())
		player.position = Vector2(80, 120)
		add_child(player)
		watcher.init_watchers()
		
