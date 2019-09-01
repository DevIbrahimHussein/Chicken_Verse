extends Position2D

func _ready():
	on_run_start(Globals.completed_runs_count)
	Globals.emitter.connect('game_start', self, 'on_game_start')
	Globals.emitter.connect('run_start', self, 'on_run_start')
	Globals.emitter.connect('run_end', self, 'on_run_end')
	Globals.emitter.connect('game_end', self, 'on_game_end')
	$RemoveTextTimer.connect("timeout", self, 'fade_out')

func on_game_start():
	modulate = Color(1, 1, 1, 1)
	$RunStateText.text = "GO!"
	
func on_run_start(run_count):
	$RemoveTextTimer.start()
	$RunStateText.text = "GO!"

func on_run_end():
	$FadeAnimation.play("FadeIn")
	$RunStateText.text = "Run number %s" % Globals.completed_runs_count

func fade_out():
	$FadeAnimation.play("FadeOut")

func on_game_end():
	$RemoveTextTimer.stop()
	$FadeAnimation.stop(true)
	modulate = Color(1, 1, 1, 0)