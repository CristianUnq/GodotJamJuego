extends Node

var is_paused = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused

func reset_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("pause"):
		GameManager.toggle_pause()

	if event.is_action_pressed("reset"):
		GameManager.reset_game()	
