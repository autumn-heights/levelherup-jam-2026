extends Node2D

var scene_puck = preload("res://scenes/puck.tscn");

var pucks_in_hand = 3;

var total_levels = 2;
var current_level = 0;
var total_score = 0;
var puck_start_position = Vector2i(100,100);

var all_pucks = [];
var current_puck = null;
var pucks_in_motion = 0;
@onready var ui_layer: CanvasLayer = $UILayer
@onready var thrower: Node2D = $Thrower

@onready var wait_timer_label = ui_layer.wait_timer_label
@onready var wait_timer = ui_layer.wait_timer
@onready var pucks_counter = ui_layer.pucks_counter
@onready var game_end_label = ui_layer.game_end_label
@onready var level_label = ui_layer.level_label

@export_category("Timings")
@export var shot_time = 0.5
@export var end_time = 2.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#thrower.create_puck_request.connect(create_puck)
	thrower.shoot_puck.connect(shoot_puck)
	wait_timer.timeout.connect(wait_timer_timeout)
	
	current_level = 1;
	load_level(current_level);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wait_timer_label.text = str(snapped(wait_timer.time_left, 0.1));
	pucks_counter.text = str(pucks_in_hand) + " pucks in reserve";
	level_label.text = "Level " + str(current_level);
	update_pucks_in_motion()
	
	if pucks_in_hand == 0 and pucks_in_motion == 0 and current_puck == null and wait_timer.is_stopped():
		wait_timer.start(end_time)
		
		
	pass
	
func shoot_puck(angle, strength):
	print("shooting a puck.. with angle: ", angle, " and strength ", strength)
	
	# apply a physics impulse to the puck
	current_puck.freeze = 0;
	current_puck.apply_impulse(Vector2.RIGHT.rotated(angle).normalized() * strength)
	
	# if it was the last puck, wait for them all to finish timer
	if pucks_in_hand == 0:
		wait_timer_label.show();
		wait_timer.wait_time = end_time;
		wait_timer.start();
	else:
		wait_timer_label.show();
		wait_timer.wait_time = shot_time;
		wait_timer.start();
		
	

func create_puck():
	if pucks_in_hand > 0:
		pucks_in_hand -= 1;
		current_puck = scene_puck.instantiate();
		add_child(current_puck)
		current_puck.position = puck_start_position;
		current_puck.freeze = 1;
		current_puck.report_puck_stopped.connect(_on_report_puck_stopped);
		thrower.ready_up()
		all_pucks.append(current_puck);
		thrower.position = current_puck.position;
	else:
		current_puck = null;

func wait_timer_timeout():
	if current_puck == null:
		wrap_up_level();
		if current_level < total_levels:
			current_level += 1;
			load_level(current_level);
		else:
			wrap_up_game();
	else:
		create_puck()

func update_pucks_in_motion():
	pucks_in_motion = 0
	for puck in all_pucks:
		if puck.linear_velocity.length() > 10:
			pucks_in_motion += 1;

func _on_report_puck_stopped(screen_coords):
	print(screen_coords)
	#TODO report puck stopped at screen_coords

func load_level(level_id):
	#TODO unload current level if exists
	#TODO load level with id level_id
	pucks_in_hand = 3;
	create_puck();
	
func wrap_up_level():
	#TODO ask the level for how well it's coloured in and get a score
	total_score += 10
	for puck in all_pucks:
		puck.queue_free()
	all_pucks = []
	

func wrap_up_game():
	$LevelGrid.hide();
	game_end_label.show();
	
