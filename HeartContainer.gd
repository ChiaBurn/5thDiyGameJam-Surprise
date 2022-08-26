extends HBoxContainer

export(Texture) var full_heart
export(Texture) var empty_heart
var volume: int = 5
var remaining: int = 5

func initialize(max_heart: int):
	volume = max_heart
	remaining = max_heart
	for i in volume:
		var heart = TextureRect.new()
		heart.texture = full_heart
		add_child(heart)

func decrease(value):
	remaining -= value
	for i in self.get_child_count():
		if i < remaining:
			get_child(i).texture = full_heart
		else:
			get_child(i).texture = empty_heart
	
