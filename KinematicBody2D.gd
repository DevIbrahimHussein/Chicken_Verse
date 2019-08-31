extends KinematicBody2D

var move_controller

func _ready():
	move_controller = $MoveEngine.move_controller

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
