extends Node
export(PackedScene) var click_scene
export(PackedScene) var key_scene
export(PackedScene) var event_scene
export(PackedScene) var draw_scene

var current_quest_index: int = 0
var fail_count: int = 0
const fail_max_count: int = 9
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
		"life": 1000,
		"position": "B"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "C"
	},
	{
		"type": "Click",
		"life": 2000,
		"position": "D"
	},
	{
		"type": "Click",
		"life": 1000,
		"position": "E"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "F"
	},
	{
		"type": "Click",
		"life": 700,
		"position": "G"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "H"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "E"
	},
	{
		"type": "Click",
		"life": 500,
		"position": "B"
	},
	{
		"type": "Click",
		"life": 5000,
		"position": "C"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("quests: ", quests)
	go_next_quest()
	
func on_succeeed():
	print("succeeed!")
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
	
	var next_quest = quests[current_quest_index]
	
	match next_quest.type:
		"Click":
			show_click(next_quest)
		"Key":
			show_key(next_quest)
		"Event":
			show_event(next_quest)
		"draw":
			show_draw(next_quest)
		_:
			print("invalid type: ", next_quest)
			end_game()

func show_click(next_quest):
	print("show_click:", next_quest)
	var click = click_scene.instance()
	var position_node = position[next_quest.position]
	click.position = position_node.position
	click.set_life_ms(next_quest.life)	
	add_child(click);

func show_key(next_quest):
	# TODO: show key
	print("show_key:", next_quest)
	pass

func show_event(next_quest):
	# TODO: show event
	print("show_event:", next_quest)
	pass	

func show_draw(next_quest):
	# TODO: show draw
	print("show_draw:", next_quest)
	pass

