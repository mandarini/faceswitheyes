//Katerina Skroumpelou
//MRes ASAV, CASA

float a, b, hyp, centerX, centerY, eyer, pupild, cartX, cartY, x, y, faceX, faceY, lefteyeX, righteyeX, cartX2, cartY2, x2, y2, b2, hyp2;
boolean left, right;

//a, b, hyp are the triangle's sides (see further on)
//centerX, centerY are the coordinates of the eye's center
//eyer is the radius of the eye
//pupild is the diameter of the pupil
//cartX, cartY, cartX2, cartY2 are the cartesian coordinates of the pupil's center (see further on)
//faceX, faceY the coordiantes of each face's center point
//left and right are checking if the mouse is inside one of the eyes
//lefteyeX, righteyeX are the coordinates of the center of the left and right eye accordingly


void setup() {
  size(700, 200);
  noStroke();
}

void draw() {
  background(0);
  left=false;
  right=false;
  faceX=50;
  faceY=height/2;
  eyer=10;
  pupild=7;
  //drawing the faces with the eyes to the canvas
  while (faceX<width) 
  {
    face();
    eyes();
    pupils();
    faceX=faceX+100;
  }
}

//functions

//calculating the cartesian coordinates of the center of the pupil
//from the polar coordinates
void cartesian() {
  //calculating the triangle's sides and hypotenuse 
  //(the triangle between the center of the eye, the mouse position and the x-axis)
   a=mouseY-centerY;
   b=mouseX-lefteyeX;
   b2=mouseX-righteyeX;
   hyp=dist(mouseX, mouseY, lefteyeX, centerY);
   hyp2=dist(mouseX, mouseY, righteyeX, centerY);
   //cartesian coordinates (not dividing by 0)
   if (hyp!=0) 
   {
     cartX=eyer*(b/hyp);
     cartY=eyer*(a/hyp);
   }
   if (hyp2!=0) 
   {
     cartX2=eyer*(b2/hyp2);
     cartY2=eyer*(a/hyp2);
   }

}

//checking if the mouse is within the eye, because then I want the absolut position
void within() {
   if (hyp<eyer) 
   {
     cartX=mouseX;
     cartY=mouseY;
     left=true;
   }
   if (hyp2<eyer)
   {
     cartX2=mouseX;
     cartY2=mouseY;
     right=true;
   }
}

void face() {
  noStroke();
  fill(218, 167, 65);
  ellipse(faceX, faceY, 90, 120);
  fill(255, 130, 100);
  ellipse(faceX, faceY+30, 60, 10);
}

void eyes() {
  strokeWeight(5);
  stroke(255);
  centerX=faceX;
  centerY=faceY-20;
  lefteyeX=centerX-15;
  righteyeX=centerX+15;
  fill(255);
  ellipse(lefteyeX, centerY, eyer*2, eyer*2);
  ellipse(righteyeX, centerY, eyer*2, eyer*2);
}

void pupils() {
  noStroke();
  fill(0);
  cartesian();
  within();
  //if the mouse is within the eye, draw the eye again and the pupil at the mouse position
  if (left==true) 
  {
    fill(255);
    ellipse(lefteyeX, centerY, eyer*2, eyer*2);
    fill(0);
    noStroke();
    ellipse(cartX, cartY, pupild, pupild);
  }
  else {
  if (right==true) 
  {
    fill(255);
    ellipse(righteyeX, centerY, eyer*2, eyer*2);
    fill(0);
    noStroke();
    ellipse(cartX2, cartY2, pupild, pupild);
  }
 }
  //setting the new zero point, so that the polar/cartesian coordinates work
  pushMatrix();
    translate(lefteyeX, centerY);
    ellipse(cartX, cartY, pupild, pupild); 
  popMatrix();
  pushMatrix();
     translate(righteyeX, centerY);
     ellipse(cartX2, cartY2, pupild, pupild); 
  popMatrix();
}
