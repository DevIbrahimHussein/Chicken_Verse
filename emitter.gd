signal run_start
signal run_end
signal game_start
signal game_end

func emit (signl, params=null):
	if params != null:
		emit_signal(signl, params)
	else:
		emit_signal(signl)