extends CanvasLayer

static var punctuation_time = 0.35
static var comma_time = 0.2
static var letter_time = 0.04

@onready var dialogue_box = $DialogueBoxContainer
@onready var speaker_container = $SpeakerContainer

@onready var speaker = $DialogueBoxContainer/NameContainer/HBoxContainer3/Name
@onready var content = $DialogueBoxContainer/TextContainer/HBoxContainer/Text
@onready var continue_symbol = $DialogueBoxContainer/TextContainer/HBoxContainer/Continue
@onready var timer = $DialogueBoxContainer/LetterDisplayTimer
@onready var speaker1 = $SpeakerContainer/Container/Speaker1
@onready var speaker2 = $SpeakerContainer/Container2/Speaker2

var next_text
var i = 0
var itemData = {}
var dialogue_file_path = "res://textbox/dialogue_scripts/test.txt"
var file

static var finished_displaying = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hide_textbox()
    read_file(dialogue_file_path)
    
func _input(event):
    if finished_displaying:
        if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            speaker.text = ""
            content.text = ""
            continue_symbol.text = ""
            finished_displaying = false
            if file.eof_reached():
                file.close()
                hide_textbox()
            else:
                #get next dialogue
                add_next(file.get_line(), file.get_line())
    else:
        if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            content.text = next_text
            i = next_text.length()

#Hides the textbox when not in use
func hide_textbox():
    speaker.text = ""
    content.text = ""
    continue_symbol.text = ""
    speaker1.material.set("shader_parameter/off", true)
    speaker2.material.set("shader_parameter/off", true)
    speaker_container.hide()
    i = 0
    dialogue_box.hide()

#displays letter one at a time
func _display_letter():
    if(i >=next_text.length()):
        finished_displaying = true
        continue_symbol.text = ". . . v"
        i = 0
        return
    content.text += next_text[i]
    match next_text[i]:
        "!", ".", "?":
            timer.start(punctuation_time)
        ",":
            timer.start(comma_time)
        _:
            timer.start(letter_time)
    i +=1
    
#sets up text
func add_next(next_speaker, nt):
    speaker.text = next_speaker + ":"
    active_speaker(next_speaker)
    next_text = nt
    speaker_container.show()
    dialogue_box.show()
    _display_letter()
    
#brings active speaker forwards and sends other back
func active_speaker(talker):
    if(talker == "Talos"):
        speaker1.material.set("shader_parameter/off", true)
        speaker2.material.set("shader_parameter/off", false)
    elif(talker == "Kiko"):
        speaker1.material.set("shader_parameter/off", false)
        speaker2.material.set("shader_parameter/off", true)

# This function reads a file line by line
func read_file(file_path: String) -> void:
    # Open the file for reading
    if FileAccess.file_exists(file_path):
        file = FileAccess.open(file_path, FileAccess.READ)
        add_next(file.get_line(), file.get_line())
    else:
        push_error("Missing Dialogue File")

func _on_letter_display_timer_timeout() -> void:
    _display_letter()
