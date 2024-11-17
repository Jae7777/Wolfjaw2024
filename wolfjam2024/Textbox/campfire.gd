extends CanvasLayer

static var punctuation_time = 0.35
static var comma_time = 0.2
static var letter_time = 0.1

@onready var dialogue_box = $DialogueBoxContainer
@onready var speaker_container = $SpeakerContainer

@onready var speaker = $DialogueBoxContainer/NameContainer/HBoxContainer3/Name
@onready var content = $DialogueBoxContainer/TextContainer/HBoxContainer/Text
@onready var continue_symbol = $DialogueBoxContainer/TextContainer/HBoxContainer/Continue
@onready var timer = $DialogueBoxContainer/LetterDisplayTimer
@onready var speaker1 = $SpeakerContainer/Container/Speaker1
@onready var speaker2 = $SpeakerContainer/Container2/Speaker2

@onready var audio_player = $AudioStream
@onready var kiko_sound = preload("res://Textbox/Kiko.mp3")
@onready var talos_sound = preload("res://Textbox/Talos.mp3")

var next_text
var i = 0
var itemData = {}
var dialogue_file_path = "res://textbox/dialogue_scripts/walking.txt"
var file

static var finished_displaying = false

var sfx

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
                TransitionScreen.transition()
                await TransitionScreen.on_transition_finished
                get_tree().change_scene_to_file("res://scenes/level.tscn")
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

# Displays letter one at a time with appropriate timing for punctuation
func _display_letter() -> void:
    if i >= next_text.length():
        # All letters have been displayed, mark as finished
        finished_displaying = true
        continue_symbol.text = ". . . v"  # Show continue symbol
        i = 0  # Reset for next dialogue
        return
    
    # Get the next character from the text
    var current_char = next_text[i]

    # Add the character to the content text box
    content.text += current_char

    # Handle timing based on punctuation or general letters
    match current_char:
        "!", ".", "?", "-":
            timer.start(punctuation_time)
            i += 1
        ",":
            timer.start(comma_time)
            i += 1
        " ":
            timer.start(letter_time)
            i += 1
        _:
            timer.start(letter_time)

            # Increment the index to the next letter
            i += 1
            # Play sound effect with slight pitch variation
            var new_audio_player = audio_player.duplicate()
            new_audio_player.pitch_scale += randf_range(-0.1, 0.1)  # Random pitch variation
            if current_char in ["a", "e", "i", "o", "u"]:
                new_audio_player.pitch_scale += 0.2  # Slight pitch boost for vowels

            # Add the audio player to the scene tree and play sound
            get_tree().root.add_child(new_audio_player)
            new_audio_player.play()

            # Wait until the audio finishes before continuing
            await new_audio_player.finished
            new_audio_player.queue_free()  # Clean up the audio player

            
    
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
        audio_player.stream = talos_sound
    elif(talker == "Kiko"):
        speaker1.material.set("shader_parameter/off", false)
        speaker2.material.set("shader_parameter/off", true)
        audio_player.stream = kiko_sound

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
