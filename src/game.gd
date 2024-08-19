extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(10):
		await get_tree().create_timer(1).timeout
		
		var s = Create.Skyscraper()
		
		add_child(s)
		s.position = Vector2(randf_range(10.0, 500.0), randf_range(0.0, 400.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
