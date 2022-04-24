extends Panel


export var cityActive = false
export var cityID = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func toggleActive(state):
	if state == true:
		self.show()
	if state == false:
		self.hide()
