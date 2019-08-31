extends Node

var reader_obj = load('res://phantom_movement/frame_input_reader.gd')

var right_reader
var left_reader
var up_reader
var down_reader

func _init(right_inputs, left_inputs, up_inputs, down_inputs):
	right_reader = reader_obj.new(right_inputs)
	left_reader = reader_obj.new(left_inputs)
	up_reader = reader_obj.new(up_inputs)
	down_reader = reader_obj.new(down_inputs)
	

func update(frame):
	right_reader.update(frame)
	left_reader.update(frame)
	up_reader.update(frame)
	down_reader.update(frame)

func right_pressed():
	return right_reader.get_is_pressed()

func left_pressed():
	return left_reader.get_is_pressed()
	
func up_pressed():
	return up_reader.get_is_pressed()
	
func down_pressed():
	return down_reader.get_is_pressed()
	
func right_just_pressed():
	return right_reader.get_is_just_pressed()
	
func left_just_pressed():
	return left_reader.get_is_just_pressed()
	
func up_just_pressed():
	return up_reader.get_is_just_pressed()
	
func down_just_pressed():
	return down_reader.get_is_just_pressed()
