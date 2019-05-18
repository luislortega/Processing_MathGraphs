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
  for(int i = 0; i < 3; i++){
    drawPoint(graph_points[i][0], graph_points[i][1]);
  }
}

void drawPoint(int x,int y){
  stroke(0);
  strokeWeight(20);  // Beastly
  point(x, y);
}