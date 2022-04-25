extends Label

var emergency = true
var visState = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if GlobalData.emergencyStarving:
		setEmergency(true, "Starving")
	else:
		setEmergency(false, "All clear")

func setEmergency(state, type):
	if state == false:
		emergency = false
		self.add_color_override("font_color", Color(0,0,0,1))
		self.set_text("ALL CLEAR")
		$ColourSwitch.stop()
	if state == true:
		emergency = true
		self.set_text(type)
		$ColourSwitch.start()
		

func _on_ColourSwitch_timeout():
	if emergency and visState:
		self.hide()
		#self.add_color_override("font_color", Color(1,0,0,0))
		visState = false
		return
	if emergency and visState:
		self.show()
		self.add_color_override("font_color", Color(1,0,0,1))
		visState = true
		
