extends Node

@export var sample_rate = 0.3

@export var notes = AudioStreamGenerator.new()

var t = 0
var value = 0
var last_value = 0

var highpass = 0.9
var lowpass = 0.2

func _ready() -> void: 
	last_value = randf()

func _process(delta: float) -> void:
	t += delta
	if t > sample_rate:
		t = 0
		## get new note

func filtered_noise():
	last_value = randf()
	var change = abs(last_value - value)
	if change >= lowpass  && change < highpass:
		value = last_value
