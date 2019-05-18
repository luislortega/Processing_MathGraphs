/*
* @author: Luis Leon | Noe Bautista | Fernanda Madera
* Un poco de contexto....
*
* graph_conections su primera dimension representa de donde sale la arista
* su segunda dimension representa el endpoint, la tercera dimension representa el endpoint no. 2.
*
* graph_point representa la cordenada donde se encuentran los vertices.
*/
int[][] graph_connections = {{1,2,3,4,5,6},
                             {0,1,2,3,4,5},
                             {0,0,0,1,0,3}};
                             
int[][] graph_points = {{320,190}, {500,100},{700,150}, {800,240}, {900,260}, {1000,100}};

void setup() {
  size(1250, 700); 
  background(255); 
  textSize(32);
  fill(0, 102, 153);
  text("Problema No. 1", 10, 60);
}

void draw(){
  //DrawPoints
  for(int i = 0; i < graph_points.length; i++){
    drawPoint(graph_points[i][0], graph_points[i][1]);
  }
  //DrawLines
  for(int i = 0; i < 6; i++){
    drawLine(graph_connections[0][i], graph_connections[1][i]);
    drawLine(graph_connections[0][i], graph_connections[2][i]);
  } 
}

void drawPoint(int x, int y){
  textSize(15);
  fill(0, 102, 153);
  text("Name", x, y-30);
  stroke(0);
  strokeWeight(20);  // Beastly
  point(x, y);
}

void drawLine(int origin, int endpoint){
  stroke(0);
  strokeWeight(5);  // Beastly
  if(endpoint != 0){
    line(graph_points[origin-1][0],graph_points[origin-1][1], graph_points[endpoint-1][0], graph_points[endpoint-1][1]);
  }
}