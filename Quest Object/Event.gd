extends Node
signal succeed(type)
signal fail(type)

var question: String
var selections : Array
var life_ms : float

func set_content(setting, millisecond):
	question = setting["question"]
	selections = setting["selections"]
	life_ms = millisecond

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("succeed", get_parent(), "on_succeed")
	connect("fail", get_parent(), "on_fail")
	$Question.text = question
	$Answer1.text = selections[0]["text"];
	$Answer2.text = selections[1]["text"];
	$Answer3.text = selections[2]["text"];
	var speed_scale : float = 1000 / life_ms
	$AnimatedSprite.set_speed_scale(speed_scale)
	$AnimatedSprite.playing = true
	$EventShowSound.play()

func _on_Answer1_pressed():
	end_event(selections[0]["isAnswer"])

func _on_Answer2_pressed():
	end_event(selections[1]["isAnswer"])

func _on_Answer3_pressed():
	end_event(selections[2]["isAnswer"])

func _on_AnimatedSprite_animation_finished():
	end_event(false)

func end_event(isCorrect: bool):
	disable_all_button()
	$AnimatedSprite.stop()
	$AnimatedSprite.visible = false
	if(isCorrect):
		$CorrectImage.visible = true
		$EventSucceedSound.play()
		yield($EventSucceedSound, "finished")
	else:
		$IncorrectImage.visible = true
		$EventFailSound.play()
		yield($EventFailSound, "finished")
	emit_then_remove_self(isCorrect)

func disable_all_button():
	$Answer1.disabled = true
	$Answer2.disabled = true
	$Answer3.disabled = true

func emit_then_remove_self(isCorrect: bool):
	emit_signal("succeed" if isCorrect else "fail", "Event")
	queue_free()

