extends Node2D

var level_one = preload("res://scene/level/level_one.tscn")
var titri = preload("res://scene/object/titri.tscn")
var main_menu = preload("res://scene/object/main_menu.tscn")
var menu = preload("res://scene/menu.tscn")
var temp = 0

func _ready():
	#print("запустилось")
	Events.connect("handle_click_storage", self, "handle_click_storage")
	Events.connect("use_cutscene", self, "play_cutscene")
	Events.connect("usecutscene", self, "play_cutscene")
	Events.connect("start_game", self, "start_game")
	Events.connect("back_menu", self, "back_menu")
	Events.connect("end_game", self, "end_game")
	Events.connect("end_game_1", self, "end_game_1")
	Events.connect("start_music", self, "start_music")
	Events.connect("stop_music", self, "stop_music")
	Events.connect("start_sound", self, "start_sound")
	Events.connect("stop_sound", self, "stop_sound")
	Events.connect("changed_music_value", self, "action_0")
	Events.connect("changed_sound_value", self, "action_1")
	Events.connect("drag_sound_start", self, "action_2")
	Events.connect("drag_sound_stop", self, "action_3")
	Events.connect("back_menu_0",self, "back_menu_0")
	Events.connect("walk_start", self, "walk_start")
	Events.connect("walk_stop", self, "walk_stop")
	Events.connect("walk_type", self, "walk_type")
	#Events.connect("open_menu", self, "action_4")
	#Events.connect("hide_menu", self, "action_5")
	Global.work_item = true
	
	$AudioStreamPlayer.volume_db = Global.last_volume_sound[0]
	$Sounds_player.volume_db = Global.last_volume_sound[1]
	$Sounds_player.volume_db = Global.last_volume_sound[1]
	pass # Replace with function body.

func walk_type(name):
	$walk_player.stream = load("res://assets/sounds/"+ name + ".wav")
	$walk_player.play()
	$walk_player.stream_paused = false
	pass

func walk_start():
	if temp == 0:
		$walk_player.play()
		$walk_player.stream_paused = false
		temp = 1
	pass
	
func walk_stop():
	$walk_player.stream_paused = true
	temp = 0
	pass


#func action_4():
#	add_child(menu.instance())
	#get_tree().paused = true
	#pass

#func action_5():
##	pass

func action_0(value):
	Global.save_volume(value)
	$AudioStreamPlayer.volume_db = value
	pass
	
func action_1(value):
	Global.save_volume(Global.last_volume_sound[0], value)
	$Sounds_player.volume_db = value
	$walk_player.volume_db = value
	pass
	
func action_2():
	$AudioStreamPlayer.stream_paused = true
	$Sounds_player.stream = load("res://assets/sounds/walk.wav")
	$Sounds_player.playing = true
	pass
	
func action_3():
	$AudioStreamPlayer.stream_paused = false
	$Sounds_player.stop()
	pass

func stop_sound():
	$Sounds_player.stop()
	pass
	
func start_sound(name, loop = false):
	$Sounds_player.stop()
	$Sounds_player.stream = load("res://assets/sounds/" + name +".ogg")
	$Sounds_player.play()
	pass

func stop_music():
	$AudioStreamPlayer.stop()
	pass
	
func start_music(name, loop = false):
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = load("res://assets/sounds/music_" + name +".ogg")
	$AudioStreamPlayer.play()
	pass

func start_game():
	stop_music()
	Inventory.items = []
	Inventory.limbs_heart = []
	Inventory.pain_mind[0] = 0
	Inventory.pain_mind[1] = 100
	$Node2D.queue_free()
	add_child(level_one.instance())
	#$level_one/AnimationPlayer.play("start")
	Global.work_item = true
	start_music("game")
	$level_one/AnimationPlayer.play("start")
	pass

func end_game():
	walk_stop()
	$level_one.queue_free()
	add_child(titri.instance())
	pass
	
func end_game_1():
	$Node2D.queue_free()
	add_child(titri.instance())
	pass
	
func back_menu():
	$titri.queue_free()
	start_music("menu")
	add_child(main_menu.instance())
	pass

func back_menu_0():
	$level_one.queue_free()
	start_music("menu")
	add_child(main_menu.instance())
	pass
	
func play_cutscene(name):
	$level_one/AnimationPlayer.play(name)
	pass

func handle_click_storage():
	Global.work_item = false
	$Timer.start()
	pass

func _on_Timer_timeout():
	Global.work_item = true
	pass # Replace with function body.
