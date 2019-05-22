import java.util.*;
import java.lang.Math; 

Boolean nombre_editable = false;
String nombre = "";
String mensaje_inicial = "Bienvenido. Materia: Matematicas discretas";
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
    
    Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
    
    while(iterator_pueblos.hasNext()){
      
        Pueblos pueblo = iterator_pueblos.next();
        double distancia = calculateDistance(pueblo);
        
        println("Distancia de "+pueblo.nombre+" es:"+distancia);
        
        if(distancia < distancia_minima){
          distancia_minima = distancia;
          identificador = pueblo.nombre;
        }
    }
    println("el menor es:"+identificador);
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
  }else{
    mensaje_inicial = "Bienvenido. Materia: Matematicas discretas";
    nombre_editable = false;
    nombre = " ";
  } 
}

class Pueblos {
  String nombre = " ";
  int xAxis;
  int yAxis;
  int[][] connections;
  
  // Contructor
  Pueblos(int xAxisC, int yAxisC) {
    xAxis = xAxisC;
    yAxis = yAxisC;
  }
  
  // Custom method for updating the variables
  void update() {

  }
  
  // Custom method for drawing the object
  void display() {
    // Display the point
    stroke(255);
    strokeWeight(20);
    ellipse(xAxis, yAxis, 10,  10);

    //Display the name
    fill(0, 102, 153);
    text(nombre, xAxis-25, yAxis);
  }
}