extends RigidBody2D


@export_category("Physics")
@export var motion_velocity_threshold = 10;

signal report_puck_stopped(screen_coords)

# call me ring camera because motion detected
var in_motion = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if linear_velocity.length() < motion_velocity_threshold and in_motion == true:
		# send a signal because i just came to a stop
		report_puck_stopped.emit(position)
		
		
	in_motion = linear_velocity.length() >= motion_velocity_threshold;
