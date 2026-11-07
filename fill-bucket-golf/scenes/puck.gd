extends RigidBody2D

enum ControlState {
	STATE_READY,
	STATE_SETPOWER,
	STATE_PLAYERWAIT
}

var current_state = ControlState.STATE_READY;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	$MeterPivot/MeterSprite.size

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		
		if current_state == ControlState.STATE_READY:
			
			current_state = ControlState.STATE_SETPOWER;
			$MeterPivot.rotation += 10;
			
		elif current_state == ControlState.STATE_SETPOWER:
			
			current_state = ControlState.STATE_PLAYERWAIT;
			
		elif current_state == ControlState.STATE_PLAYERWAIT:
			
			current_state = ControlState.STATE_READY;
			
		
		
	elif event is InputEventMouseMotion:
		pass
		#print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
