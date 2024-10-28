extends Node3D
@onready var target = $"../target"
@onready var target2 = $"../target2"
@onready var target3 = $"../target3"
@onready var timer = $"../Timer"
@onready var timer2 = $"../Timer2"
@onready var timer3 = $"../Timer3"

@onready var score = 0

@onready var scorelabel = $"../UserInterface/player_ui/Panel/Label"
func _ready() -> void:
	#var target = $"../target"
	pass

func _process(delta: float) -> void:

	if GlobalScript.network_position != Vector3.ZERO:
		position.x = GlobalScript.network_position.x
		position.y = (-1*GlobalScript.network_position.y)*2
		position.z = GlobalScript.network_position.z + 2

	target.rotate_x(0.05 + delta)
	target2.rotate_x(0.05 + delta)
	target3.rotate_x(0.05 + delta)
	
	if timer.is_stopped():
		target.visible = true
		
	if timer2.is_stopped():
		target2.visible = true
		
	if timer3.is_stopped():
		target3.visible = true		


func _on_area_3d_area_entered(area: Area3D) -> void:
	timer.start()
	target.visible = false
	score += 1
	#scorelabel.text("Score asdf ")

func _on_area_target_2_area_entered(area: Area3D) -> void:
	timer2.start()
	target2.visible = false
	score += 1
	
func _on_area_target_3_area_entered(area: Area3D) -> void:
	timer3.start()
	target3.visible = false
	score += 1
