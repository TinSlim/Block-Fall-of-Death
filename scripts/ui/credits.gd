
extends MarginContainer

var team_credits = [
	{
		"name": "Juan Escares",
		"link": "https://itch.io/profile/theaxz"
	},
	{
		"name": "Cristóbal Torres",
		"link": "https://tinslim.itch.io"
	},
	{
		"name": "Rodrigo Urrea",
		"link": "https://riul1999.itch.io"
	}
]

var assets_credits = [
	# Powerup Fruit
	{
		"name": "Admurin's Botany Items",
		"author": "admurin.itch.io"
	},

	# Buildings Background
	{
		"name": "City Background Parallax",
		"author": "mizuart.itch.io"
	},
	
	# Street Background
	{
		"name": "Warped Miami Synth",
		"author": "https://ansimuz.itch.io"
	},

	# Bunny
	{
		"name": "Pixel Adventure 2",
		"author": "pixelfrog-assets.itch.io"
	},
	
	# Background Sound
	{
		"name": "50+ Music Loops",
		"author": "https://fardifferent.itch.io"
	},
	
	# Jump Sound Effect
	{
		"name":"8-bit / 16-bit Sound Effects (x25) Pack",
		"author": "https://jdwasabi.itch.io"
	}
]

var scroll_speed = 1
var scroll_ended = false

onready var credits_container = $ScrollContainer/CreditsContainer
onready var scroll_container = $ScrollContainer


func _ready():
	var creators_label = _create_label("CRA Games Team")
	credits_container.add_child(creators_label)
	
	for author in team_credits:
		var h_separator = HSeparator.new()
		h_separator.theme_type_variation = "SmallHSeparator"
		var name_label = _create_label(author.name)
		var link_label = _create_label(author.link)
		credits_container.add_child(h_separator)
		credits_container.add_child(name_label)
		credits_container.add_child(link_label)
	
	var h_separator = HSeparator.new()
	credits_container.add_child(h_separator)
	
	var assets_label = _create_label("Assets")
	credits_container.add_child(assets_label)
	
	for credit in assets_credits:
		h_separator = HSeparator.new()
		h_separator.theme_type_variation = "SmallHSeparator"
		var name_label = _create_label(credit.name)
		var author_label = _create_label(credit.author)
		credits_container.add_child(h_separator)
		credits_container.add_child(name_label)
		credits_container.add_child(author_label)
	
	scroll_container.scroll_vertical = 0
	set_physics_process(false)
	yield(get_tree().create_timer(2), "timeout")
	set_physics_process(true)


func _physics_process(delta):
	var last_scroll = scroll_container.scroll_vertical
	scroll_container.scroll_vertical += scroll_speed
	var new_scroll = scroll_container.scroll_vertical
	if new_scroll == last_scroll:
		_try_end_scroll()


func _create_label(text) -> Label:
	var label = Label.new()
	label.align = Label.ALIGN_CENTER
	label.autowrap = true
	label.theme_type_variation = "SmallLabel"
	label.text = text
	return label

func _try_end_scroll():
	if not scroll_ended:
		scroll_ended = true
		yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://scenes/ui/main_menu.tscn")
