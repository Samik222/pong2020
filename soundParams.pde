import ddf.minim.*;

Minim minim;
AudioPlayer pongBall;

void loadSounds() {
  minim = new Minim(this);
  pongBall = minim.loadFile("pongBall.mp3");
}
