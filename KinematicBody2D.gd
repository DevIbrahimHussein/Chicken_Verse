extends KinematicBody2D

var move_controller
var number_of_overlaps = 0

var collisions_active = false

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
