extends Node3D
@export var target : Node3D
@export var rot_offset : Vector3
@export var pos_offset : Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		self.position = target.position
		self.rotation = target.rotation
		self.rotation *= rot_offset
		self.translate_object_local(pos_offset)
	pass
