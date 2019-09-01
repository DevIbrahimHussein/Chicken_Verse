extends KinematicBody2D

var move_controller

var collisions_active = false
var is_main_player = false

func _ready():
	move_controller = $MoveEngine.move_controller
	$ActivateCollisionTimer.connect("timeout", self, 'activate_collisions')
	$Area2D.connect("area_entered", self, 'collided')
	deactivate_collisions()

func collided(body):
	Globals.emitter.emit('game_end')
	
func activate_collisions():
	$Area2D/CollisionShape2D.disabled = false
	
func deactivate_collisions():
	$Area2D/CollisionShape2D.disabled = true

func set_as_main_player():
	is_main_player = true
	$ArrowIndicator.visible = true
	$ArrowHover.play('Hover')

func on_jump():
	if (is_main_player):
		if (randf() < 0.5):
			$CluckAudio.play(0)
		else:
			$CluckAudio2.play(0)

func blink():
	$Blink.play("Blink")
	
func _process(delta):
	if move_controller.right_pressed():
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif move_controller.left_pressed():
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		
	if not is_on_floor():
		$Sprite.play("Jump")
