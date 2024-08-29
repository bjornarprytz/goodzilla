class_name Goodzilla
extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $Animation
@onready var shape: CollisionShape2D = $Shape

# Speed settings
var speed: float = 200.0
var jump_speed: float = -400.0
var wall_climb_speed: float = 100.0

# Movement variables
var is_climbing: bool:
	get:
		return currently_climbing != null

var is_charging_jump: bool = false
var wall_normal: Vector2 = Vector2.ZERO

# Angle threshold for determining wall (in radians)
var wall_angle_threshold: float = 0.75

var currently_climbing: Skyscraper = null:
	set(val):
		if (currently_climbing == val):
			return
		currently_climbing = val

var currently_disturbing: Array[Skyscraper] = []

func _physics_process(delta: float) -> void:
	handle_input()
	apply_gravity(delta)
	move_character(delta)
	update_sprite_direction_and_rotation()

func handle_input() -> void:
	# Horizontal movement
	if Input.is_action_pressed("right"):
		velocity.x = speed
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
	elif is_on_floor():
		velocity.x = 0

	# Wall climbing
	if is_climbing:
		velocity.y = 0
		if Input.is_action_pressed("up"):
			velocity.y = -wall_climb_speed
		elif Input.is_action_pressed("down"):
			velocity.y = wall_climb_speed

	# Jumping
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and (is_on_floor() or is_climbing):
		is_charging_jump = true
		velocity = Vector2.ZERO
	elif is_charging_jump:
		var direction = global_position - get_global_mouse_position()
		velocity = direction.normalized() * jump_speed
		is_charging_jump = false
	
	if velocity == Vector2.ZERO:
		animation.animation = "idle"
	elif velocity.y != 0 and !is_climbing:
		animation.animation = "jump"
	else:
		animation.animation = "run"
	animation.play()
	

func apply_gravity(delta: float) -> void:
	if not is_climbing:
		velocity += get_gravity() * delta

func move_character(_delta: float) -> void:
	# Move the character and check for collisions
	if move_and_slide():
		var nCollisions = get_slide_collision_count()
		
		# Clear before refreshing
		for s in currently_disturbing:
			s.disturbed = false
		currently_disturbing.clear()
		
		for i in range(nCollisions):
			var collision_info = get_slide_collision(i)

			var o = collision_info.get_collider()
			if o is not Skyscraper:
				continue

			# Refresh the disturbed state
			currently_disturbing.append(o)
			o.disturbed = true

			# Check for wall collisions using angle
			if collision_info:
				var collision_angle = collision_info.get_angle(Vector2.UP)
				if abs(collision_angle) > wall_angle_threshold:
					currently_climbing = o
					wall_normal = collision_info.get_normal()
					break
				else:
					currently_climbing = null
			else:
				currently_climbing = null
	else:
		currently_climbing = null

func update_sprite_direction_and_rotation() -> void:
	# Flip the sprite based on the horizontal movement direction
	if velocity.x > 0:
		animation.flip_h = false # Facing right
	elif velocity.x < 0:
		animation.flip_h = true # Facing left

	# Rotate the sprite if climbing
	if is_climbing:
		# Calculate the rotation in degrees based on the wall's normal
		var r = -(wall_normal.angle_to(Vector2.UP) * 180 / PI)
		animation.rotation_degrees = r
		shape.rotation = r
	else:
		# Reset the rotation when not climbing
		animation.rotation_degrees = 0
		shape.rotation = 0


func _on_pickup_zone_body_entered(body: Node2D) -> void:
	if body is Egg:
		Events.pickup_egg.emit()
		body.queue_free()
