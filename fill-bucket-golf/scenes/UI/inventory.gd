extends Node2D

var scene_puck = preload("res://scenes/puck.tscn");

const PUCK_DISPLAY_OFFSET = Vector2(25, 0)

var my_display_pucks = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_display_pucks(colour_id_array):
	#print(add_display_pucks)
	for colour_id in colour_id_array:
		var new_puck = scene_puck.instantiate()
		my_display_pucks.append(new_puck)
		add_child(new_puck)
		new_puck.set_puck_colour(colour_id)
		new_puck.position = PUCK_DISPLAY_OFFSET*my_display_pucks.size()
		#print('position: ', position, ', new_puck.position: ', new_puck.position)
		new_puck.freeze = true
		new_puck.freeze_mode = 0
		#print(new_puck, ', ', new_puck.position)
		
func remove_display_puck():
	var puck_to_remove = my_display_pucks.pop_back()
	puck_to_remove.queue_free()
