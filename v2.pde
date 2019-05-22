import java.util.*;
import java.lang.Math; 

Boolean nombre_editable = false;
Boolean conectando_vertices = false;
String nombre = "";
String mensaje_inicial = "Bienvenido. Materia: Matematicas discretas ALERTA: AL CREAR UN NODO DALE UN NOMBRE DIFERENTE.";
Pueblos pueblo;
Map<Pueblos, String> map_pueblos = new HashMap<Pueblos, String>();

void setup() {
  size(1000, 800);
  PImage bg = loadImage("data/map.png");
  background(bg);
}

void draw(){
  fill(0);  
  noStroke();
  rect(0, 0, width, 50);
  fill(255);
  text ("Mouse: " + mouseX + ", " + mouseY, width-100, 30);
  text (mensaje_inicial, 10, 30);
}

void mouseClicked()
{
  if (mouseButton == LEFT){
    nombre_editable = false;
    nombre = " ";
    mensaje_inicial = "Escribe el nombre y luego presiona ENTER";
    pueblo = new Pueblos(mouseX, mouseY);
    map_pueblos.put(pueblo, pueblo.nombre);
    pueblo.display();
    nombre_editable = true;
  }else{
    //Reviso cual esta mas cercano al punto
    
    double distancia_minima = 5000;
    String identificador = "";
    Pueblos pueblo;
    
    Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
    
    /* detector de distancia */
    while(iterator_pueblos.hasNext()){      
        pueblo = iterator_pueblos.next();
        double distancia = calculateDistance(pueblo);        
        println("Distancia de "+pueblo.nombre+" es:"+distancia);
        if(distancia < distancia_minima){
          distancia_minima = distancia;
          identificador = pueblo.nombre;
        }
    }
    /* conexion */
    iterator_pueblos = map_pueblos.keySet().iterator();
    while(iterator_pueblos.hasNext()){      
        pueblo = iterator_pueblos.next();
        if(pueblo.nombre == identificador){
          pueblo.changeColor();
        }
    } 
  }
}

double calculateDistance(Pueblos pueblo){
  return Math.sqrt( Math.pow( (mouseX-pueblo.xAxis), 2) + Math.pow( (mouseY-pueblo.yAxis) , 2) );
}

void keyPressed() {
  if (key != ENTER){
    
    if(nombre_editable){
      nombre += key;
      pueblo.nombre = nombre;
      pueblo.display();
    }
    
    if(key == '1'){
      println("conexion entre DOS vertices");
      Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
      ArrayList<Pueblos> pueblitos = new ArrayList<Pueblos>();
      
      /* Pueblos interconectados */
      while(iterator_pueblos.hasNext()){      
        Pueblos pueblo = iterator_pueblos.next();
        if (pueblo.stroke_color != 255){
          pueblitos.add(pueblo);
        }
      }
      /* insertar los nodos en los objetos */
      pueblitos.get(0).insertConexion(pueblitos.get(1));
      pueblitos.get(1).insertConexion(pueblitos.get(0));
      
      /* imprimir la ruta */
      println("Linea en las cordenadas: (x1,y1,x2,y2) "+pueblitos.get(0).xAxis+","+pueblitos.get(0).yAxis+","+pueblitos.get(1).xAxis+","+pueblitos.get(1).yAxis);
      stroke(0);
      strokeWeight(4);
      line(pueblitos.get(0).xAxis, pueblitos.get(0).yAxis, pueblitos.get(1).xAxis, pueblitos.get(1).yAxis);
      /* Limpieza de conexiones */
      iterator_pueblos = map_pueblos.keySet().iterator();
      while(iterator_pueblos.hasNext()){      
        Pueblos pueblo = iterator_pueblos.next();
        if (pueblo.stroke_color != 255){
          println("limpiando");
          pueblo.changeColor();
        }
      }  
    }
    
    if(key == '2'){
      println("ALGORITMO DE BUSQUEDA");
    }
    
    if(key == '3'){
      println("Imprimiendo todos");
      Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
      while(iterator_pueblos.hasNext()){      
        Pueblos pueblo = iterator_pueblos.next();
        println(" DATOS DEL PUEBLO \n Nombre: "+pueblo.nombre);
        for(int i = 0; i < pueblo.num_conexiones; i++){
          println(" ESTA CONECTADO CON: "+ pueblo.conexiones.get(i).nombre);
        }
      }  
    }
    
  }else{
    mensaje_inicial = "Bienvenido. Materia: Matematicas discretas";
    nombre_editable = false;
    nombre = " ";
  } 
}

class Pueblos {
  int xAxis, yAxis;
  int stroke_color = 255;
  int num_conexiones = 0;
  String nombre = " ";
  ArrayList<Pueblos> conexiones = new ArrayList<Pueblos>();
  
  // Contructor
  Pueblos(int xAxisC, int yAxisC) {
    xAxis = xAxisC;
    yAxis = yAxisC;
  }

  void changeColor(){
    if(stroke_color == 255){
      stroke_color = 150;
    }else{
      stroke_color = 255;
    }
    display();
  }
  
  // Custom method for drawing the object
  void display() {
    // Display the point
    stroke(stroke_color);
    strokeWeight(20);
    ellipse(xAxis, yAxis, 10, 10);

    //Display the name
    fill(0, 102, 153);
    text(nombre, xAxis-25, yAxis);
  }
  
  //Create a node conection between the points
  void insertConexion(Pueblos pueblo){
    conexiones.add(pueblo);
    num_conexiones++;
  }
}