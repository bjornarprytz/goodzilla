extends Node2D

@onready var skyscrapers: Node = $Skyscrapers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(10):
		await get_tree().create_timer(.05).timeout
		
		var s = Create.Skyscraper()
		
		skyscrapers.add_child(s)
		s.position = Vector2(randf_range(10.0, 1000.0), randf_range(0.0, 400.0))

	await get_tree().create_timer(5.0).timeout

	for s in skyscrapers.get_children():
		s.settle()
