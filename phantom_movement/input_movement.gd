extends Node

func update(frame):
	pass

func reset():
	pass

func right_pressed():
	return Input.is_action_pressed('ui_right')
	
func left_pressed():
	return Input.is_action_pressed('ui_left')
	
func up_pressed():
	return Input.is_action_pressed('ui_up')
	
func down_pressed():
	return Input.is_action_pressed('ui_down')
	
func down_just_pressed():
	return Input.is_action_just_pressed('ui_down')
	
func right_just_pressed():
	return Input.is_action_just_pressed('ui_right')
	
func left_just_pressed():
	return Input.is_action_just_pressed('ui_left')
	
func up_just_pressed():
	return Input.is_action_just_pressed('ui_up')
	