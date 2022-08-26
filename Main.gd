extends Node
export(PackedScene) var click_scene
export(PackedScene) var key_scene
export(PackedScene) var event_scene
export(PackedScene) var draw_scene
var fail_max_count: int
export var key_json_path: String = "res://JSON/Key.json"
export var quest_json_path: String = "res://JSON/Quest.json"
export var event_json_path: String = "res://JSON/Event.json"

var current_quest_index: int = 0
var current_key_code: String = "start"
var fail_count: int = 0
onready var position = {
	"L1": $PositionL1,
	"L2": $PositionL2,
	"L3": $PositionL3,
	"M1": $PositionM1,
	"M2": $PositionM2,
	"M3": $PositionM3,
	"R1": $PositionR1,
	"R2": $PositionR2,
	"R3": $PositionR3,
}
var keys: Dictionary
var quests: Array
var events: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize()
	start_game()
	
func initialize():
	randomize()
	current_quest_index = 0
	current_key_code = "start"
	fail_count = 0
	fail_max_count = SceneChanger.scene_data.fail_max_count
	keys = load_data_from_json_file(key_json_path)
	quests = load_data_from_json_file(quest_json_path)
	events = load_data_from_json_file(event_json_path)
	events.shuffle()
	$ProgressBar.value = 0
	$ProgressBar.max_value = quests.size()
	
	
func load_data_from_json_file(path):
	var file = File.new()
	if file.open(path, File.READ) != OK:
		print("fail to open file '", path,"'")
		return
	var content = file.get_as_text()
	file.close()
	var json = parse_json(content)
	return json
	
func start_game():
	$Music.play()
	$BackgroundAnimation.play()
	show_current_quest()
	
func end_game():
	$Music.stop()
	$BackgroundAnimation.stop()
	SceneChanger.scene_data.final_index = current_quest_index
	SceneChanger.scene_data.final_product = current_key_code
	SceneChanger.scene_data.fail_count = fail_count
	SceneChanger.change_scene_with_animate("EndScreen.tscn", "show_final")
	
func on_succeed(type):
	go_next_quest()

func on_fail(type):
	fail_count += 1
	if(fail_count >= fail_max_count):
		end_game()
		return
	go_next_quest()
	
func on_select_key(code):
	$KeySelectSound.play()
	current_key_code = code
	get_tree().call_group("keys", "queue_free")
	go_next_quest()

func go_next_quest():
	current_quest_index += 1
	if(current_quest_index >= quests.size()):
		end_game()
		return
	show_current_quest()
	$ProgressBar.value += 1

func show_current_quest():
	var quest = quests[current_quest_index]	
	match quest.type:
		"Click":
			show_click(quest)
		"Key":
			show_key(current_key_code)
		"Event":
			show_event(quest)
		"Draw":
			show_draw(quest)
		_:
			print("invalid type: ", quest)
			end_game()

func show_click(quest):
	var click = click_scene.instance()
	var position_node = position[quest.position]
	click.position = position_node.position
	click.set_life_ms(quest.life)
	add_child(click)

func show_key(code):
	var current_key_selection = keys.get(code)
	if(current_key_selection == null):
		go_next_quest()
		return
	for selection in current_key_selection:
		show_key_selection(selection)
	$KeyShowSound.play()

func show_key_selection(selection):
	var key = key_scene.instance()
	var position_node = position[selection.position]
	key.position = position_node.position
	key.set_code_and_value(selection.code, selection.value)
	add_child(key)

func show_event(quest):
	var current_event = events.pop_back()
	if(current_event == null):
		go_next_quest()
		return
	var event = event_scene.instance()
	event.set_content(current_event, quest.life)
	add_child(event)

func show_draw(quest):
	# TODO: show draw
	print("show_draw:", quest)
	pass

