extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func _on_timer_timeout():
	$Message.hide()
