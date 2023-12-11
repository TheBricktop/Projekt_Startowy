extends Node
class_name Inventory

@export var ItemArray : Array
@export var HandSocket : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_to_inventory(node:Node3D):
	ItemArray.append(node)
	node.reparent(HandSocket)
	node.basis = Basis()
	node.position = Vector3.ZERO
	

