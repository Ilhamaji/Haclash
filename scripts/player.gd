extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. Gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Input Arah menggunakan tombol A (Kiri) dan D (Kanan) secara langsung
	var direction := Input.get_axis("goLeft", "goRight")

	# 3. Logika Jump (Menggunakan Spasi atau W)
	if (Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_W)) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 4. Trigger Roll (Menggunakan tombol Ctrl yang sudah Anda daftarkan sebagai "roll")
	if Input.is_action_just_pressed("roll") and is_on_floor():
		animated_sprite.play("roll")
		# Jika sedang bergerak, beri dorongan kecepatan penuh saat guling
		if direction != 0:
			velocity.x = direction * SPEED

	# Cek status animasi Roll yang sedang berjalan
	var is_rolling := animated_sprite.animation == "roll" and animated_sprite.is_playing()

	# 5. Logika Gerak & Animasi Utama (Hanya berjalan jika TIDAK sedang berguling)
	if not is_rolling:
		if direction != 0:
			velocity.x = direction * SPEED
			animated_sprite.play("run")
			animated_sprite.flip_h = (direction < 0) # Otomatis flip ke kiri jika menekan A
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("idle")
			
	# 6. Eksekusi pergerakan fisik karakter
	move_and_slide()
