//Para la ruta más corta se puede usar el archivo de Dijkstra.c (recomendación, ejecutar en Zinjai)que se encuentra al descomprimir el archivo

//Matriz de adyacencia de los vértices
//En caso de agregar otro vértice, ingresar sus adyacente, donde 1=verdadero, 0=falso
int[][] graph_connections = {{0,1,0,1,0,0,1,},
                             {1,0,1,0,0,0,1,},
                             {0,1,0,1,0,1,1,},
                             {0,0,1,0,1,0,1,},
                             {0,0,0,1,0,1,1,},
                             {0,0,1,0,1,0,1,},
                             {1,1,1,1,1,1,0,}};   

//En caso de agregar otro vértices, ingresar sus coordenadas
//Matriz que representa las coordenadas del grafo
int[][] graph_points = {{320,190}, 
                        {500,100},
                        {700,150}, 
                        {800,240}, 
                        {900,260}, 
                        {1000,100}};
//Matrisz de los pesos de las aristas, infinito=999, o sea, no existe una ruta directa a ese punto
//En caso de agregar otro vértice, ingresar sus respectivos pesos
int [][] edge_weight = {{0,2,999,10,999,999},
                        {2,0,5,999,999,999},
                        {999,5,0,1,999,4},
                        {10,999,1,0,1,999},
                        {999,999,999,1,0,1},
                        {999,999,4,999,1,0}};
//Nombre de los vértices       
//En caso de agregar otro vértice tiene que agregarle un nombre
String[] graph_name = {"Escarcega", "Merida", "Valladolid", "Tulum", "Playa del carmen", "Cancun"};

//Encaso de agregar otro vértice, incrementarle la cantidad
int vertices=6;

void setup() {
  size(1250, 700); 
  background(150); 
  textSize(32);
  fill(0, 102, 153);
  text("Problema No. 1 \n de manera estatica \n mostramos el algoritmo", 10, 500);
}

void draw(){
  //DrawLines
  for(int i = 0; i < vertices; i++){
    for(int j = 0; j<vertices; j++){
      stroke(0);
      strokeWeight(5);  // Beastly
      //Verifica que el vértice con el valor i, sea conexo con el vértice que tiene el valor de j
      if(graph_connections[i][j]==1){
      line(graph_points[i][0],graph_points[i][1], graph_points[j][0], graph_points[j][1]);
      textSize(25);
      fill(0, 102, 153);
      stroke(255);
      strokeWeight(20);
      text(edge_weight[i][j], (graph_points[i][0]+graph_points[j][0])/2, (graph_points[i][1]+graph_points[j][1])/2);
    }
  }
 }
   //DrawPoints
  for(int i = 0; i < vertices; i++){
    drawPoint(graph_points[i][0], graph_points[i][1], graph_name[i]);
  }
}

void drawPoint(int x, int y, String name){   
  textSize(15);
  fill(0, 102, 153);
  text(name, x, y-30);
  stroke(255);
  strokeWeight(20);  // Beastly
  point(x, y);
}
