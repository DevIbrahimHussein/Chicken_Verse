extends Position2D


func _ready():
	Globals.emitter.connect('game_start', self, 'on_game_start')
	Globals.emitter.connect('game_end', self, 'on_game_end')
	$RestartButton.connect("button_up", self, 'restart_game')

func on_game_start():
	visible = false
	
func on_game_end():
	visible = true
	
func restart_game():
	Globals.emitter.emit('game_start')
	