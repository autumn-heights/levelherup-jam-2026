extends Node2D

const MIN_MOUSE_DIST = 32;
const MAX_MOUSE_DIST = 1000;
const BAR_OFFSET = 32;

var current_angle = 0;
var current_power = 0;

var mouse_click_position = Vector2(0,0);
signal shoot_puck(angle, power)
signal create_puck_request

enum ControlState {
	STATE_READY,
	STATE_SETPOWER,
	STATE_PLAYERWAIT
}

var current_state = ControlState.STATE_READY;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting!")
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		look_at(event.global_position)
		if current_state == ControlState.STATE_READY:
			
			current_angle = rotation;
			
			
		elif current_state == ControlState.STATE_SETPOWER:
			
			current_power = 0;
			current_power = (Vector2(0,0) - event.position).length();
			current_power = clamp(current_power, MIN_MOUSE_DIST, MAX_MOUSE_DIST);
			
			$MeterSprite.scale.x = max(1, current_power - BAR_OFFSET*2);
			$MeterSprite.position.x = 0.5 * current_power + BAR_OFFSET;
			
	if event is InputEventMouseButton:
		if event.is_action_pressed("Left_Click"):
			match current_state:
				ControlState.STATE_SETPOWER:
					report_state_mismatch()
				ControlState.STATE_READY:
					## this is the correct state to recieve this input !! well done
					mouse_click_position = event.position;
					current_state = ControlState.STATE_SETPOWER;
					pass
				ControlState.STATE_PLAYERWAIT:
					report_state_mismatch()
					pass
		elif event.is_action_released("Left_Click"):
			match current_state:
				ControlState.STATE_SETPOWER:
					## this is the correct state to recieve this input !! well done
					shoot_puck.emit(current_angle, current_power)
					current_state = ControlState.STATE_PLAYERWAIT;
					pass
				ControlState.STATE_READY:
					report_state_mismatch()
					pass
				ControlState.STATE_PLAYERWAIT:
					report_state_mismatch()
					pass
			
		print("Mouse Click/Unclick at: ", event.position)
<<<<<<< Updated upstream
		
		if current_state == ControlState.STATE_READY:
			mouse_click_position = event.position;
			
			current_state = ControlState.STATE_SETPOWER;
			
		elif current_state == ControlState.STATE_SETPOWER:
			
			# trigger_launch ( current_angle, current_power )
			trigger_launch(current_angle, current_power)
			
			current_state = ControlState.STATE_PLAYERWAIT;
			$MeterSprite.hide();
			
		elif current_state == ControlState.STATE_PLAYERWAIT:
			pass
			#current_state = ControlState.STATE_READY;

func trigger_launch(angle, power):
	shoot_puck.emit(angle, power)
	
func ready_up():
	current_state = ControlState.STATE_READY;
	$MeterSprite.show();
=======


func report_state_mismatch():
	printerr("this buttonpress should not be recieved in the state ", state_to_str())
func state_to_str():
	return ControlState.keys()[current_state]
>>>>>>> Stashed changes
