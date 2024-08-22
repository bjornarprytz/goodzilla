class_name Skyscraper
extends RigidBody2D
@onready var container: MarginContainer = $Container
@onready var windows: FlowContainer = %Windows

# In windows
var width: int
# In floors
var height: int

const windowSize = 8
const faceMargins = 4

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
		windows.add_child(w)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
