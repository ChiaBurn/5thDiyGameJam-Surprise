extends Area2D
signal succeed(type)
signal fail(type)

var life_ms : float

func set_life_ms(millisecond):
	life_ms = millisecond

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("succeed", get_parent(), "on_succeed")
	connect("fail", get_parent(), "on_fail")
	var speed_scale : float = 1000 / life_ms
	$AnimatedSprite.set_speed_scale(speed_scale)
	$AnimatedSprite.playing = true

func emit_then_remove_self(isSucceed: bool):
	hide()
	$AnimatedSprite.playing = false
	$CollisionShape2D.disabled = true
	emit_signal("succeed" if isSucceed else "fail", "Click")
	if(isSucceed):
		$ClickSucceedSound.play()
		yield($ClickSucceedSound, "finished")
	queue_free()

func _on_AnimatedSprite_animation_finished():
	emit_then_remove_self(false)

func _on_Click_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		emit_then_remove_self(true)
