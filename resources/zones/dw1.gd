extends Spatial


func _ready():
	$"Viewport/mony to buy a undertale".visible = false



func _on_Area_area_entered(area):
	$"Viewport/mony to buy a undertale".visible = true
	$cliffs.stop()
	$"Viewport/mony to buy a undertale/VideoPlayer".play()


func _on_Area_area_exited(area):
	$"Viewport/mony to buy a undertale".visible = false
	$cliffs.play()
	$"Viewport/mony to buy a undertale/VideoPlayer".stop()
