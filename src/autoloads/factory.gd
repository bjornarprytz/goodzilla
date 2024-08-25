class_name Factory
extends Node2D

var skyscraper_spawner = preload("res://world/skyscraper.tscn")
var window_spawner = preload("res://world/window.tscn")

# Add factory methods for common scenes here. Access through the Create singleton

func Skyscraper() -> Skyscraper:
	var skyscraper = skyscraper_spawner.instantiate() as Skyscraper
	
	
	skyscraper.width = randi_range(4, 8)
	skyscraper.height = randi_range(skyscraper.width + 1, 30)
	
	
	return skyscraper

func BuildingWindow() -> BuildingWindow:
	var window = window_spawner.instantiate() as BuildingWindow
	
	return window
