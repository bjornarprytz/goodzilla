extends Node2D

@onready var skyscrapers: Node = $Skyscrapers
@onready var goodzilla: Goodzilla = $Goodzilla

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goodzilla.process_mode = Node.PROCESS_MODE_DISABLED
	goodzilla.hide()
	Engine.time_scale = 2.0
	for x in range(12):
		await get_tree().create_timer(.05).timeout
		
		var s = Create.Skyscraper()
		
		skyscrapers.add_child(s)
		s.position = Vector2(randf_range(10.0, 1000.0), randf_range(0.0, 400.0))
		s.settle()

	# Increase clock speed
	
	await get_tree().create_timer(8.0).timeout

	# Decrease clock speed
	Engine.time_scale = 1.0
	goodzilla.show()
	goodzilla.process_mode = Node.PROCESS_MODE_INHERIT
