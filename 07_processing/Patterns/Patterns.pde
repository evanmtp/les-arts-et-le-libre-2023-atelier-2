
/**
 * Adapted from the Patterns example: 
 * https://processing.org/examples/pattern.html
 */
 
import io.ossia.*;

Protocol p = new OscQueryServer(1237, 5681);
Device d = new Device(p, "Processing_Patterns");

// declare ossia Parameters
Parameter my_color;             // Number of boxes
Parameter my_scale;           // Size of boxes
Parameter my_x;           // Size of boxes
Parameter my_y;           // Size of boxes
Parameter my_circle_width;
Parameter my_circle_height;
Parameter my_stroke_weight;
Parameter my_offset;      // Rotation offset
Parameter my_mouseX;
Parameter my_mouseY;

void setup() {
  size(960, 540);
  background(102);
  
  Node root = d.getRootNode();
  
  // create nodes

  my_color = root.newChild()
                 .name("/color")
                 .type("rgba8")
                 .value(120, 20, 50, 255)
                 .description("Rectangle fill color")
                 .get()
                 ;

  my_x = root.newChild()
             .name("/x")
             .type("float")
             .value(0.5)
             //.domain(0., 1.)
             .get()
             ;
             
  my_y = root.newChild()
             .name("/y")
             .type("float")
             .value(0.5)
             .domain(0., 1.)
             .get()
             ;

  my_circle_width = root.newChild()
             .name("/width")
             .type("float")
             .value(0.1)
             .domain(0., 1.)
             .get()
             ;
             
  my_circle_height = root.newChild()
             .name("/height")
             .type("float")
             .value(0.1)
             .domain(0., 1.)
             .get()
             ;
             
  my_stroke_weight = root.newChild()
             .name("/weight")
             .type("int")
             .value(0)
             //.domain(0., 1.)
             .get()
             ;
             
    my_mouseX = root.newChild()
             .name("/mouse_x")
             .type("int")
             .value(0)
             //.domain(0., 1.)
             .get()
             ;
       
      my_mouseY = root.newChild()
             .name("/mouse_y")
             .type("int")
             .value(0)
             //.domain(0., 1.)
             .get()
             ;
} 

void draw() {

  // retrieve values from nodes
  Vec4F col = my_color.getValue().asVec4();
  float x_pos = my_x.getValue().asFloat();
  float y_pos = my_y.getValue().asFloat(); 
  int circle_width = int(my_circle_width.getValue().asFloat() * width);
  int circle_height = int(my_circle_height.getValue().asFloat() * width);  
  int stroke_weight = my_stroke_weight.getValue().asInt();  
  int x = int(x_pos * width);
  int y = int(y_pos * height);

  // Call the variableEllipse() method and send it the
  // parameters for the current mouse position
  // and the previous mouse position
  fill(col.x, col.y, col.z);
  variableEllipse(x, y, circle_width, circle_height, stroke_weight);
  
  my_mouseX.push(mouseX);
  my_mouseY.push(mouseY);
}


// The simple method variableEllipse() was created specifically 
// for this program. It calculates the speed of the mouse
// and draws a small ellipse if the mouse is moving slowly
// and draws a large ellipse if the mouse is moving quickly 

void variableEllipse(int x, int y, int circle_width, int circle_height, int stroke_weight) {
  stroke(stroke_weight);
  //fill(col);
  ellipse(x, y, circle_width, circle_height);
}
