class Controler {
  
  boolean [] stick;
  boolean [] grow;
  
  Controler() {
    grow = new boolean [num_muscles];
    for (int i = 0; i < num_muscles; i++) {
      grow[i] = false;
    }
  }
  
  void control() {
    for (int i = 0; i < num_muscles; i++) {
      if (grow[i]) {
        creatures[current_creature].muscle[i].growmuscle();                  //loaded as 1 creature
      }
    }
  }
}
