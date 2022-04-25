extends Control

# Base vars
var capPop = 0
export var military = 0
export var countries = ["Spain", "England", "France", "USA"]
var country = countries[0]
var cities = []
var cityIndex = 1

# Emergency Variables
var starving = false


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalData.resources += 100
	match country:
		"Spain":
			GlobalData.resources += 10
			capPop = 3
			GlobalData.military += 5
			cities = ["Madrid", "Barcelona", "Seville", "Bilbao", "Valencia", "Granada"]
		"England":
			GlobalData.resources += 50
			capPop = 4
			GlobalData.military += 10
			cities = ["London", "Birmingham", "Manchester", "Hull", "Worcester", "Gloucester"]
		"France":
			GlobalData.resources += 5
			capPop = 2
			GlobalData.military += 2
			cities = ["Paris", "Calais", "Bordeaux", "Dunkirk", "Dijon", "Mulhouse"]
		"USA":
			capPop = 10
			GlobalData.military += 20
			cities = ["Washington", "New York", "San Francisco", "Detroit", "Chicago"]
	
	# Setup capital
	
	$CitiesLabel/CityContainer/VSplitContainer/City0.cityName = str(cities[0])
	$CitiesLabel/CityContainer/VSplitContainer/City0.toggleActive(true)
	$CitiesLabel/CityContainer/VSplitContainer/City0.pop = capPop
	
	
func _process(delta):
	$ResourcesLabel.set_text("Materials: "+ str(GlobalData.resources))
	#$PopulationLabel.set_text("Population: "+ str(population)) -- Obsolete, moved to tick + city script
	$MilitaryLabel.set_text("Military: "+ str(GlobalData.military))
	$FoodLabel.set_text("Food: "+ str(GlobalData.food))


func _on_NewCityBtn_pressed():
	if GlobalData.resources >= 40 and cityIndex !=4:
		# Create city
		GlobalData.resources -= 40
		var newCity = get_node("/root/Game/CitiesLabel/CityContainer/VSplitContainer/City"+str(cityIndex))
		newCity.cityName = cities[cityIndex]
		newCity.toggleActive(true)
		cityIndex += 1


func _on_TickTimer_timeout():
	var totalPop = 0
	for c in cityIndex:
		var city = get_node("/root/Game/CitiesLabel/CityContainer/VSplitContainer/City"+str(c))
		
		var designation = city.designation
		
		
		# Population growth
		if not starving:
			var randVal = randf()
			if randVal < 0.8:
				pass
			if randVal < 0.2:
				city.pop += 1
			totalPop += city.pop
		# Resource production, including designation
		var randVal = randf()
		if randVal < 0.2:
			pass
		if randVal < 0.8:
			if designation == "Resources" and not starving:
				GlobalData.resources += city.prod * city.pop
			if designation == "Resources" and starving:
				GlobalData.resources += (city.prod * city.pop) / 2
			if designation == "Food" and not starving:
				GlobalData.food += city.prod * city.pop
			if designation == "Food" and starving:
				GlobalData.food += (city.prod * city.pop) / 2
			if designation == "Military" and not starving:
				GlobalData.military += city.prod * city.pop
			if designation == "Military" and starving:
				GlobalData.military += (city.prod * city.pop) / 2
	$PopulationLabel.set_text("Population: "+ str(totalPop))
		
	# Food consumption
	
	GlobalData.food -= totalPop
