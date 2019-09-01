extends Position2D

var active = true

func _ready():
	Globals.emitter.connect('run_start', self, 'start')
	Globals.emitter.connect('run_end', self, 'stop')
	Globals.emitter.connect('game_end', self, 'stop')
	
func start(run_count):
	active = true
	
func stop():
	position.x = 0
	active = false
	
func _process(delta):
	if active:
		position.x += 2.1
