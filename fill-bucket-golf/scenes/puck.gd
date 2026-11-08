extends RigidBody2D
class_name Puck

var current_hue = 0.0
var hue_change_rate = 0.001

@export_category("Physics")
@export var motion_velocity_threshold = 10;
@onready var sample_player = $SamplePlayer
signal report_puck_stopped(screen_coords)

# call me ring camera because motion detected
var in_motion = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func bumped_something(thing:Node2D):
	for group in thing.get_groups():
		sample_player.play_sample(group)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	current_hue = fmod(current_hue + hue_change_rate, TAU)
	$Sprite2D.modulate = Color.from_hsv(current_hue, 1, 1)
	
	if linear_velocity.length() < motion_velocity_threshold and in_motion == true:
		# send a signal because i just came to a stop
		report_puck_stopped.emit(position)
		
		
	in_motion = linear_velocity.length() >= motion_velocity_threshold;
