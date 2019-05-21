int num_estados = 0;
ArrayList<Estado_yuc> lista_Estados = new ArrayList<Estado_yuc>();

void setup() {
  size(1000, 800);
  PImage bg = loadImage("data/map.png");
  background(bg);
}

void draw(){
  println("x: "+mouseX+" \n y:"+mouseY);
}

void mouseClicked()
{
  lista_Estados.add(new Estado_yuc(30,30));
}

class Estado_yuc {
  int xAxis;
  int yAxis;
  
  // Contructor
  Estado_yuc(int xAxisC, int yAxisC) {
    xAxis = xAxisC;
    yAxis = yAxisC;
  }
  
  // Custom method for updating the variables
  void update() {

  }
  
  // Custom method for drawing the object
  void display() {
  }
}