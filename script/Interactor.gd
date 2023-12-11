extends Node
class_name Interactor
@export var raycast : RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if raycast and raycast.get_collider():
		var c = raycast.get_collider()
