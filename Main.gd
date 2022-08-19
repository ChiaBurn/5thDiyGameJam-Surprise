extends Node
export(PackedScene) var click_scene
export(PackedScene) var key_scene
export(PackedScene) var event_scene
export(PackedScene) var draw_scene
export var fail_max_count: int = 5

var current_quest_index: int = 0
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
		"type": "Click",
		"life": 2000,
		"position": "C"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "D"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "E"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "F"
	},
	{
		"type": "Click",
		"life": 700,
		"position": "G"
	},
	{
		"type": "Click",
		"life": 700,
		"position": "H"
	},
	{
		"type": "Click",
		"life": 700,
		"position": "E"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "B"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "C"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("quests: ", quests)
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
	# TODO: show key
	print("show_key:", quest)
	pass

func show_event(quest):
	# TODO: show event
	print("show_event:", quest)
	pass	

func show_draw(quest):
	# TODO: show draw
	print("show_draw:", quest)
	pass

