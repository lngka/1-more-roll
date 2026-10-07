extends Node2D

@export var roll_sounds: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play()
	for die in $DiceGroup.get_children():
		die.held_changed.connect(_on_die_held_changed)


func _on_die_held_changed() -> void:
	var values: Array[int] = []
	for die in $DiceGroup.get_children():
		if die.held:
			values.append(die.value)
	$CanvasLayer/HeldScoreLabel.text = "Held: %s" % [values]


func _on_roll_button_pressed() -> void:
	var any_rolled := false
	for die in $DiceGroup.get_children():
		if die.held:
			continue
		die.roll()
		any_rolled = true
	if any_rolled:
		$RollSound.stream = roll_sounds.pick_random()
		$RollSound.play()
