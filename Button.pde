class Button {
  int topleftx;
  int toplefty;
  int bottomrightx;
  int bottomrighty;
  int buttonfill;
  String buttontext;
  String buttonsubtext;
  int buttontextfill;
  
  Button(int buttontopleftx, int buttontoplefty, int buttonbottomrightx, int buttonbottomrighty, int buttonbuttonfill, String buttonbuttontext, String buttonbuttonsubtext, int buttonbuttontextfill) {
    topleftx = buttontopleftx;
    toplefty = buttontoplefty;
    bottomrightx = buttonbottomrightx;
    bottomrighty = buttonbottomrighty;
    buttonfill = buttonbuttonfill;
    buttontext = buttonbuttontext;
    buttonsubtext = buttonbuttonsubtext;
    buttontextfill = buttonbuttontextfill;
  }
  
  
  void drawbutton() {
    rectMode(CORNERS);
    fill(buttonfill);
    stroke(0);
    rect(topleftx, toplefty, bottomrightx, bottomrighty);
    fill(buttontextfill);
    textSize(25);
    text(buttontext, topleftx + 10, toplefty + (bottomrighty - toplefty)/2);
    textSize(15);
    text(buttonsubtext, topleftx + 10, toplefty + ((bottomrighty - toplefty)/2) + 25);
  }
}
