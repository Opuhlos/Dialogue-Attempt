extends Panel
class_name DialogueBox

@onready var label: Label = $MarginContainer/Label

var delay: bool  = true
var is_displaying: bool = false

var dialogue_one: String = "You spoke with such ferocity the other day that I thought you would have our heads, your Majesty."
var dialogue_two: String = "Allow me to apologize on behalf of the Order. It was entirely my fault that things turned out this way."
var dialogue_three: String = "So please, if anything..."

var dialogue_array: Array = [dialogue_one, dialogue_two, dialogue_three]

var dialogue_index: int = 0

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	
	display_text(dialogue_array[dialogue_index])

func _process(_delta: float) -> void:
	pass

func display_text(text: String):
	# Clear the text first
	label.text = ""
	
	# Set the displaying bool to true
	is_displaying = true
	
	# Stagger the display of the text
	for char in text:
		# ... only if the delay bool is true, that way we can skip the delay by
		# toggling the delay bool
		if delay:
			await get_tree().create_timer(0.01).timeout
		label.text += char
	
	# Reset the delay mode to true
	delay = true
	
	# Reset the displaying boo
	is_displaying = false

func close_dialogue_box() -> void:
	$".".hide()

func _on_gui_input(event: InputEvent):
	
	if event.is_action_pressed("left_click"):
		# Close the dialogue box if this is the last line in the current dialogue array
		if dialogue_index == dialogue_array.size() - 1:
			close_dialogue_box()
			return
			
		# If the DialogueBox is clicked while text is being displayed, "skip" the text delay by toggling
		# the delay to false
		if is_displaying:
			delay = false
		# If the DialogueBox is clicked after the text has finished displaying, proceed to the next
		# dialogue line
		elif !is_displaying:
			dialogue_index = mini(dialogue_index + 1, dialogue_array.size() - 1)
			display_text(dialogue_array[dialogue_index])
