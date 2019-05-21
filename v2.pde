import java.util.*;

Boolean nombre_editable = false;
String nombre = "";
Pueblos pueblo;
Map<Pueblos, String> map_pueblos = new HashMap<Pueblos, String>();

void setup() {
  size(1000, 800);
  PImage bg = loadImage("data/map.png");
  background(bg);
}

void draw(){
  // Information in the upper screen
  fill(0);    // black rectangle = background for information
  noStroke();
  rect(0, 0, width, 50);
  fill(255);  // Text
  text ("Mouse: " + mouseX + ", " + mouseY, width-100, 30);
  text ("Con click derecho agregas un nuevo nodo, luego escribe su nombre y escribe enter. ", 10, 30);
  // -------------- 
}

void mouseClicked()
{
  nombre_editable = false;
  nombre = " ";
  pueblo = new Pueblos(mouseX, mouseY);
  map_pueblos.put(pueblo, pueblo.nombre);
  pueblo.display();
  nombre_editable = true;
}

void keyPressed() {
  if (key != ENTER){
    if(nombre_editable){
      nombre += key;
      pueblo.nombre = nombre;
      pueblo.display();
    }
  }else{
    nombre_editable = false;
    nombre = " ";
  } 
}

class Pueblos {
  String nombre = " ";
  int xAxis;
  int yAxis;
  
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
    point(xAxis, yAxis);
    //Display the name
    fill(0, 102, 153);
    text(nombre, xAxis-25, yAxis);
  }
}