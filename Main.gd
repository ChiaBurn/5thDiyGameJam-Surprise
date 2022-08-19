extends Node
export(PackedScene) var click_scene
export(PackedScene) var key_scene
export(PackedScene) var event_scene
export(PackedScene) var draw_scene
export var fail_max_count: int = 5

var current_quest_index: int = 0
var current_key_code: String = "start"
var fail_count: int = 0
onready var position = {
	"A": $PositionA,
	"B": $PositionB,
	"C": $PositionC,
	"D": $PositionD,
	"E": $PositionE,
	"F": $PositionF,
	"G": $PositionG,
	"H": $PositionH
}
# TODO: read quests fron JSON file
const quests = [
	{
		"type": "Click",
		"life": 5000,
		"position": "A"
	},
	{
		"type": "Click",
		"life": 3000,
		"position": "B"
	},
	{
		"type": "Key",
		"life": 5000
	},
	{
		"type": "Click",
		"life": 2000,
		"position": "C"
	},
	{
		"type": "Key",
		"life": 5000
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "G"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "H"
	},
	{
		"type": "Key",
		"life": 5000
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "E"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "B"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "C"
	}
]

const keys = {
	"start": [
		{
			"code": "creative", "value": "發揮創意", "position": "A"
		},
		{
			"code": "passion", "value": "喜好添加", "position": "B"
		},
		{
			"code": "perfect", "value": "完美還原", "position": "C"
		}
	],
	"creative": [
		{
			"code": "creative_soul", "value": "靈魂創作", "position": "D"
		},
		{
			"code": "creative_cute", "value": "可愛正義", "position": "E"
		}
	],
	"creative_soul": [
		{
			"code": "creative_soul_meow", "value": "喵喵喵", "position": "F"
		},
		{
			"code": "creative_soul_power", "value": "力與美", "position": "G"
		}
	],
	"creative_cute": [
		{
			"code": "creative_cute_chick", "value": "可愛小雞", "position": "H"
		},
		{
			"code": "creative_cute_kitty", "value": "可愛小貓", "position": "A"
		}
	],
	"passion": [
		{
			"code": "passion_nekomimi", "value": "貓耳哈斯哈斯", "position": "E"
		},
		{
			"code": "passion_furry", "value": "獸控之力", "position": "C"
		}
	],
	"passion_nekomimi": [
		{
			"code": "passion_nekomimi_girl", "value": "貓娘哈斯哈斯", "position": "G"
		},
		{
			"code": "passion_nekomimi_maid", "value": "女僕哈斯哈斯", "position": "D"
		}
	],
	"passion_furry": [
		{
			"code": "passion_furry_shota", "value": "UWU", "position": "H"
		},
		{
			"code": "passion_furry_power", "value": "POWER!", "position": "F"
		}
	]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	show_current_quest()
	
func on_succeed():
	print("succeed!")
	go_next_quest()

func on_fail():
	print("fail!")
	fail_count += 1
	if(fail_count >= fail_max_count):
		end_game()
		return
	go_next_quest()
	
func on_select_key(code):
	current_key_code = code
	print("select key:", code)
	get_tree().call_group("keys", "queue_free")
	go_next_quest()

		
func end_game():
	print("Game over! current index:", current_quest_index)

func go_next_quest():
	current_quest_index += 1
	if(current_quest_index >= quests.size()):
		end_game()
		return
	show_current_quest()

func show_current_quest():
	var quest = quests[current_quest_index]	
	match quest.type:
		"Click":
			show_click(quest)
		"Key":
			show_key(quest)
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
	add_child(click);

func show_key(quest):
	var current_key_selection = keys.get(current_key_code)	
	if(current_key_selection == null):
		print("no more key object!")
		go_next_quest()
		return
	
	for selection in current_key_selection:
		show_key_selection(selection)

func show_key_selection(selection):
	var key = key_scene.instance()
	var position_node = position[selection.position]
	key.position = position_node.position
	key.set_code_and_value(selection.code, selection.value)
	add_child(key);

func show_event(quest):
	# TODO: show event
	print("show_event:", quest)
	pass	

func show_draw(quest):
	# TODO: show draw
	print("show_draw:", quest)
	pass

