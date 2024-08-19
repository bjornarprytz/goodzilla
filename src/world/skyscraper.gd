class_name Skyscraper
extends RigidBody2D

@onready var windowContainer: Node = $Windows

var size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	$Shape.size = size
	$Collision.shape.size = size
	$Collision.position = size * Vector2(.5, -.5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
