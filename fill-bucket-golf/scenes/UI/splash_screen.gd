extends CanvasLayer
@onready var settings_screen = $Settings

var sprite_rotation_deg = 30
var scroll_speed = 200
var sprite_spacing = 60
@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_sprite: Sprite2D = $Parallax2D/Parallax_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_screen.hide()
	set_parralax()
	for button in get_tree().get_nodes_in_group("Button"):
		button.pressed.connect(button_handler.bind(button))
func button_handler(button):
	#print(button, " pressed")
	match button.name:
		"StartButton":
			##load first level
			get_tree().change_scene_to_file("res://scenes/world.tscn")
		"ExitButton":
			##close the game
			get_tree().quit()
			pass
		"CloseSettings":
			settings_screen.hide()
			pass
		"OpenSettings":
			settings_screen.show()

func set_parralax():
	var v_rect = get_viewport().get_visible_rect()
	#print("visible size: ", v_rect.size)
	parallax_sprite.position = get_viewport().get_visible_rect().size * 0.5
	parallax_sprite.rotation = deg_to_rad(sprite_rotation_deg)
	parallax_2d.repeat_size = Vector2.ONE * sprite_spacing
	parallax_2d.autoscroll = Vector2.RIGHT.rotated(parallax_sprite.rotation).normalized()
	parallax_2d.autoscroll *= scroll_speed
