extends Node


func _on_TempStartButton_pressed():
	SceneChanger.scene_data.final_index = 0
	SceneChanger.scene_data.final_product = ""
	$AnimationPlayer.play("start")
	$game_start.play()
	yield($AnimationPlayer, "animation_finished")
	SceneChanger.change_scene_with_animate('Main.tscn', 'fade')
	

