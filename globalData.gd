extends Node


# Stores global data for the game


var resources = 10
var food = 10
var military = 5

var emergencyStarving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if food <= 0:
		food = 0
		emergencyStarving = true
	if food > 0:
		emergencyStarving = false
