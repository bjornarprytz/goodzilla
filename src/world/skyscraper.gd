class_name Skyscraper
extends RigidBody2D
@onready var container: MarginContainer = $Container
@onready var windowsContainer: FlowContainer = %Windows

# In windows
var width: int
# In floors
var height: int

const windowSize = 8
const faceMargins = 4

var windows: Array[BuildingWindow] = []

var alertness: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = (Vector2(width, height) * windowSize) + (Vector2.ONE * faceMargins * 2)
	
	print (size)
	
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
	if get_contact_count() > 0:
		alertness += delta
	if alertness > 0:
		var n = min((windows.size() * (alertness / 50.0)), windows.size()-1)
		
		for i in range(n):
			windows[i].turnOn()
