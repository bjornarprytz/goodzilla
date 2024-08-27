class_name Factory
extends Node2D

var skyscraper_spawner = preload("res://world/skyscraper.tscn")
var window_spawner = preload("res://world/window.tscn")
var egg_spawner = preload("res://world/egg.tscn")
var repellant_spawner = preload("res://world/repellant.tscn")

# Add factory methods for common scenes here. Access through the Create singleton

func Skyscraper() -> Skyscraper:
	var skyscraper = skyscraper_spawner.instantiate() as Skyscraper
	
	
	skyscraper.width = randi_range(6, 10)
	skyscraper.height = randi_range(skyscraper.width + 1, 30)
	
	
	return skyscraper

func BuildingWindow() -> BuildingWindow:
	var window = window_spawner.instantiate() as BuildingWindow
	
	return window

func Egg() -> Egg:
	var egg = egg_spawner.instantiate() as Egg
	
	return egg

func Repellant() -> Repellant:
	var repellant = repellant_spawner.instantiate() as Repellant
	
	return repellant
