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

String[] graph_name = {"Escarcega", "Merida", "Valladolid", "Tulum", "Playa del carmen", "Cancun"};

int[][] dijkstra_inf = {{2,1,5},{3,2,4},{4,3,3},{5,4,2},{6,5,1},{0,6,0}};

void setup() {
  size(1250, 700); 
  background(150); 
  textSize(32);
  fill(0, 102, 153);
  text("Problema No. 1 \n de manera estatica \n mostramos el algoritmo", 10, 500);
}

void draw(){
  for(int i = 0; i < 6; i++){
    drawLine(graph_connections[0][i], graph_connections[1][i]);
    drawLine(graph_connections[0][i], graph_connections[2][i]);
  } 
  for(int i = 0; i < graph_points.length; i++){
    drawPoint(graph_points[i][0], graph_points[i][1], graph_name[i]);
  }
  for(int i = 0; i < dijkstra_inf.length; i++){
    drawLine_route(dijkstra_inf[i][1], dijkstra_inf[i][0]);
  } 
}

void drawPoint(int x, int y, String name){   
  textSize(15);
  fill(0, 102, 153);
  text(name, x, y-30);
  stroke(255);
  strokeWeight(20);
  point(x, y);
}

void drawLine(int origin, int endpoint){
  stroke(0);
  strokeWeight(5);
  if(endpoint != 0){
    line(graph_points[origin-1][0],graph_points[origin-1][1], graph_points[endpoint-1][0], graph_points[endpoint-1][1]);
  }
}

void drawLine_route(int origin, int endpoint){
  stroke(0, 255, 0);
  strokeWeight(5); 
  if(endpoint != 0){
    line(graph_points[origin-1][0],graph_points[origin-1][1], graph_points[endpoint-1][0], graph_points[endpoint-1][1]);
  }
}