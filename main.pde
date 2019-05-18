/*
* @author: Luis Leon | Noe Bautista | Fernanda Madera
* Un poco de contexto....
*
* graph_conections su primera dimension representa de donde sale la arista
* su segunda dimension representa el endpoint.
*
* graph_point representa la cordenada donde se encuentran los vertices.
*/
int[][] graph_connections = {{1,2,3},
                             {2,0,2}};
                             
int[][] graph_points = {{399,20}, {500,200}, {100,300}};

void setup() {
  size(1250, 575); 
  background(255);  
}

void draw(){
  //DrawPoints
  for(int i = 0; i < 3; i++){
    drawPoint(graph_points[i][0], graph_points[i][1]);
  }
  //DrawLines
  for(int i = 0; i < 3; i++){
    drawLine(graph_connections[0][i], graph_connections[1][i]);
  } 
}

void drawPoint(int x,int y){
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