extends Panel
class_name DialogueBox

@onready var label: Label = $MarginContainer/Label

var delay: bool  = true

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	
	display_text("Her Highness is bright and generous. This subject has been treated with care and more each day.")

func _process(_delta: float) -> void:
	pass

func display_text(text: String):
	# Clear the text first
	label.text = ""
	
	# Stagger the display of the text
	for char in text:
		# ... only if the delay bool is true, that way we can skip the delay by
		# toggling the delay bool
		if delay:
			await get_tree().create_timer(0.01).timeout
		label.text += char
	
	# Reset the delay mode to true
	delay = true

func _on_gui_input(event: InputEvent):
	# If the DialogueBox is clicked, "skip" the text delay by toggling
	# the delay to false
	if event.is_action_pressed("left_click"):
		delay = false
