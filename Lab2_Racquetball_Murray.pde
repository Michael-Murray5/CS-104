int Begin=0;    //Difficulty
int Speed=5;    //Ball Speed
int Width;      //Paddle Width 
int Count=0;    //Makes sure you can't change difficulty mid game
int Count2=0;   //Makes sure you can't restart mid game
int BallX=int(random(0, 1000));  //Randomize the Ball's starting X position
int BallY=int(random(0, 350));   //Randomize the Ball's starting Y postion
int Score=0;    //Track the score
int SignX=int(random(-2, 2));    //Ranomize starting direction in X
int SignY=int(random(-2, 2));    //Randomize starting direction in Y
int Crazy=0;    //Activates Crazy mode when this isn't 0
int mx=mouseX;  //Mouse position
int paddleY=650;  //Paddle Y height
int diameter=25;  //Ball Diameter
int paddleL=25; //Paddle Length


void setup() {
  size(1000, 700);
}


void draw() {
  //Start and Restart the Game
  if (Begin==0) {
    background(0);
    textSize(60);
    text("Welcome to Pong",260,85);
    textSize(20);
    text("To begin first select a difficulty below. Easy will have the largest paddle but also the highest speed. Hard will have a",10,125);
    text("small paddle but a slow starting speed. Then medium as the name implies will be between easy and hard in speed and ",10,150);
    text("paddle size. The game will begin as soon as you select a difficulty and the objective is to score as many points as ",10,175);
    text("possible. Your score will increase whenever you successfully bounce the ball off the paddle. However if you fail to hit ",10,200);
    text("the ball then you will lose. All hope is not lose however since you can still restart on the same diffuculty or a new one",10,225);
    text("As a little suprise try clicking the mouse after you have scored one point.",10,250);
    textSize(50);
    text("Choose Your Difficulty", 250, 350);
    textSize(30);
    text("Easy", 450, 425);
    text("Medium", 430, 500);
    text("Hard", 450, 575);
  }
  //Select Easy Mode
  if (mousePressed && mouseX>=425 && mouseX<=525 && mouseY>=400 && mouseY<=450 && Begin==0) {
    Begin=1;
  }
  //Select Medium Mode
  if (mousePressed && mouseX>=425 && mouseX<=525 && mouseY>=475 && mouseY<=525 && Begin==0) {
    Begin=2;
  }
  //Select Hard Mode
  if (mousePressed && mouseX>=425 && mouseX<=525 && mouseY>=550 && mouseY<=600 && Begin==0) {
    Begin=3;
  }

  //Set Conditions for Easy Mode
  if (Begin==1 && Count==0) {
    Width=300;
    Speed=7;
    Count=Count+1;               //Makes sure you can't change difficultly in the middle of the game
    BallY=int(random(0, 300));   //Randomizes ball location if difficulty is changed after losing
  }
  //Set Conditions for Medium Mode
  if (Begin==2 && Count==0) {
    Width=200;
    Speed=5;
    Count=Count+1;
    BallY=int(random(0, 300));
  }
  //Set Conditions for Hard Mode
  if (Begin==3 && Count==0) {
    Width=100;
    Speed=4;
    Count=Count+1;
    BallY=int(random(0, 300));
  }
  
  if (Begin>=1) {                  //This if statement occurs for all difficulties
    //Randomize Ball Color for any difficulty
    int Red=int(random(0, 255));
    int Green=int(random(0, 255));
    int Blue=int(random(0, 255));
    if (SignX==0) {                //Make sure the ball does not have 0 speed
      SignX=int(random(-2, 2));
    }
    if (SignY==0) {
      SignY=int(random(-2, 2));
    }
    //Setup New Screen and Crazy Mode
    if (mousePressed && Score>0) {
      Crazy=100;
    }
    if (Crazy==0) {
      background(100);
    } else {
      Crazy=Crazy-10;
    }
    //Create and fill the ball
    fill(Red, Green, Blue);
    circle(BallX, BallY, diameter);
    //Create, Restrain, and Fill the Paddle
    fill(155);
    mx=constrain(mouseX, Width/2, 1000-Width/2);
    rectMode(CENTER);
    rect(mx, paddleY, Width, paddleL);
    //Display Score
    textSize(50);
    text(Score, 950, 50);
    //Ball Movement
    BallX=BallX+Speed*SignX;
    BallY=BallY+Speed*SignY;
    //Right and Left Edge Bounce
    if (BallX>=width || BallX<=0) {
      SignX=-1*SignX;
    }
    //Top Edge Bounce
    if (BallY<=0) {
      SignY=-1*SignY;
    }
    //Paddle Bounce
    if (BallX>=mx-Width/2 && BallX<=mx+Width/2 && BallY>=paddleY-diameter/2-paddleL/2 && BallY<=paddleY+paddleL/2) {
      Speed=Speed+1;
      SignY=-1*SignY;
      Score=Score+1;
    }
    //Side Paddle Bounce
    if (BallX==mx-Width/2 && BallY>=650 && BallY<=675) {
      SignX=-SignX;
      SignY=-SignY;
      Speed=Speed+1;
      Score=Score+1;
    }
    if (BallX==mx+Width/2 && BallY>=650 && BallY<=675) {
      SignX=-SignX;
      SignY=-SignY;
      Speed=Speed+1;
      Score=Score+1;
    }
    //Capping the speed
    if (Speed>=35) {
      Speed=35;
    }
    //Game Over Condition
    if (BallY>=height) {
      background(0);
      textSize(100);
      text("Game Over", 300, 350);
      textSize(50);
      text("Press Any Key To Restart", 280, 450);
      textSize(35);
      // Return to home Screen
      text("Click Here to Change Difficulty", 300, 550);
      if (mousePressed && mouseX>=200 && mouseX<=700 && mouseY>=520 && mouseY<=600) {
        Begin=0;   // Returns to home screen
        Count=0;   //Allows you to actually change difficulty
        Score=0;   // Resets the score
      }
      Count2=1; //Make sure pressing a key in game won't reset the ball
    }
    // Restart the game on the same condition
    if (keyPressed && Count2>0) {
      background(100);
      fill(Red, Green, Blue);
      circle(BallX, BallY, 25);
      fill(155);
      rect(mouseX, 650, Width, 25);
      BallY=int(random(0,350));
      Score=0;        //Resets score
      Count=Count-1;  //Lets difficulty settings reset
      Count2=0;       //Makes sure pressing a key while playing won't reset
    }
  }
}
