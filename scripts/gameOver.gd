extends CanvasLayer

var world = 'res://scenes/World.tscn'

func _on_restart_pressed():
	get_tree().change_scene(world)
	pass 


func _on_quit_pressed():
	get_tree().quit()
	pass 
