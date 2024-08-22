class_name BuildingWindow
extends MarginContainer


func turnOn():
	$Alertness.value = 100
	
func turnOff():
	$Alertness.value = 0
