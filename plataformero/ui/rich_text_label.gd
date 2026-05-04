extends RichTextLabel

func _ready(): 
	pass
func meta_clicked(meta): 
	OS.shell_open(meta);
