extends RigidBody2D
class_name Puck

var atlas_img;
var colour_id = Vector2i() # in this game we identify colours by their coordinates on the tile atlas

var current_hue = 0.0
var hue_change_rate = 0.001

@export_category("Physics")
@export var motion_velocity_threshold = 10;

signal report_puck_stopped(screen_coords)

@onready var sprite2d: Sprite2D = $Sprite2D

# call me ring camera because motion detected
var in_motion = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atlas_img = Image.load_from_file('res://ART/Tileatlas.png')
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_hue = fmod(current_hue + hue_change_rate, TAU)
	
	
	if linear_velocity.length() < motion_velocity_threshold and in_motion == true:
		# send a signal because i just came to a stop
		report_puck_stopped.emit(position)
		
		
	in_motion = linear_velocity.length() >= motion_velocity_threshold;


func set_puck_colour(new_colour_id):
	var colour :Color = atlas_img.get_pixel(32 * new_colour_id[1] + 1, 32 * new_colour_id[0] + 1)
	sprite2d.modulate = colour
	colour_id = new_colour_id;
	
