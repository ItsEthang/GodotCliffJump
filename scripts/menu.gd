extends CanvasLayer

func _on_play_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
	pass 


func _on_quit_pressed():
	get_tree().change_scene("res://scenes/thanks.tscn")
	pass
