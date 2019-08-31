extends Position2D


func _ready():
	Globals.emitter.connect('game_start', self, 'on_game_start')
	Globals.emitter.connect('game_end', self, 'on_game_end')

func on_game_start():
	modulate = Color(1, 1, 1, 0)
	
func on_game_end():
	modulate = Color(1, 1, 1, 1)