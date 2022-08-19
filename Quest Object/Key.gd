extends Area2D
signal select_key(code)

var key_code: String
var key_value: String


func set_code_and_value(code, value):
	key_code = code
	key_value = value

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("select_key", get_parent(), "on_select_key")
	$Label.text = key_value

func _on_Key_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT):
		hide()
		emit_signal("select_key", key_code)
		queue_free()
