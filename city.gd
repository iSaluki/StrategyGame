extends Panel


export var cityActive = false
export var cityID = -1
export var playerControlled = true
export var designation = "Resources" #TODO: Optimize variable type


export var pop = 1
export var prod = 1

var cityName = ""


var popup = Node
var upgradeScale = 1
var baseUpPrice = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	popup = $Designation.get_popup()
	popup.connect("id_pressed", self, "designationUpdate")


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
		
func designationUpdate(ID):
	if ID == 0:
		designation = "Resources"
		$Designation.set_text("Materials")
	if ID == 1:
		designation = "Food"
		$Designation.set_text("Food")
	if ID == 2:
		designation = "Military"
		$Designation.set_text("Military")
	else:
		pass
		#TODO: Error pass
		
