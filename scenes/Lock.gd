extends Area3D
class_name Lock
@export var lock_id : int = 1

signal unlock

func _on_body_entered(body: Node3D) -> void:
	for c in body.get_children():
		if c is Inventory:
			for i in c.ItemArray:
				if i is Key:# new knowledge "is" != "=="
					print("is key")
					if i.key_id == lock_id:
						print("is the right key")
						unlock.emit()
