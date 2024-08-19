class_name Factory
extends Node2D

var skyscraper_spawner = preload("res://world/skyscraper.tscn")

# Add factory methods for common scenes here. Access through the Create singleton

func Skyscraper() -> Skyscraper:
	var skyscraper = skyscraper_spawner.instantiate() as Skyscraper
		
	skyscraper.size = Vector2(randf_range(50.0, 100.0), randf_range(30.0, 200.0))
	
	return skyscraper
