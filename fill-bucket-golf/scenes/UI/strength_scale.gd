extends TextureProgressBar
@onready var under_progress_bar: TextureProgressBar = $TextureProgressBar

var my_value = 0:
	set(mv):
		value = mv
		my_value = mv
		if under_progress_bar != null:
			under_progress_bar.value = mv

func _ready() -> void:
	my_value = my_value
