extends CanvasLayer

func change_scene(target_scene: String, animate_play: String):
	match animate_play:
		"fade":
			animate_fade(target_scene)
		"show_final":
			animate_show_final(target_scene)
		_:
			pass
			
func animate_fade(target_scene: String):
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play_backwards("fade")
	get_tree().change_scene(target_scene)

func animate_show_final(target_scene: String):
	$AnimationPlayer.play("show_final")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target_scene)
