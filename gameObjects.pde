//ball //<>//
final int BALL_SIZE = 35;
final int HALF_BALL_SIZE = BALL_SIZE / 2;

int ballX;
int ballY;
int ballDx = 7;
int ballDy = 7;

//paddle

final int PADDLE_WIDTH = 10;
final int PADDLE_HEIGHT = 120;
final int PADDLE_HALF_WIDTH = PADDLE_WIDTH / 2;
final int PADDLE_HALF_HEIGHT = PADDLE_HEIGHT / 2;

int leftPaddleX;
int leftPaddleY;
int leftPaddleDy = 7;

int rightPaddleX;
int rightPaddleY;
int rightPaddleDy = 7;

//score

final int SCORE_SIZE = 100;
final int MARGIN_TOP = 50;
final int MARGIN_SIDE = 615;

int score1 = 0;
int score2 = 0;

void drawgameObjects() {
  noStroke();
  image(baLL, ballX, ballY, BALL_SIZE, BALL_SIZE);

  ballX += ballDx;
  ballY += ballDy;

  if (ballX - HALF_BALL_SIZE >= width) {
    score1++;
    ballX = width / 2;
    ballY = height / 2;
    ballDx += 1;
  }
  if (ballX + HALF_BALL_SIZE < 0) {
    score2++;
    ballX = width / 2;
    ballY = height / 2;
    ballDx *= -1;
  }
  if (ballY + HALF_BALL_SIZE >= height || ballY - HALF_BALL_SIZE < 0) {
    ballDy *= -1;
  }

  rect(leftPaddleX, leftPaddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
  rect(rightPaddleX, rightPaddleY, PADDLE_WIDTH, PADDLE_HEIGHT);
  rect(680, 720, 5, 1500);

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
  } 
  if  (keyPressed) {
    if (key == 'W' ) {
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

  // Collision Detection

  if (abs(ballX - leftPaddleX) < HALF_BALL_SIZE + PADDLE_HALF_WIDTH &&
    abs(ballY - leftPaddleY) < HALF_BALL_SIZE + PADDLE_HALF_HEIGHT || 
    abs(ballX - rightPaddleX) < HALF_BALL_SIZE + PADDLE_HALF_WIDTH &&
    abs(ballY - rightPaddleY) < HALF_BALL_SIZE + PADDLE_HALF_HEIGHT) {
    ballDx *= -1;
    pongBall.play();
    pongBall.rewind();
  }
}

// Score
void drawPlayerScore() {
  textSize(SCORE_SIZE);
  textAlign(CENTER, CENTER);
  text(score1, MARGIN_SIDE, MARGIN_TOP);
  text(score2, width - MARGIN_SIDE, MARGIN_TOP);

  if (score1 == 15) {
    state = VICTORY_STATE_P1;
  } else if (score2 == 15) {
    state = VICTORY_STATE_P2;
  }
}
