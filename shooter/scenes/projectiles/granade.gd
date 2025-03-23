extends RigidBody2D

const speed: int = 750

func explode():
	$AnimationPlayer.play("Explosion")
