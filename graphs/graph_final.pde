import java.util.*;
import java.lang.Math; 

Boolean nombre_editable = false;
Boolean conectando_vertices = false;
String nombre = "";
String mensaje_inicial = "Bienvenido. Materia: Matematicas discretas ALERTA: AL CREAR UN NODO DALE UN NOMBRE DIFERENTE. PARA CREAR UN NODO HAS CLICK IZQUIERD \n CLICK DERECHO PARA SELECCIONAR UN NODO CERCANO A TU MOUSE";
Pueblos pueblo;
Map<Pueblos, String> map_pueblos = new HashMap<Pueblos, String>();
/*
Basic structure.

vertice_nombre | final | temporal
ORIGEN         | 0     | 0

Condicion base:
Tiene que calcular todos los nodos.

Calculo de la ruta:
Se va obtiendo desde la meta hasta el origen.

*/

void setup() {
  size(1000, 800);
  PImage bg = loadImage("data/map.png");
  background(bg);
  //background(170);
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
    mensaje_inicial = "CUIDADO!!!: Escribe el nombre y luego presiona ENTER";
    pueblo = new Pueblos(mouseX, mouseY);
    map_pueblos.put(pueblo, pueblo.nombre);
    pueblo.display();
    nombre_editable = true;
  }else{
    mensaje_inicial = "!! SELECCIONA DOS VERTICES !!: PRESIONA 1 para: creas una arista entre los dos. PRESIONA 2 para: crear la ruta mas optima entre los dos.";
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

void keyPressed() {
  if (key != ENTER){
    if(nombre_editable){
      nombre += key;
      pueblo.nombre = nombre;
      pueblo.display();
    }
    
    if(key == '1'){
      mensaje_inicial = "Bienvenido. Materia: Matematicas discretas ALERTA: AL CREAR UN NODO DALE UN NOMBRE DIFERENTE. PARA CREAR UN NODO HAS CLICK IZQUIERD \n CLICK DERECHO PARA SELECCIONAR UN NODO CERCANO A TU MOUSE";
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
      drawLine(pueblitos.get(0),pueblitos.get(1),0);
      /* Limpieza de conexiones */
      limpiar();
    }
    
    if(key == '2'){
      println("ALGORITMO DE RUTA");
      Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
      ArrayList<Pueblos> pueblitos = new ArrayList<Pueblos>();
      /* Pueblos interconectados */
      while(iterator_pueblos.hasNext()){      
        Pueblos pueblo = iterator_pueblos.next();
           
        if (pueblo.stroke_color != 255){
          pueblitos.add(pueblo);
        }
      }
      
      println("Distancia de: "+pueblitos.get(0).nombre+" a:"+pueblitos.get(1).nombre);
      
      Boolean isFinished = false;
      Boolean firstTime = true;
      Pueblos current = pueblitos.get(0);
      double max = 5000;
      
      HashMap<Double,Double> num_utilizados = new HashMap<Double,Double>();
      int count_nums = 0;
      
      while(!isFinished){
        
        Pueblos temp = current;
        
        if(temp == current && !firstTime){
          break; //Rompe todo.
        }
        
        if(firstTime){
          /* busco el peso de cada vertice alrededor del vertice seleccionado y el peso minimo */
          for(int i = 0; i < current.num_conexiones; i++){
            current.conexiones.get(i).temporal_dijk = pointDistance(current, current.conexiones.get(i));
            if(current.conexiones.get(i).nombre == pueblitos.get(1).nombre){
              drawLine(pueblitos.get(0), pueblitos.get(1), 255);
              limpiar();
              isFinished = true;
            }
          }
        } //ENDIF
        
        if(!firstTime){
          /* busco el peso de cada vertice alrededor del vertice seleccionado y el peso minimo */
          for(int i = 0; i < current.num_conexiones; i++){
            current.conexiones.get(i).temporal_dijk = pointDistance(current, current.conexiones.get(i));
            if (current.conexiones.get(i).temporal_dijk < max){
              max = current.conexiones.get(i).temporal_dijk;
              temp = current.conexiones.get(i);
              println(num_utilizados.get(max));
            }
          }
          isFinished = true;
        }
        /* BUSCA EL PESO MENOR EN TODOS LOS TEMPORALES QUE NO SEAN 0*/    
        
        firstTime = false;
        count_nums++;
      }
      
    }
    
    if(key == '3'){
      println("IMPRIMIENDO TODOS   ");
      Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
      while(iterator_pueblos.hasNext()){      
        Pueblos pueblo = iterator_pueblos.next();
        println(" DATOS DEL PUEBLO \n Nombre: "+pueblo.nombre);
        for(int i = 0; i < pueblo.num_conexiones; i++){
          println(" ESTA CONECTADO CON: "+ pueblo.conexiones.get(i).nombre);
          println(" TIENE UNA DISTANCIA DE: "+pointDistance(pueblo,pueblo.conexiones.get(i)));
        }
      }  
    }
    
  }else{
    mensaje_inicial = "Bienvenido. Materia: Matematicas discretas ALERTA: AL CREAR UN NODO DALE UN NOMBRE DIFERENTE. PARA CREAR UN NODO HAS CLICK IZQUIERD \n CLICK DERECHO PARA SELECCIONAR UN NODO CERCANO A TU MOUSE";
    nombre_editable = false;
    nombre = " ";
  } 
}


double calculateDistance(Pueblos pueblo){
  return Math.sqrt( Math.pow( (mouseX-pueblo.xAxis), 2) + Math.pow( (mouseY-pueblo.yAxis) , 2) );
}

double pointDistance(Pueblos point1, Pueblos point2){
    return Math.sqrt( Math.pow( (point2.xAxis-point1.xAxis), 2) + Math.pow( (point2.yAxis-point1.yAxis) , 2) );
}

void drawLine(Pueblos point1, Pueblos point2, int color_line){
  stroke(color_line);
  strokeWeight(4);
  line(point1.xAxis, point1.yAxis, point2.xAxis, point2.yAxis);
}

void limpiar(){
   Iterator<Pueblos> iterator_pueblos = map_pueblos.keySet().iterator();
     while(iterator_pueblos.hasNext()){      
         Pueblos pueblo = iterator_pueblos.next();
          if (pueblo.stroke_color != 255){
            pueblo.changeColor();
          }
    }  
}

class Pueblos {
  int xAxis, yAxis;
  int stroke_color = 255;
  int num_conexiones = 0;
  
  double final_dijk = 0;
  double temporal_dijk = 0;
  
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