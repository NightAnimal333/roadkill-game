extends CanvasLayer

onready var label = $RichTextLabel
onready var textbox = $TextureRect
onready var chara_timer = $RichTextLabel/CharacterTimer
onready var disa_timer = $RichTextLabel/DisappearTimer

var json_real 
var json_random

var more_sentences
var type_sentence
var still_reading = false

enum Sentences {
	RANDOM,
	REAL,
}

# 1) Set text to the correct text with set text
# 2) Reveal text with characterTimer on timeout
# 3) Check if has finished showing all characters
# 4) If it has, start disa_timer that will:
# 	4.1) Make the dialog box disappear if there is no more text
# 	4.2) Load another text if more text is supposed to appear

func _ready():
	read_from_file()
	label.visible_characters = 0
	chara_timer.stop()
	print (json_random)

func _process(_delta):
	checker()


func reading_sentence(sentence_number, json_type):
	chara_timer.start()
	still_reading = true
	textbox.visible = true
	label.visible = true
	type_sentence = json_type
	
	
	if json_type == Sentences.REAL:
		label.bbcode_text = json_real[sentence_number].sentence
		if json_real[sentence_number].next != "-1":
			more_sentences = int(json_real[sentence_number].next)
		else: 
			more_sentences = 0
	elif json_type == Sentences.RANDOM: 
		label.bbcode_text = json_random[sentence_number].sentence
		if json_random[sentence_number].next != "-1":
			more_sentences = int(json_random[sentence_number].next)
		else: 
			more_sentences = 0


func checker():
	if label.visible_characters == len(label.text):
		label.visible_characters += 1
		chara_timer.stop()
		disa_timer.start()


func read_from_file():
	var file = File.new()
	file.open("res://text.json", File.READ)
	var content = file.get_as_text()
	json_real = parse_json(content)
	file.close()
	file.open("res://text_random.json", File.READ)
	content = file.get_as_text()
	json_random = parse_json(content)
	file.close()

func _on_CharacterTimer_timeout():
	label.visible_characters += 1

func _on_DisappearTimer_timeout():
	print ("I triggered")
	if more_sentences:
		label.visible_characters = 0
		reading_sentence(more_sentences, type_sentence)
		chara_timer.start()
	else:
		textbox.visible = false
		label.visible_characters = 0
		label.visible = false
		still_reading = false
