extends Node

var final_index = 0
var phase_0_index = 0
var phase_1_index = 0
var phase_2_index = 0
var fail_count = 0
var fail_max_count = 0
var final_product = ""

func _ready():
	final_index = SceneChanger.scene_data.final_index
	phase_0_index = SceneChanger.scene_data.phase_0_index
	phase_1_index = SceneChanger.scene_data.phase_1_index
	phase_2_index = SceneChanger.scene_data.phase_2_index
	fail_count = SceneChanger.scene_data.fail_count
	fail_max_count = SceneChanger.scene_data.fail_max_count
	final_product = SceneChanger.scene_data.final_product
	_show_result()
	
func _show_result():
	match final_product:
		"creative_soul_meow":
			$AnimatedSprite.play("creative_soul_meow")
		"creative_soul_power":
			$AnimatedSprite.play("creative_soul_power")
		"creative_cute_chick":
			$AnimatedSprite.play("creative_cute_chick")
		"creative_cute_kitty":
			$AnimatedSprite.play("creative_cute_kitty")
		"passion_nekomimi_girl":
			$AnimatedSprite.play("passion_nekomimi_girl")
		"passion_nekomimi_maid":
			$AnimatedSprite.play("passion_nekomimi_maid")
		"passion_furry_shota":
			$AnimatedSprite.play("passion_furry_shota")
		"passion_furry_power":
			$AnimatedSprite.play("passion_furry_power")
		"perfect":
			$AnimatedSprite.play("perfect")
		"fail":
			if final_index <= phase_0_index:
				$AnimatedSprite.play("phase_0_fail")
			elif  final_index <= phase_1_index:
				$AnimatedSprite.play("phase_1_fail")
			elif  final_index <= phase_2_index:
				$AnimatedSprite.play("phase_2_fail")
		_:
			print("Error Result")


func _on_Button_pressed():
	SceneChanger.change_scene_with_animate('StartScreen.tscn', 'fade')
