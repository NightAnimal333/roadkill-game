extends CanvasLayer

onready var label = $TextureRect/RichTextLabel
onready var textbox = $TextureRect
onready var chara_timer = $TextureRect/RichTextLabel/CharacterTimer
onready var disa_timer = $TextureRect/RichTextLabel/DisappearTimer
var json 

var more_sentences

var debug 



# 1) Set text to the correct text with set text
# 2) Reveal text with characterTimer on timeout
# 3) Check if has finished showing all characters
# 4) If it has, start disa_timer that will:
# 	4.1) Make the dialog box disappear if there is no more text
# 	4.2) Load another text if more text is supposed to appear

func _ready():
	read_from_file()
	
	debug = reading_sentence(0)

func _process(_delta):
	
	checker()


func reading_sentence(sentence_number):
	label.bbcode_text = json[sentence_number].sentence
	if json[sentence_number].next != "-1":
		more_sentences = int(json[sentence_number].next)
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
	file.close()
	json = parse_json(content)


func _on_CharacterTimer_timeout():
	label.visible_characters += 1

func _on_DisappearTimer_timeout():
	print ("I triggered")
	if more_sentences:
		label.visible_characters = 0
		reading_sentence(more_sentences)
		chara_timer.start()
	else:
		textbox.visible = false
		label.visible_characters = 0
		label.visible = false
