class_name Game
extends Node2D

@onready var skyscrapers: Node = $Skyscrapers
@onready var goodzilla: Goodzilla = $Goodzilla
@onready var egg_count: RichTextLabel = %EggCount
@onready var eggcontainer: Node = $Eggs
@onready var repellants: Node = $Repellants
@onready var game_over_message: PanelContainer = $UI/GameOver
@onready var game_over_text: RichTextLabel = $UI/GameOver/MarginContainer/GameOverText
@onready var camera: Camera2D = $Camera2D
@onready var leftBounds: Node2D = $Left/Mark
@onready var rightBounds: Node2D = $Right/Mark

const EGG_COUNT = 20
const SKYSCRAPER_COUNT = 20
var eggs: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.pickup_egg.connect(on_pickup_egg)
	Events.game_over.connect(on_game_over)

	for x in range(5):
		var r = Create.Repellant()
		
		r.position = Vector2(randf_range(leftBounds.position.x, rightBounds.position.x), randf_range(500.0, 600.0))
		repellants.add_child(r)
	
	goodzilla.process_mode = Node.PROCESS_MODE_DISABLED
	goodzilla.hide()
	Engine.time_scale = 2.0
	for x in range(SKYSCRAPER_COUNT):
		await get_tree().create_timer(.05).timeout
		
		var s = Create.Skyscraper()
		
		skyscrapers.add_child(s)
		s.position = Vector2(randf_range(leftBounds.position.x, rightBounds.position.x), randf_range(0.0, 400.0))
		s.settle()
		
		
	# Increase clock speed
	
	await get_tree().create_timer(8.0).timeout
	
	for c in repellants.get_children():
		c.queue_free()

	for x in range(EGG_COUNT):
		await get_tree().create_timer(.1).timeout
		var e = Create.Egg()
		
		e.position = Vector2(randf_range(leftBounds.position.x, rightBounds.position.x), 0.0)
		eggcontainer.add_child(e)

	# Decrease clock speed
	Engine.time_scale = 1.0
	goodzilla.show()
	goodzilla.process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	camera.position.x = goodzilla.position.x

func on_pickup_egg():
	eggs += 1
	egg_count.text = str(eggs)

	if EGG_COUNT == eggs:
		Events.game_over.emit(true)

func on_game_over(win: bool):
	var result = ""
	if win:
		result = "Win!"
	else:
		result = "Lose"
	game_over_text.text = "[center]Game over!"
	game_over_text.append_text("\n%s" % result)
	game_over_message.show()
