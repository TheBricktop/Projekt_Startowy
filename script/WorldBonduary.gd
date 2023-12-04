extends Node3D

@export var player : String = "PlayerTemplate"
@export var mapName : String = "res://scenes/PlayGround.tscn"

func _on_bonduary_body_entered(body: Node3D) -> void:
	if body.name == player:
		SceneManager.change_scene(mapName)
