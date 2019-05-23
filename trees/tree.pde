//n la Linea 32,33,34 se deben ingresar los valores. En la parte de abajo en el ejecutable, se enumeran los nodos, te serviran para poner el nodo inicial y final
//Matriz de adyacencia de los vértices. También nos va a servir como la matriz de pesos
int[][] graph_connections = {{0,1,1,0,0,0,0,0,0,0,0},
                             {1,0,0,1,1,0,0,0,0,0,0},
                             {1,0,0,0,0,1,0,0,0,0,0},
                             {0,1,0,0,0,0,1,0,0,0,0},
                             {0,1,0,0,0,0,0,1,1,0,0},
                             {0,0,1,0,0,0,0,0,0,1,1},
                             {0,0,0,1,0,0,0,0,0,0,0},
                             {0,0,0,0,1,0,0,0,0,0,0},
                             {0,0,0,0,1,0,0,0,0,0,0},
                             {0,0,0,0,0,1,0,0,0,0,0},
                             {0,0,0,0,0,1,0,0,0,0,0}};   
//Matriz que representa las coordenadas del grafo
int[][] graph_points = {{575,110},
                        {475,175},
                        {675,175},
                        {380,275},
                        {570,275},
                        {770,275},
                        {350,375},
                        {540,375},
                        {620,375},
                        {740,375},
                        {800,375}};
//Nombre de los vértices       
//En caso de agregar otro vértice tiene que agregarle un nombre
String[] graph_name = {"Bisabuelo", "hijo 1", "hijo 2", "hijo 1.1", "hijo 1.2", "hijo 2.1", "hijo 1.1.1(Tú)", "hijo 1.2.1", "hijo 1.2.2",
"hijo 2.1.1", "hijo 2.1.2"};
int ruta[]=new int[20];
//Ingresar la cantidad de vertices exactos que hay en el árbol
int valor2=1;
int vertices=11; //Numero de nodos
int startnode=0; //Nodo inicial
int finalnode=6; //Nodo al que queremos llegar
int leaves=0, vali=0, valor3=1;

void setup() {
  size(1250, 700); 
  background(150); 
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
    }
  }
 }
   //DrawPoints
  for(int i = 0; i < vertices; i++){
    drawPoint(graph_points[i][0], graph_points[i][1], graph_name[i]);
  }
  //Dijkstra
  if(valor2==1){
    for(int i=0; i<vertices; i++){
    print(i,":",graph_name[i],"\n");
    }
   dijkstra(graph_connections, graph_name, vertices,startnode,finalnode, ruta);
   valor2=0;
  }
  //Hojas
  if(valor3==1){
    for(int p=0; p<vertices; p++){
      vali=0;
      for(int q=0; q<vertices; q++){
        if(graph_connections[p][q]==1){
          vali=vali+1;
        }
        }
        if(vali==1){
        leaves=leaves+1;
        }
    }
    print("\n\nHojas del árbol= ",leaves, "\nNodos= ",vertices, "\nVértices internos= ", vertices-leaves);
    valor3=0;
    }
}

void drawPoint(int x, int y, String name){   
  textSize(10);
  fill(0, 102, 153);
  text(name, x, y-30);
  text("Preorden: Bisabuelo ,hijo1 ,hijo1.1 ,hijo1.1.1 ,hijo1.2 ,\n                hijo1.2.1, hijo1.2.2, hijo2, hijo2.1, hijo2.1.1, hijo2.1.2", 900, 85);
  text("Inorden: hijo1.1.1, hijo1.1, hijo1, hijo 1.2.1, hijo 1.2,\n              hijo1.2.2, Bisabuelo, hijo2, hijo2.1.1, hijo2.1, hijo2.1.2", 900, 125);
  text("Postorden: hijo1.1.1, hijo1.1, hijo1.2.1, hijo1.2.2, hijo1.2,\n              hijo1, hijo2.1.1, hijo2.1.2, hijo2.1, hijo2, Bisabuelo", 900, 165);
  stroke(255);
  strokeWeight(20);  // Beastly
  point(x, y);
}

void dijkstra(int [][]graph_connections, String []graph_name, int n,int startnode, int f, int []ruta){
  int cost[][]= new int[20][20];
  int distance[]= new int[20];
  int pred[]=new int[20];
  int visited[]= new int[20];
  int count=0,mindistance=0,nextnode=0,i=0,j=0;
  int k=0;
  
  for(i=0;i<n;i++){
    for(j=0;j<n;j++){
      if(graph_connections[i][j]==0){
        cost[i][j]=999;
      }else{
        cost[i][j]=graph_connections[i][j];
      }
    }
  }
  
  //Inicializa pred[],distance[] and visited[]
  for(i=0;i<n;i++){
    distance[i]=cost[startnode][i];
    pred[i]=startnode;
    visited[i]=0;
  }
  
  distance[startnode]=0;
  visited[startnode]=1;
  count=1;
  
  while(count<n-1){
    mindistance=999;
    
    //nextnode nos da el nodo con la distancia mínima
    for(i=0;i<n;i++){
      if(distance[i]<mindistance&&visited[i]!=1){
        mindistance=distance[i];
        nextnode=i;
      }
    }  
    //Verifica si existe un mejor camino al siguiente nodo      
    visited[nextnode]=1;
    for(i=0;i<n;i++){
      if(visited[i]!=1){
        if(mindistance+cost[nextnode][i]<distance[i]){
          distance[i]=mindistance+cost[nextnode][i];
          pred[i]=nextnode;
        }
      }
    }
    count++;
  }
  
  //Imprime la rutadel nodo inicial al final
  for(i=f;i<f+1;i++){
    if(i!=startnode){
      print("\n\nNodo ",startnode," a ",f);
      print("\nAltura del nodo=",distance[i]);
      print("\nRuta=");
      print(graph_name[f]);
      ruta[0]=f;
      j=i;
      do
      {
        j=pred[j];
        k=k+1;
        print("<-", graph_name[j]);
        ruta[k]=j;
        stroke(#9FFABE);
        strokeWeight(10);
        line(graph_points[ruta[k-1]][0],graph_points[ruta[k-1]][1], graph_points[ruta[k]][0], graph_points[ruta[k]][1]);
      }while(j!=startnode);
    }
  }
}