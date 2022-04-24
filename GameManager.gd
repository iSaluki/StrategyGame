extends Control

# Base vars
export var resources = 80
export var population = 5
export var military = 0
export var countries = ["Spain", "England", "France", "USA"]
var country = countries[0]
var cities = []
var cityIndex = 1



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
	$CitiesLabel/CityContainer/VSplitContainer/City0/Name.set_text(cities[0])
	$CitiesLabel/CityContainer/VSplitContainer/City0.toggleActive(true)
	
	
func _process(delta):
	#$ResourcesLabel.set_text("Resources: "+ str(resources)) -- Obsolete, moved to city script
	#$PopulationLabel.set_text("Population: "+ str(population)) -- Obsolete, moved to city script
	$MilitaryLabel.set_text("Military: "+ str(military))


func _on_NewCityBtn_pressed():
	if resources >= 40 and cityIndex !=4:
		# Create city
		resources -= 40
		var newCity = get_node("/root/Game/CitiesLabel/CityContainer/VSplitContainer/City"+str(cityIndex))
		newCity.toggleActive(true)
		cityIndex += 1


func _on_TickTimer_timeout():
	for c in cityIndex:
		var city = get_node("/root/Game/CitiesLabel/CityContainer/VSplitContainer/City"+str(c))
		# Population growth
		var randVal = randf()
		if randVal < 0.8:
			pass
		if randVal < 0.2:
			city.pop += 1
		
		# Resource production
		randVal = randf()
		if randVal < 0.2:
			pass
		if randVal < 0.8:
			resources += city.prod * city.pop
		
