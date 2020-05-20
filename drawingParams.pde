// Textures
PImage baLL;
PImage vkWhite;
PImage vkBlack;
// TODO: Racket texture

void loadImages() {
  // Textures
  baLL = loadImage("ball.png");
  vkWhite = loadImage ("vk.png");
  vkBlack = loadImage("vk-black.png");
}

// Fonts
PFont mainFont;

void loadFonts() {
  mainFont = createFont("1424.ttf", 32);
  textFont(mainFont);
}
