extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Thrower.create_puck_request.connect(create_puck)
	$Thrower.shoot_puck.connect(shoot_puck)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot_puck(angle, strength):
	print("shooting a puck.. with angle: ", angle, " and strength ", strength)
	pass

func create_puck():
	pass
