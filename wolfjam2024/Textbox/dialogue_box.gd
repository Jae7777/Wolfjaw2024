extends CanvasLayer

static var punctuation_time = 0.2
static var letter_time = 0.025

@onready var dialogue_box = $DialogueBoxContainer
@onready var speaker = $DialogueBoxContainer/NameContainer/HBoxContainer3/Name
@onready var content = $DialogueBoxContainer/TextContainer/HBoxContainer/Text
@onready var continue_symbol = $DialogueBoxContainer/TextContainer/HBoxContainer/Continue
@onready var timer = $DialogueBoxContainer/LetterDisplayTimer

static var next_text
static var i = 0


signal finished_displaying()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hide_textbox()
    add_next("Me","According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees don't care what humans think is impossible. Yellow, black. Yellow, black. Yellow")

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        content.text = next_text
        i = next_text.length()
        _display_letter()

#Hides the textbox when not in use
func hide_textbox():
    speaker.text = ""
    content.text = ""
    continue_symbol.text = ""
    i = 0
    dialogue_box.hide()

#displays letter one at a time
func _display_letter():
    if(i >=next_text.length()):
        finished_displaying.emit()
        punctuation_time = 0.1
        letter_time = 0.015
        continue_symbol.text = ". . . v"
        return
    content.text += next_text[i]
    match next_text[i]:
        "!", ".", ",", "?":
            timer.start(punctuation_time)
        _:
            timer.start(letter_time)
    i +=1

#Shows textbox, takes in speaker and text
func show_textbox():
    dialogue_box.show()
    _display_letter()
    

func add_next(next_speaker, nt):
    speaker.text = next_speaker + ":"
    next_text = nt
    show_textbox()


func _on_letter_display_timer_timeout() -> void:
    _display_letter()
