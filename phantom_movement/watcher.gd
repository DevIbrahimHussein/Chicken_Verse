
var action

var is_pressed = false
var frame_action_obj = load('res://phantom_movement/frame_action.gd')
var action_records = []

func _init(action_code):
	action = action_code
	action_records.append(frame_action_obj.new(0, false))
	
func update(frame):
	var currently_pressed = Input.is_action_pressed(action)
	if (currently_pressed != is_pressed):
		action_records.append(frame_action_obj.new(frame, currently_pressed))
		is_pressed = currently_pressed
	
