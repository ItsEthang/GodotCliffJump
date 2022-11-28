extends CanvasLayer

func _ready():
	get_tree().paused = true

func _on_ContinueButton_pressed():
	get_tree().paused = false
	queue_free()


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu.tscn")
