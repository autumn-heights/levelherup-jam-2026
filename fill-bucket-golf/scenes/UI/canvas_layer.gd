extends CanvasLayer

@onready var wait_timer_label: Label = $InfoContainer/VBoxContainer/GridContainer/WaitTimerLabel
@onready var wait_timer: Timer = $InfoContainer/VBoxContainer/GridContainer/WaitTimerLabel/WaitTimer
@onready var pucks_counter: Label = $InfoContainer/VBoxContainer/GridContainer/PucksCounter
@onready var game_end_label = $GameEnd
@onready var level_label: Label = $InfoContainer/VBoxContainer/LevelLabel
@onready var info_container: PanelContainer = $InfoContainer
