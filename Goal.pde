class Goal{
  int id;
  float x;
  float y;
  float previousx;
  float previousy;
  float size;
  int gcolor;
  int goffcolor = 0;
  boolean on = true;
  int reward;
  
  //Goal as a point:
  Goal(int gid, float gx, float gy, float gsize, int ggcolor, boolean gon) {
    id = gid;
    x = gx;
    y = gy;
    size = gsize;
    gcolor = ggcolor;
    on = gon;
  }
  void drawgoal() {
    if (on) {
      fill(gcolor);
    }
    else {
      fill(goffcolor);
    }
    strokeWeight(1);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size); 
  }
}
