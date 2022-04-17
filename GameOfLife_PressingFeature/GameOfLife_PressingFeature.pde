
int size = 15;
int cols = 600/size;
int rows = 600/size;
int [][] board = new int[cols][rows];
int cellX = mouseX / size;
int cellY = mouseY / size;
boolean active = false;

void reset(){ 
  for(int y =0 ; y<rows ; y++){
    for (int x =0 ; x<cols ; x++){
      board[x][y] = int(random(2)); 
    }
  }
}

void refresh(){
  for(int y =0 ; y<rows ; y++){
    for (int x =0 ; x<cols ; x++){
      board[x][y] = 0; 
    }
  }
}

void setup(){
  size(600,600);
  frameRate(24);
}
void update(){
  int [][] next = new int[cols][rows];
  for(int y =1 ; y<rows-1 ; y++){
    for (int x =1 ; x<cols-1 ; x++){
      int neighbours = countNeighbours(x,y);
      next[x][y] = ruleOfLife(board[x][y], neighbours);
    }
  }
  board = next;
}

void draw() {
  for(int y =0 ; y<rows ; y++){
    for (int x =0 ; x<cols ; x++){
      if (board[x][y]==1)fill(192);    
      else
        fill(64);      
        rect(y*size,x*size,size,size);
    }
  }
  if(active)update();
  mousePressed();
}

void keyPressed(){
  if(key == ' ')active = !active;
  if(key == 'r')reset();
  if(key == 'q')refresh();
  if(key == 'a')board[mouseY/size][mouseX/size] = 0;
}

int countNeighbours(int x, int y){
  int neighbours= 0;
  for(int i =-1 ; i<=1 ; i++){
    for (int j =-1 ; j<=1 ; j++){
      neighbours += board[x+j][y+i];
    }
  }
  neighbours -= board[x][y];
  return(neighbours);
}

int ruleOfLife(int status,int neighbours) {
  if (status == 1 && neighbours > 3)return (0);
  else if(status == 1 && neighbours < 2)return (0);
  else if (status == 0 && neighbours == 3)return(1);
  else return (status);
}

void mousePressed(){
  if(mousePressed)board[mouseY/size][mouseX/size] = 1;
}
