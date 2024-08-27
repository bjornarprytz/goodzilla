class_name Skyscraper
extends RigidBody2D
@onready var container: MarginContainer = $Container
@onready var windowsContainer: FlowContainer = %Windows

var rotation_speed = 4

# In windows
var width: int
# In floors
var height: int

const windowSize = 8
const faceMargins = 4

var windows: Array[BuildingWindow] = []

var alertness: float = 0.0

var alertness_rate: float = 10.0
var calm_rate: float = 0.0

var disturbed: bool = false
var settled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = (Vector2(width, height) * windowSize) + (Vector2.ONE * faceMargins * 2)
	
	$Collision.shape = RectangleShape2D.new()
	$Collision.shape.size = size
	$Collision.position = (size * Vector2(.5, -.5))
	
	$Shape.size = size
	$Shape.position.y = -size.y
	
	container.size = size
	container.position.y = -size.y
	
	
	var nWindows: int = width * (height)
	
	for r in nWindows:
		var w = Create.BuildingWindow()
		windowsContainer.add_child(w)
		windows.push_back(w)
		w.turnOff()
	
	windows.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disturbed:
		alertness += delta * alertness_rate
	else:
		alertness = max(alertness - delta * calm_rate, 0)

	var threshold: int = int(alertness)

	for i in range(windows.size()):
		if i < threshold:
			windows[i].turnOn()
		else:
			windows[i].turnOff()
	
	if threshold > windows.size():
		Events.game_over.emit(false)

func _physics_process(delta: float) -> void:
	# Rotate towards standing up
	if not settled:
		if rotation < 0:
			angular_velocity = delta * rotation_speed
		elif rotation > 0:
			angular_velocity = -delta * rotation_speed

func settle() -> void:
	const settle_time = 5.0
	
	var bouncy_tween = create_tween()

	bouncy_tween.tween_property(self, "physics_material_override:bounce", 0.0, settle_time)

	await bouncy_tween.finished

	print("Settling ", name)
	while linear_velocity.length() > 0.1:
		await get_tree().create_timer(.1).timeout
	
	freeze = true
	settled = true
	print("Settled", name)
