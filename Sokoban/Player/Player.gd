extends "res://Template/Moveable.gd"

var last_position = Vector2()
var query = null

func _ready():
	last_position = position

func _unhandled_input(event):
	if event.is_action_pressed("Up") and query == null:
		query = Vector2.UP
	elif event.is_action_pressed("Right") and query == null:
		query = Vector2.RIGHT
	elif event.is_action_pressed("Down") and query == null:
		query = Vector2.DOWN
	elif event.is_action_pressed("Left") and query == null:
		query = Vector2.LEFT
		
func _process(_delta):
	if query != null:
		move(query)
		
func move(direction):
	if moving:
		return
	if direction_free(direction):
		moving = true
		last_position = position
		direction *= TILE_SIZE
		$Tween.interpolate_property(
			self, 
			"position", 
			position, 
			position + direction, 
			speed,
			Tween.TRANS_LINEAR,
			Tween.EASE_OUT_IN,
			0
		)
		$Tween.start()
	query = null


func iAmBlocked():
	$Tween.stop_all()
	moving = false
	position = last_position
