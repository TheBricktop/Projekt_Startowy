extends Node3D
class_name Pickup_Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pick_up(body : Node3D) -> void:
	for node in body.get_children():
		if node is Inventory:
			node._add_to_inventory(self)

func _on_player_detector_body_entered(body: Node3D) -> void:
		if body is PlayerController:
			_pick_up(body)
