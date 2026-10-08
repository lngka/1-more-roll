extends Area2D

@export var face_textures: Array[Texture2D]
@export var selected_style: StyleBoxFlat
signal selected_changed

var roll_home: Vector2
var value := 1
var selected := false
var banked := false


func roll():
	if selected or banked:
		return
	value = randi_range(1, 6)
	_update_face()


func _update_face():
	$Face.texture = face_textures[value - 1]
	queue_redraw()
	
func _draw():
	if not selected or selected_style == null:
		return
	selected_style.draw(get_canvas_item(), $Face.get_rect())


func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_pressed("select_die"):
		if banked:
			return
		else:
			selected = not selected
			_update_face()
			selected_changed.emit()
