class Part{
  int id;
  float x;
  float y;
  float size;
  int partcolor;
  boolean stick;
  int stickcolor = color(0, 0, 0);
  
  Part(int partid, float positionx, float positiony, float partsize, boolean partstick, int partpartcolor) {
    id = partid;
    x = positionx;
    y = positiony;
    size = partsize;
    stick = partstick;
    partcolor = partpartcolor;
  }
  
  public Part(Part source) {
    id = source.id;
    x = source.x;
    y = source.y;
    size = source.size;
    partcolor = source.partcolor;
    stick = source.stick;
    stickcolor = source.stickcolor;
  }
  
  void drawpart() {
    fill(partcolor);
    if (stick == true) {
      fill(stickcolor);
    }
    strokeWeight(1);
    stroke(0);
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
    fill(0);
    textSize(25);
    //text(id, x, y);
  }
  
}
