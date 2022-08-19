extends Area2D
signal succeed
signal fail

var life_ms : float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var speed_scale : float = 1000 / life_ms
	print("speed_scale: ", speed_scale)
	connect("succeeed", get_parent(), "on_succeeed")
	connect("fail", get_parent(), "on_fail")
	$AnimatedSprite.set_speed_scale(speed_scale)
	$AnimatedSprite.playing = true

func set_life_ms(millisecond):
	life_ms = millisecond

func _on_AnimatedSprite_animation_finished():
	hide()
	emit_signal("fail")
	queue_free()
	
