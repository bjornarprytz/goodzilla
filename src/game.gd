extends Node2D

@onready var skyscrapers: Node = $Skyscrapers
@onready var goodzilla: Goodzilla = $Goodzilla
@onready var egg_count: RichTextLabel = %EggCount
@onready var eggcontainer: Node = $Eggs

var eggs: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_egg.connect(on_pickup_egg)
	
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

	for x in range(6):
		await get_tree().create_timer(.1).timeout
		var e = Create.Egg()
		
		e.position = Vector2(randf_range(10.0, 1000.0), randf_range(0.0, 100.0))
		eggcontainer.add_child(e)

	# Decrease clock speed
	Engine.time_scale = 1.0
	goodzilla.show()
	goodzilla.process_mode = Node.PROCESS_MODE_INHERIT


func on_pickup_egg():
	eggs += 1
	egg_count.text = str(eggs)
