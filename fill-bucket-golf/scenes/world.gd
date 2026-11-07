extends Node2D

var scene_puck = preload("res://scenes/puck.tscn");

var pucks_in_hand = 1;

var all_pucks = [];
var current_puck = null;
var pucks_in_motion = 0;




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Thrower.create_puck_request.connect(create_puck)
	$Thrower.shoot_puck.connect(shoot_puck)
	
	create_puck();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$WaitTimer/WaitTimerLabel.text = str($WaitTimer.time_left);
	$PucksCounter.text = str(pucks_in_hand) + " pucks in hand";
	update_pucks_in_motion()
	
	if pucks_in_hand == 0 and pucks_in_motion == 0 and current_puck == null:
		$GameEndLabel.show();
	
	pass
	
func shoot_puck(angle, strength):
	print("shooting a puck.. with angle: ", angle, " and strength ", strength)
	
	# apply a physics impulse to the puck
	current_puck.apply_impulse(Vector2.RIGHT.rotated(angle).normalized() * strength)
	
	# if it was the last puck, wait for them all to finish timer
	if pucks_in_hand == 0:
		$WaitTimer/WaitTimerLabel.show();
		$WaitTimer.wait_time = 10.0;
		$WaitTimer.start();
	
	# ready up for the next shot
	pass

func create_puck():
	if pucks_in_hand > 0:
		pucks_in_hand -= 1;
		current_puck = scene_puck.instantiate();
		add_child(current_puck)
		current_puck.position = Vector2i(100,100);
		
		all_pucks.append(current_puck);
		$Thrower.position = current_puck.position;
	else:
		current_puck = null;


func update_pucks_in_motion():
	var pucks_in_motion = 0
	for puck in all_pucks:
		if puck.linear_velocity.length() > 10:
			pucks_in_motion += 1;
	
