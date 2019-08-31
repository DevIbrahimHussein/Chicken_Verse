extends Position2D

var active = true

func _ready():
	Globals.emitter.connect('run_start', self, 'reset')
	Globals.emitter.connect('run_end', self, 'stop')
	Globals.emitter.connect('game_end', self, 'stop')
	
func reset():
	active = true
	position.x = 0
	
func stop():
	active = false
	
func _process(delta):
	if active:
		position.x += 0.75
