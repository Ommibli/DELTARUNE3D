extends KinematicBody
 
const MOVE_SPEED = 12
const SUPER_SPEED = 20
const JUMP_FORCE = 30
const GRAVITY = 2
const MAX_FALL_SPEED = 30
 
var H_LOOK_SENS = 0.20
var V_LOOK_SENS = 0.20
 
const J_LOOK_SENS = 0.05

onready var cam = $camerabase

var pivot
var SPEED
var y_velo = 0

signal boofzone
signal talkedboof


func _ready():
	pivot = $camerabase
	$AnimationPlayer.play("fadein")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -45, 75)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS


func _physics_process(delta):
	var move_vec = Vector3()
	
	if Input.is_action_just_pressed("camswitch"):
		if $kris.visible == true:
			$kris.visible = false
		elif $kris.visible == false:
			$kris.visible = true
		
		if $camerabase/camera.is_current():
			$camerabase/camera.clear_current(true)
		elif $camerabase/camerafps.is_current():
			$camerabase/camerafps.clear_current(true)
	

	
	
	if Input.is_action_pressed("run"):
		SPEED = SUPER_SPEED
	else:
		SPEED = MOVE_SPEED
	
	
	if Input.is_action_pressed("up"):
		move_vec.z -= 1
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
	if Input.is_action_pressed("down"):
		move_vec.z += 1
	if Input.is_action_pressed("right"):
		move_vec.x += 1

	if Input.is_action_just_released("up"):
		$kris.play("idleup")
	if Input.is_action_just_released("left"):
		$kris.play("idleleft")
	if Input.is_action_just_released("down"):
		$kris.play("idledown")
	if Input.is_action_just_released("right"):
		$kris.play("idleright")

	if Input.is_action_pressed("up"):
		if Input.is_action_just_pressed("run"):
			$kris.play("runup")
		else:
			$kris.play("walkup")
	elif Input.is_action_pressed("down"):
		if Input.is_action_just_pressed("run"):
			$kris.play("rundown")
		else:
			$kris.play("walkdown")
	elif Input.is_action_pressed("left"):
		if Input.is_action_just_pressed("run"):
			$kris.play("runleft")
		else:
			$kris.play("walkleft")
	elif Input.is_action_pressed("right"):
		if Input.is_action_just_pressed("run"):
			$kris.play("runright")
		else:
			$kris.play("walkright")


	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= SPEED
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
 
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	var just_jumped = false
	#if grounded and Input.is_action_just_pressed("jump"):
	#	just_jumped = true
	#	y_velo = JUMP_FORCE
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED



	rotate_y(Input.get_action_strength("camera_left") * J_LOOK_SENS)
	rotate_y(Input.get_action_strength("camera_right") * J_LOOK_SENS * -1)
	pivot.rotate_x(Input.get_action_strength("camera_up") * J_LOOK_SENS)
	pivot.rotate_x(Input.get_action_strength("camera_down") * J_LOOK_SENS * -1)
	pivot.rotation.x = clamp(pivot.rotation.x, -1.2, 1.2)

#	if move_vec.x != 0 and grounded:
#		if !$footstep1.playing:
#			$footstep1.play()
#		elif $footstep1.playing:
#			$footstep1.stop()






