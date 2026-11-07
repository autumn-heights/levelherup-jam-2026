extends Node2D

var scene_puck = preload("res://scenes/puck.tscn");

var pucks_in_hand = 1;

var all_pucks = [];
var current_puck = null;
var pucks_in_motion = 0;

@onready var wait_timer: Timer = $CanvasLayer/GridContainer/WaitTimerLabel/WaitTimer
@onready var wait_timer_label: Label = $CanvasLayer/GridContainer/WaitTimerLabel
@onready var pucks_counter: Label = $CanvasLayer/GridContainer/PucksCounter
@onready var game_end_label: Label = $CanvasLayer/CenterContainer/GameEndLabel
@onready var thrower: Node2D = $Thrower

@export_category("Timings")
@export var shot_time = 0.5
@export var end_time = 6.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thrower.create_puck_request.connect(create_puck)
	thrower.shoot_puck.connect(shoot_puck)
	wait_timer.timeout.connect(create_puck)
	create_puck();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wait_timer_label.text = str(snapped(wait_timer.time_left, 0.1));
	pucks_counter.text = str(pucks_in_hand) + " pucks in hand";
	update_pucks_in_motion()
	
	if pucks_in_hand == 0 and pucks_in_motion == 0 and current_puck == null and wait_timer.is_stopped():
		wait_timer.start(end_time)
		
		
	pass
	
func shoot_puck(angle, strength):
	print("shooting a puck.. with angle: ", angle, " and strength ", strength)
	
	# apply a physics impulse to the puck
	current_puck.apply_impulse(Vector2.RIGHT.rotated(angle).normalized() * strength)
	
	# if it was the last puck, wait for them all to finish timer
	if pucks_in_hand == 0:
		wait_timer_label.show();
		wait_timer.wait_time = 10.0;
		wait_timer.start();
	
	# ready up for the next shot
	pass

func create_puck():
	if pucks_in_hand > 0:
		pucks_in_hand -= 1;
		current_puck = scene_puck.instantiate();
		add_child(current_puck)
		current_puck.position = Vector2i(100,100);
		thrower.ready_up()
		all_pucks.append(current_puck);
		thrower.position = current_puck.position;
	else:
		current_puck = null;

func wait_timer_timeout():
	if current_puck == null:
		game_end_label.show();
		## game end maybe?
	else:
		create_puck()

func update_pucks_in_motion():
	var pucks_in_motion = 0
	for puck in all_pucks:
		if puck.linear_velocity.length() > 10:
			pucks_in_motion += 1;
	
