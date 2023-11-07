// requires oscP5 (Import Library -> Manage Libraries)

import oscP5.*;  
import netP5.*;

/**
 * Adapted from the Patterns example: 
 * https://processing.org/examples/pattern.html
 */

OscP5 oscP5;
NetAddress OSC_to_Max;
NetAddress OSC_to_Pure_Data;

float x = 0.5;
float y = 0.5;
float circle_width = 0.1;
float circle_height = 0.1;
float stroke_weight = 0;
int r = 255;
int g = 255;
int b = 255;
color col = color(255, 255, 255);

void setup() {
  size(960, 540);
  background(102);

  // create OSC listener
  oscP5 = new OscP5(this, 8091);   

  // create OSC sender
  OSC_to_Max = new NetAddress("127.0.0.1", 8092);
  OSC_to_Pure_Data = new NetAddress("127.0.0.1", 8093);

  // attach incoming OSC messages to functions
  oscP5.plug(this, "update_x", "/x");
  oscP5.plug(this, "update_y", "/y");
  oscP5.plug(this, "update_circle_width", "/circle_width");
  oscP5.plug(this, "update_circle_height", "/circle_height");
  oscP5.plug(this, "update_stroke_weight", "/stroke_weight");
  oscP5.plug(this, "update_col", "/col");
} 

// these functions pass incoming OSC values to local variables
public void update_x(float osc_x) {
  x = osc_x;
}

public void update_y(float osc_y) {
  y = osc_y;
}

public void update_circle_width(float osc_circle_width) {
  circle_width = osc_circle_width;
}

public void update_circle_height(float osc_circle_height) {
  circle_height = osc_circle_height;
}

public void update_stroke_weight(float osc_stroke_weight) {
  stroke_weight = osc_stroke_weight;
}

public void update_col(int osc_r, int osc_g, int osc_b) {
  col = color(osc_r, osc_g, osc_b);
}

public void update_col(float osc_r, float osc_g, float osc_b) {
  col = color(osc_r, osc_g, osc_b);
}

void variableEllipse(int x, int y, int circle_width, int circle_height, int stroke_weight, color col) {
  
  stroke(stroke_weight);
  fill(col);
  ellipse(x, y, circle_width, circle_height);
}

// send mouse coordinates out via OSC
void sendMouseOSC() {
  OscMessage mouseXMessage = new OscMessage("/x");
  float relativeX = mouseX/float(width);
  mouseXMessage.add(relativeX);
  oscP5.send(mouseXMessage, OSC_to_Max); 
  oscP5.send(mouseXMessage, OSC_to_Pure_Data); 

  x = relativeX;

  OscMessage mouseYMessage = new OscMessage("/y");
  float relativeY = mouseY/float(height);
  mouseYMessage.add(relativeY);
  oscP5.send(mouseYMessage, OSC_to_Max); 
  oscP5.send(mouseYMessage, OSC_to_Pure_Data); 
  y = relativeY;
}

void draw() {
  int x_int = int(x * width);
  int y_int = int(y * height);
  int circle_width_int = int(circle_width * width);
  int circle_height_int = int(circle_height * width);
  int stroke_weight_int = int(stroke_weight * 300);

  if(mousePressed)
  {
    sendMouseOSC();
  }
  variableEllipse(x_int, y_int, circle_width_int, circle_height_int, stroke_weight_int, col);
}
