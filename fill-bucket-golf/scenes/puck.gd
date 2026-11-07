extends RigidBody2D


@export_category("Physics")
@export var puck_friction = 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	linear_velocity *= (1-puck_friction);
	pass
