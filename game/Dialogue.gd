extends CanvasLayer

onready var label = $RichTextLabel
var json 

func _ready():
	var file = File.new()
	file.open("res://text.json", File.READ)
	var content = file.get_as_text()
	file.close()
	
	json = parse_json(content)
	
	reading_sentence(0)
	
#	for line in stuff:
#		if line.ID == "1":
#			print (line)
#			if line.Next != "-1":
#				print (stuff[int(line.Next)])
#			else:
#				 print ("no next line")

func reading_sentence(sentence_number):
	var temp = sentence_number
	print (json[temp].sentence)
	while json[temp].next != "-1":
		temp = int(json[temp].next)
		print (json[temp].sentence)
