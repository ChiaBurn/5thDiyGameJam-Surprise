extends CanvasLayer

export var scene_data: Dictionary ={
	"final_index" : 0,
	"phase_0_index" : 4,
	"phase_1_index" : 10,
	"phase_2_index" : 25,
	"fail_count" : 0,
	"fail_max_count" : 5,
	"final_product" : "",
}

func change_scene_with_animate(target_scene: String, animate_play: String):
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
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(target_scene)
	$AnimationPlayer.play("show_final")
	
	

