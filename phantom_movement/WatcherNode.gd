extends Node2D


var watcher_obj = load('res://phantom_movement/watcher.gd')
var input_reader_controller_obj = load('res://phantom_movement/cardinal_input_reader.gd')
var right_watcher
var left_watcher
var up_watcher
var down_watcher

var current_frame = 0

func _ready():
	init_watchers()

func init_watchers():
	current_frame = 0
	right_watcher = watcher_obj.new('ui_right')
	left_watcher = watcher_obj.new('ui_left')
	up_watcher = watcher_obj.new('ui_up')
	down_watcher = watcher_obj.new('ui_down')

func _process(delta):
	right_watcher.update(current_frame)
	left_watcher.update(current_frame)
	up_watcher.update(current_frame)
	down_watcher.update(current_frame)
	current_frame += 1
	
func get_reader():
	return input_reader_controller_obj.new(right_watcher.action_records, left_watcher.action_records, up_watcher.action_records, down_watcher.action_records)
