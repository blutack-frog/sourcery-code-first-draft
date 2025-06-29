extends Control
#all code here stolen from this tutorial: https://www.gotut.net/loading-screen-in-godot-4/#:~:text=Starting%20scene%201%20Got%20to%20Scene%20%3E%20New,Signals%2C%20connect%20the%20pressed%28%29%20signal%20to%20that%20script.

const battle_scene_path = "res://scenes/battle_scene.tscn"
var loading_status: int
var progress: Array[float]

@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResourceLoader.load_threaded_request(battle_scene_path)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loading_status = ResourceLoader.load_threaded_get_status(battle_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0]*100
		ResourceLoader.THREAD_LOAD_LOADED:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(battle_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error. could not load BattleScene")
