class Muscle{
  int id;
  float leftx;
  float lefty;
  float rightx;
  float righty;
  float size;
  float previous_size; // for statespace without musclesize
  int musclecolor;
  float strength;
  float dx;
  float dy;
  float angle;
  float midpointx;
  float midpointy;
  int leftpart;
  int rightpart;
  
  Muscle(int muscleid, int muscleleftpart, int musclerightpart, float leftpositionx, float leftpositiony, float rightpositionx, float rightpositiony, float musclesize, float musclestrength, int musclemusclecolor) {
    id = muscleid;
    leftpart = muscleleftpart;
    rightpart = musclerightpart;
    leftx = leftpositionx;
    lefty = leftpositiony;
    rightx = rightpositionx;
    righty = rightpositiony;
    size = musclesize;
    strength = musclestrength;
    musclecolor = musclemusclecolor;
  }
  
  public Muscle(Muscle source) {
    id = source.id;
    leftx = source.leftx;
    lefty = source.lefty;
    rightx = source.rightx;
    righty = source.righty;
    size = source.size;
    strength = source.strength;
    musclecolor = source.musclecolor;
    leftpart = source.leftpart;
    rightpart = source.rightpart;
  }
  
    void moveparts(Part prt1, Part prt2) {
    // every calculations here
    dx = prt2.x - prt1.x;
    dy = prt2.y - prt1.y;
    angle = atan2(dy, dx);
    midpointx = (prt2.x + prt1.x)/2;
    midpointy = (prt2.y + prt1.y)/2;
    if (!prt1.stick) {
      prt1.x = midpointx - cos(angle) * (size/2);
      prt1.y = midpointy - sin(angle) * (size/2);
    }
    if (!prt2.stick) {
      prt2.x = midpointx + cos(angle) * (size/2);
      prt2.y = midpointy + sin(angle) * (size/2);
    }
    leftx = prt1.x;
    lefty = prt1.y;
    rightx = prt2.x;
    righty = prt2.y;
  }
  
  void drawmuscle() {
    strokeWeight(strength);
    stroke(musclecolor);
    line(leftx, lefty, rightx, righty);
    size = dist(leftx, lefty, rightx, righty);
    fill(musclecolor);
    textSize(25);
    //text(size, leftx+25, lefty+25);
  }
  
  void pullmuscle() {
    previous_size = size;
    size -= 1;
  }
  
  void relaxmuscle() {
    previous_size = size;
    size += 1;
  }
  
  void growmuscle() {
    previous_size = size;
    if (size < 150) { //for 2part test always grow or shrink
      size += 2;
    }
  }
}
