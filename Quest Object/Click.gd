extends Area2D
signal succeed
signal fail

var life_ms : float

# Called when the node enters the scene tree for the first time.
func _ready():
	var speed_scale : float = 1000 / life_ms
	connect("succeed", get_parent(), "on_succeed")
	connect("fail", get_parent(), "on_fail")
	$AnimatedSprite.set_speed_scale(speed_scale)
	$AnimatedSprite.playing = true

func set_life_ms(millisecond):
	life_ms = millisecond

func emit_then_remove_self(signal_value):
	hide()
	emit_signal(signal_value)
	queue_free()

func _on_AnimatedSprite_animation_finished():
	hide()
	emit_then_remove_self("fail")
	queue_free()

func _on_Click_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		emit_then_remove_self("succeed")
