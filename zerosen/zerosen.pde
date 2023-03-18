//https://harilab.com/programing/game/mario1/

PImage s01, c1_main, 
       c1_r1, c1_r2, c1_r3, c1_r4, 
       c1_l1, c1_l2, c1_l3, c1_l4;

int floorHeight, stagex, stagewid;
int x, y, g, posi, jump;
float vx, vy, ax;

void setup() {
  noStroke();
  size(800, 370);
  background(255);
  s01   = loadImage("s01.PNG");
  s01.resize(3700, 370);
  c1_main = loadImage("c1_main.PNG");
  c1_main.resize(100, 100);
  c1_r1   = loadImage("c1_r1.PNG");
  c1_r1.resize(100, 100);
  c1_r2   = loadImage("c1_r2.PNG");
  c1_r2.resize(100, 100);
  c1_r3   = loadImage("c1_r3.PNG");
  c1_r3.resize(100, 100);
  c1_r4   = loadImage("c1_r4.PNG");
  c1_r4.resize(100, 100);
  c1_l1   = loadImage("c1_l1.PNG");
  c1_l1.resize(100, 100);
  c1_l2   = loadImage("c1_l2.PNG");
  c1_l2.resize(100, 100);
  c1_l3   = loadImage("c1_l3.PNG");
  c1_l3.resize(100, 100);
  c1_l4   = loadImage("c1_l4.PNG");
  c1_l4.resize(100, 100);
  
  //floor
  floorHeight = 231;
  
  x = 0;  //x position
  y = floorHeight;  //y position
  vx = 0;  //x velocity
  vy = 0;  //y velocity
  ax = 0;  //y accel
  g = 1;  //gravity
  posi = 1;  //left or right
  jump = 18;  //jump power ratio
  
  stagex = 0;  //stage position
  stagewid = width * 3;  //stage width
}

void draw() {
  //move horizontal
  vx += ax;
  //accel limit 3
  if((key==CODED)&&(keyCode=='B')){  //B dash
    if(5<vx){
      vx = 5;
    }
    if(vx < -5){
      vx = -5;
    }
  }else{
    if(1.1<vx){
      vx = 1.1;
    }
    if(vx < -1.1){
      vx = -1.1;
    }
  }
  
  //deceleration
  if(0<vx){
    vx = vx + 0.1;
  }
  if(vx<0){
    vx = vx + 0.1;
  }
  
  if(!keyPressed){
    ax = 0;
    if(abs(vx)<1){
      vx = 0;
    }
  }
  
  //move backgroung
  if(stagex<=0){
    x += vx;
    if(width/2<x){  //center
      stagex += x-width/2;
      x=width/2;
    }
    if(x<0){
      x = 0;
    }
  }else if(stagewid<=stagex){
    if(x<width/2){
      stagex -= width/2-x;
      x=width/2;
    }
  }else{
    stagex += vx;
    if(stagex<0){
      x += stagex;
      stagex = 0;
    }
    if(stagewid<stagex){
      x += stagex-stagewid;
      stagex = stagewid;
    }
  }
  drawBackground(stagex);
  
  //move virtical
  vy += g;
  y += vy;
  if(floorHeight<y){  //floor limit
    y = floorHeight;
  }
  
  //draw character
  if(y < floorHeight){
    if(posi!=0){  //right
      if(((stagex+x)/5%2==0)){
        image(c1_r3, x, y+1);
      }else{
        image(c1_r4, x, y);
      }
      }
      else{  //left
      if(((stagex+x)/5%2==0)){
        image(c1_l3, x, y+1);
      }else{
        image(c1_l4, x, y);
      }
    }
  }else{
    if(posi!=0){  //right
      if(((stagex+x)/5%2==0)){
        image(c1_r1, x, y+1);
      }else{
        image(c1_r2, x, y);
      }
      }
    else{  //left
      if(((stagex+x)/5%2==0)){
        image(c1_l1, x, y+1);
      }else{
        image(c1_l2, x, y);
      }
    }
  }
}

void keyPressed() {
  println(x, y, vx, vy, ax, stagex, stagewid);
  if (key == CODED) {
    if (keyCode == LEFT) {
      ax = -1;
      posi = 0;
    } else if (keyCode == RIGHT) {
      ax = 1;
      posi = 1;
    } else if (keyCode == UP) {
      if(y == floorHeight){
        vy = -1 * jump;
      }
    }
  }
}

void drawBackground(float background){
  image(s01, -background, 0);
}
