extends Node3D
@export var player_name = "player_template"
@export var animationName = "otwieranie"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_drzwi_area_body_entered(body: Node3D) -> void:
		if body.name == player_name :
			$AnimationPlayer.play('otwieranie')


func _on_drzwi_area_body_exited(body: Node3D) -> void:
		if body.name == player_name :
			$AnimationPlayer.play_backwards('otwieranie')
