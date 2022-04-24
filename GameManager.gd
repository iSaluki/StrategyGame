extends Control

# Base vars
export var resources = 80
export var population = 5
export var military = 0
export var countries = ["Spain", "England", "France", "USA"]
var country = countries[0]
var cities = []
var cityIndex = 1

var cityBase = preload("cityBase.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	match country:
		"Spain":
			resources += 10
			population += 1
			military += 5
			cities = ["Madrid", "Barcelona", "Seville", "Bilbao", "Valencia", "Granada"]
		"England":
			resources += 50
			population -= 1
			military += 10
			cities = ["London", "Birmingham", "Manchester", "Hull", "Worcester", "Gloucester"]
		"France":
			resources += 5
			population += 1
			military += 2
			cities = ["Paris", "Calais", "Bordeaux", "Dunkirk", "Dijon", "Mulhouse"]
		"USA":
			population += 10
			military += 20
			cities = ["Washington", "New York", "San Francisco", "Detroit", "Chicago"]
	$CitiesLabel/CityContainer/VSplitContainer/CapitalCity.set_text(cities[0])
	
	
func _process(delta):
	$ResourcesLabel.set_text("Resources: "+ str(resources))
	$PopulationLabel.set_text("Population: "+ str(population))
	$MilitaryLabel.set_text("Military: "+ str(military))

# FIXME: When more than two cities are made, the system breaks and they begin overlapping
func _on_NewCityBtn_pressed():
	if resources >= 40:
		# Create city
		var createUnder = $CitiesLabel/CityContainer/VSplitContainer
		resources -= 40
		var newCity = cityBase.instance()
		createUnder.add_child(newCity)
		newCity.set_text(cities[cityIndex])
		cityIndex += 1
