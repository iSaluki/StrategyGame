extends Panel


export var cityActive = false
export var cityID = -1

export var pop = 1
export var prod = 1

var cityName = ""


var upgradeScale = 1
var baseUpPrice = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func toggleActive(state):
	if state == true:
		$Name.set_text(cityName)
		self.show()
	if state == false:
		self.hide()

func _process(delta):
	$Pop.set_text("Population: "+ str(pop))
	$Prod.set_text("Production: "+ str(prod))


func _on_Button_pressed():
	if GlobalData.resources >= baseUpPrice:
		prod += 1
		GlobalData.resources -= baseUpPrice
		
		
		
