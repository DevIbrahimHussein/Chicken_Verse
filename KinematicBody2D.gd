extends KinematicBody2D

var move_controller

var collisions_active = false
var is_main_player = false
var play_default_anim = true

var animation = 'Idle'

func _ready():
	move_controller = $MoveEngine.move_controller
	$ActivateCollisionTimer.connect("timeout", self, 'activate_collisions')
	$Area2D.connect("area_entered", self, 'collided')
	$Sprite.connect("animation_finished", self, 'on_animation_finish')
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
			
func on_double_jump():
	if not is_on_floor():
		$Sprite.play('DoubleJump')

func on_land():
	play_default_anim = false
	$Sprite.play('Land')
	$Sprite.speed_scale = 3.2

func blink():
	$Blink.play("Blink")
	
func _process(delta):
	if ($Sprite.animation == 'Run'):
		$Sprite.position.y = 6
	else:
		$Sprite.position.y = 0
		
	if (not play_default_anim):
		return
	
	if move_controller.right_pressed():
		$Sprite.flip_h = false
		if is_on_floor():
			$Sprite.play("Run")
			$Sprite.speed_scale = 1.2
	elif move_controller.left_pressed():
		$Sprite.flip_h = true
		if is_on_floor():
			$Sprite.play("Run")
			$Sprite.speed_scale = 1.2
	else:
		if is_on_floor():
			$Sprite.play("Idle")
			$Sprite.speed_scale = 1.2
		
	if not is_on_floor() && $Sprite.animation != 'Jump' && $Sprite.animation != 'DoubleJump':
		$Sprite.play("Jump")
		$Sprite.speed_scale = 3.2

func on_animation_finish():
	play_default_anim = true
