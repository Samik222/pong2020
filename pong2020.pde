// State //<>//
final int MENU_STATE        = 0; 
final int GAME_STATE        = 1;
final int VICTORY_STATE_P1  = 2;
final int VICTORY_STATE_P2  = 3;

// Animation in menu "Star".
final int LINE_COUNT = 10;
float initalAngle = -0.28;

// Button "PLAY" in menu.
int rectX, rectY;
color rectColor;
color rectHighlight;
boolean rectOver = false;
int rectSize1 = 200;
int rectSize2 = 50;

int state = MENU_STATE;
boolean overButton = false;

void setup() {
  fullScreen();  
  background(0);
  noStroke();
  rectMode(CENTER);

  rectColor = color(0);
  rectHighlight = color(51);
  rectX = width/2;
  rectY = height/2;
  ellipseMode(CENTER);

  loadImages();
  loadFonts();
  loadSounds();

  ballX = width / 2;
  ballY = height / 2;

  leftPaddleX = PADDLE_HALF_WIDTH;
  rightPaddleX = width - PADDLE_HALF_WIDTH;
  leftPaddleY = rightPaddleY = height / 2;
}

void draw() { 
  background(0);

  switch (state) {
  case MENU_STATE:
    drawMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case VICTORY_STATE_P1:
    drawVictoryP1();
    break;
  case VICTORY_STATE_P2:
    drawVictoryP2();
    break;
  }
}

void drawMenu() {
  if (overButton == true) {
    image(vkBlack, 0, 700, 75, 75);
  } else {
    image(vkWhite, 0, 700, 75, 75);
  }

  noStroke();
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);

  stroke(255, 0, 0);
  strokeWeight(4);
  float x = width / 2;
  float y = height / 2;
  float angle = initalAngle;
  float angleDelta = TWO_PI / LINE_COUNT;
  float radius1 = 150;
  float radius2 = 600;

  for (int i = 0; i < LINE_COUNT; i++) {
    float radius = i % 2 == 0 ? radius1 :radius2;
    float nextRadius = i % 2 != 0 ? radius1 :radius2;
    float endX = x + cos(angle) * radius;
    float endY = y + sin(angle) * radius;
    line(x, y, endX, endY);
    float nextEndX = x + cos(angle + angleDelta) * nextRadius;
    float nextEndY = y + sin(angle + angleDelta) * nextRadius;
    line(endX, endY, nextEndX, nextEndY);

    angle += angleDelta;
  }
  initalAngle += 0.01;

  update(mouseX, mouseY);

  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize1, rectSize2);

  noStroke();


  fill(0, 0, 255);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("Pong 2020", width / 2, height / 2 - 100);

  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("PLAY", width / 2, height / 2);

  fill(0, 255, 0);
  textSize(50);
  text("Press 'Enter', to play the game.", width / 2, height / 2 + 120);

  textSize(30);
  text("Stay Home! :)", width / 2, height / 2 + 160);
  textSize(15);
  fill(100, 100, 100);
  text("P.S, if left racket does not move, then try changing the layout to Elnglish.", width / 2, height / 2 + 200);
  text("Management:Left racket(W-UP, S-DOWN), Right racket(RgUp, RgDn)", width / 2, height / 2 + 230);
}

void update(int x, int y) {
  if ( overRect(width / 2 - 100, height / 2 - 30, 200, 50) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (overButton) { 
    link("https://vk.com/sam177aby");
  }
  if (rectOver) {
    state = GAME_STATE;
  }
}

void mouseMoved() { 
  checkButtons();
}

void mouseDragged() {
  checkButtons();
}

void checkButtons() {
  if (mouseX > 0 && mouseX < 50 && mouseY > 690 && mouseY < 900) {
    overButton = true;
  } else {
    overButton = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawGame() {
  fill(255, 255, 255);
  drawgameObjects();
  drawPlayerScore();
}

float angle = 0;
void drawVictoryP1() {
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle += 0.00004;
    translate( i * 10, 0);
    fill(255 * 10 / 100);
    rect(0, 100, 100, 100);
  }
  popMatrix();

  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Player 1, to win the game! ", width / 2, height / 2 + 170);

  textSize(70);
  fill(255);
  text("His score-> " + score1, width / 2, height / 2 + 270);

  textSize(50);
  text("Press 'Enter', to go in menu.", width / 2, height / 2 + 330);
}

void drawVictoryP2() {
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle -= 0.00004;
    translate( i * 10, 0);
    fill(255 * 10 / 100);
    circle(0, 100, 100);
  }
  popMatrix();

  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Player 2, to win the game! ", width / 2, height / 2 + 170);

  textSize(70);
  fill(255);
  text("His score-> " + score2, width / 2, height / 2 + 270);

  textSize(50);
  text("Press 'Enter', to go in menu.", width / 2, height / 2 + 330);
}

void keyPressed() {
  switch (state) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case VICTORY_STATE_P1:
    keyPressedInVictoryP1();
    break;
  case VICTORY_STATE_P2:
    keyPressedInVictoryP2();
    break;
  }
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    score1 = 0;
    score2 = 0;
    state = GAME_STATE;
  }
}

void keyPressedInGame() {
  if (keyPressed) {
    if (keyCode == UP ) {
      rightPaddleY -= rightPaddleDy;
      if (rightPaddleY - PADDLE_HALF_HEIGHT < 0) {
        rightPaddleY = PADDLE_HALF_HEIGHT;
      }
    } else if (keyCode == DOWN) {
      rightPaddleY += rightPaddleDy;
      if (rightPaddleY + PADDLE_HALF_HEIGHT > height) {
        rightPaddleY = height - PADDLE_HALF_HEIGHT;
      }
    }
  } else if  (keyPressed) {
    if (key == 'W') {
      leftPaddleY -= leftPaddleDy;
      if (leftPaddleY - PADDLE_HALF_HEIGHT < 0) {
        leftPaddleY = PADDLE_HALF_HEIGHT;
      }
    } else if (key == 'S') {
      leftPaddleY += leftPaddleDy;
      if (leftPaddleY + PADDLE_HALF_HEIGHT > height) {
        leftPaddleY = height - PADDLE_HALF_HEIGHT;
      }
    }
  }  
  if  (keyPressed) {
    if (key == 'w') {
      leftPaddleY -= leftPaddleDy;
      if (leftPaddleY - PADDLE_HALF_HEIGHT < 0) {
        leftPaddleY = PADDLE_HALF_HEIGHT;
      }
    } else if (key == 's') {
      leftPaddleY += leftPaddleDy;  
      if (leftPaddleY + PADDLE_HALF_HEIGHT > height) {
        leftPaddleY = height - PADDLE_HALF_HEIGHT;
      }
    }
  }
}

void keyPressedInVictoryP1() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}

void keyPressedInVictoryP2() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}
