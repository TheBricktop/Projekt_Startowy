extends CharacterBody3D

@export var player_mesh : Node3D
# Gamplay mechanics and Inspector tweakables
@export var gravity = 9.8
@export var jump_force = 9
@export var walk_speed = 3
@export var run_speed = 8

# Condition States
var is_walking = bool(); var is_running = bool()

# Physics values
var direction = Vector3()
var horizontal_velocity = Vector3()
var aim_turn = float()
var movement = Vector3()
var vertical_velocity = Vector3()
var movement_speed = float()
var angular_acceleration = int()
var acceleration = int()

func _ready(): # Camera based Rotation
	direction = Vector3.BACK.rotated(Vector3.UP, $Camroot/h.global_transform.basis.get_euler().y)

func _input(event): # All major mouse and button input events
	if event is InputEventMouseMotion:
		aim_turn = -event.relative.x * 0.015 # animates player with mouse movement while aiming 

func _physics_process(delta):	
	var on_floor = is_on_floor() # State control for is jumping/falling/landing
	var h_rot = $Camroot/h.global_transform.basis.get_euler().y
	
	# movement_speed = 0
	angular_acceleration = 10
	acceleration = 15

	# Gravity mechanics and prevent slope-sliding
	if not is_on_floor(): 
		vertical_velocity += Vector3.DOWN * gravity * 2 * delta
	else: 
		#vertical_velocity = -get_floor_normal() * gravity / 3
		vertical_velocity = Vector3.DOWN * gravity / 10
	
#	Jump input and Mechanics
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vertical_velocity = Vector3.UP * jump_force
		
	# Movement input, state and mechanics. *Note: movement stops if attacking
	if (Input.is_action_pressed("forward") ||  Input.is_action_pressed("backward") ||  Input.is_action_pressed("left") ||  Input.is_action_pressed("right")):
		var vec : Vector2 = Input.get_vector("left","right","forward","backward")
		direction = Vector3(vec.x,0,vec.y)
		direction = direction.rotated(Vector3.UP, h_rot).normalized()
		movement_speed = lerpf(movement_speed,walk_speed,2*delta)
		is_walking = true
		
	# Sprint input, dash state and movement speed
		if Input.is_action_pressed("sprint")  and (is_walking == true ):
			movement_speed = lerpf(movement_speed,run_speed,.5)
			
			is_running = true
		else: # Walk State and speed
			movement_speed = lerpf(movement_speed,walk_speed,4*delta)
			is_running = false
	else: 
		is_walking = false
		is_running = false
		movement_speed = 0
	
	player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta * angular_acceleration)
	
	# Movment mechanics with limitations during rolls/attacks
	horizontal_velocity = horizontal_velocity.lerp(direction.normalized() * movement_speed, acceleration * delta)
	
	# The Physics Sauce. Movement, gravity and velocity in a perfect dance.
	velocity.z = horizontal_velocity.z + vertical_velocity.z
	velocity.x = horizontal_velocity.x + vertical_velocity.x
	velocity.y = vertical_velocity.y
	$AnimationTree["parameters/BlendTree/Walking/blend_position"] = horizontal_velocity.length() / run_speed
	$AnimationTree["parameters/conditions/isWalking"] = is_walking
	$AnimationTree["parameters/conditions/notWalking"] = ! is_walking
	move_and_slide()

func _foot_step()-> void :
	if is_on_floor():
		$AudioStreamPlayer3D.play()
