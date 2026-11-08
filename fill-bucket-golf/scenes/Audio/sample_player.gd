extends AudioStreamPlayer2D
var thump : AudioStreamMP3 = load("res://ART/Audio/Thump_crop.mp3")
var clink : AudioStreamMP3 = load("res://ART/Audio/Clink_crop.mp3")
func _ready() -> void:
	play()

func play_sample(type: String):
	match type:
		"Wall":
			print(get_parent(), " sampler, playing a thump")
			get_stream_playback().play_stream(thump)
		"Puck":
			print(get_parent(), " sampler, playing a clink")
			get_stream_playback().play_stream(clink)
