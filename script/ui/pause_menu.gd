extends Control

@export var main_menu_scene: PackedScene
@onready var panel: Control = $PauseMenu/Visibility

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		panel.visible = not panel.visible
		get_tree().paused = panel.visible
		
func _on_continue_pressed() -> void:
	panel.visible = false
	get_tree().paused = false
	
func _on_quit_pressed() -> void:
	save_progress()
	get_tree().quit()
	
func _on_game_menu_pressed() -> void:
	save_progress()
	if main_menu_scene:
		get_tree().paused = false
		get_tree().change_scene_to_packed(main_menu_scene)
		
func save_progress() -> void:
	var scene_path := get_tree().current_scene.scene_file_path
	var player_pos: Vector2 = %Player.global_position
	SaveSystem.save_game(scene_path, player_pos)
