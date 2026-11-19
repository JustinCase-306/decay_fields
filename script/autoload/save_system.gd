extends Node
const save_path = "user://savegame.cfg" # does work on linux too

# save scene + pos
func save_game(scene_path: String, player_position: Vector2) -> void:
	var config := ConfigFile.new()
	config.set_value("World", "current_scene", scene_path)
	config.set_value("World", "player_position", player_position)
	var error := config.save(save_path)
	if error != OK:
		print("Failed to save game: ", error)
	
# load scene + pos
func load_game() -> Dictionary:
	var config := ConfigFile.new()
	var error := config.load(save_path)
	
	var default_data := {
		"current_scene": "res://scenes/world/maps/map_house_start.res",
		"player_position": Vector2(100,100)
	}
	
	if error != OK:
		print("Didn't find any saved game. Return to default map...")
		return default_data
		
	return{
		"current_scene": config.get_value("World", "current_scene", default_data["current_scene"]),
		"player_position": config.get_value("World", "player_position", default_data["player_position"])
	}
