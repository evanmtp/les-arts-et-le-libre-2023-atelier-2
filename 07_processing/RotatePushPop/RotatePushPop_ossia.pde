/**
 * Rotate Push Pop. 
 * 
 * The push() and pop() functions allow for more control over transformations.
 * The push function saves the current coordinate system to the stack 
 * and pop() restores the prior coordinate system. 
 */

import io.ossia.*;

Protocol p = new OscQueryServer(1235, 5679);
Device d = new Device(p, "Processing_OSCQuery");

// declare ossia Parameters
//Parameter angleFactor;      // Angle of rotation
Parameter my_num;             // Number of boxes
Parameter my_scale;           // Size of boxes
Parameter my_x;           // Size of boxes
Parameter my_y;           // Size of boxes
Parameter my_offset;      // Rotation offset

float a;                 // Angle of rotation
//float offset = PI/24.0;  // Angle offset between boxes
//int num = 12;            // Number of boxes

void setup() { 
  colorMode(HSB);
  size(1920, 1080, P3D);
  noStroke();  
  
  
  Node root = d.getRootNode();
  
  // create nodes
  my_num = root.newChild()
             .name("/num")
             .type("int")
             .value(12)
             .domain(1, 20)
             .get()
             ;

  my_scale = root.newChild()
             .name("/scale")
             .type("int")
             .value(200)
             //.domain(1, 2000)
             .get()
             ;

  my_x = root.newChild()
             .name("/x")
             .type("float")
             .value(0)
             //.domain(0., 1.)
             .get()
             ;
             
  my_y = root.newChild()
             .name("/y")
             .type("float")
             .value(0.)
             .domain(0., 1.)
             .get()
             ;
             
  my_offset = root.newChild()
             .name("/offset")
             .type("float")
             .value(0.)
             //.domain(0., 1.)
             .get()
             ;

} 
 

void draw() {
  
  lights();
  //background(0, 0, 0, 0.9);
  fill(255, 255, 0, 255);
  rect(0, 0, width/2, height/2);
  // retrieve values from nodes
  int num = my_num.getValue().asInt();
  int scale = my_scale.getValue().asInt();
  float x = my_x.getValue().asFloat();
  float y = my_y.getValue().asFloat();  
  float offset = my_offset.getValue().asFloat();  
  
  
  translate(width * x, height * y); 





  for(int i = 0; i < num; i++) {
    float gray = map(i, 0, num-1, 0, 255);
    pushMatrix();
    fill(gray);
    rotateY(a + offset*i);
    rotateX(a/2 + offset*i);
    box(scale);
    popMatrix();
  }
  
  a += 0.01;    
} 
