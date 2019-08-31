
var frame_actions = [];
var action_index = 0
var current_frame = 0;

func _init(recorded_frame_actions):
	frame_actions = recorded_frame_actions

func update(frame):
	current_frame = frame

func get_frame_action():
	update_action_index()
	return frame_actions[action_index]
	

func update_action_index():
	var next_index = action_index + 1
	if (next_index < frame_actions.size()):
		if (current_frame >= frame_actions[next_index].frame):
			action_index = next_index

func get_is_pressed():
	if (frame_actions.size() == 0):
		return false
	return get_frame_action().is_pressed
	
func get_is_just_pressed():
	if (frame_actions.size() == 0):
		return false
	return get_frame_action().frame == current_frame && get_frame_action().is_pressed
