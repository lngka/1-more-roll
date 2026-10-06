extends Area2D

@export var face_textures: Array[Texture2D]
@export var held_style: StyleBoxFlat


var value := 1
var held := false


func roll():
	if held:
		return
	value = randi_range(1, 6)
	_update_face()


func _update_face():
	$Face.texture = face_textures[value - 1]
	queue_redraw()
	
func _draw():
	if not held or held_style == null:
		return
	held_style.draw(get_canvas_item(), $Face.get_rect())


func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_pressed("select_die"):
		held = not held
		_update_face()
