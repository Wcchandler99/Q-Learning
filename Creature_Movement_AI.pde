//Libraries:
import java.util.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Collections;
import java.lang.Object;
import com.google.common.collect.Collections2;

Creature [] creatures;
Controler controler;
int num_creatures = 100;
int num_parts = 3;
int num_muscles = 3;

int gameScreen = 1;
Button stop_button;
Button play_button;
Button play_all_button;
Button evolve_button;
Button evolve_10_button;
Button evolve_100_button;
Button exploit_up_button;
Button exploit_down_button;
Button greed_up_button;
Button greed_down_button;
Button learning_up_button;
Button learning_down_button;
Button settings_button;
Button next_creature_button;
Button evolve_time_up_button;
Button evolve_time_down_button;

int current_creature = 0;

boolean play = false;                              //if true auto plays
boolean playall = false;
boolean evolve = false;

int num_evolve;
int test_time = 25000;

int evolve_round = 0;
int round = 1;

void setup() {
  size (1600, 1000);
  //frameRate(5);
  creatures = new Creature[num_creatures];
  for (int i = 0; i < num_creatures; i++) {
    //num_parts = getrandom(3,5);
    //num_muscles = getrandom(num_parts - 1, (num_parts * (num_parts - 1))/2);
    creatures[i] = new Creature(num_parts, num_muscles);
  }
  
  //controler = new Controler();

  stop_button = new Button(10, height - 110, 210, height - 10, 0, "Stop", "", 255);
  settings_button = new Button(220, height - 110, 420, height - 10, 0, "Settings", "", 255);
  next_creature_button = new Button(430, height - 110, 630, height - 10, 0, "Next", "", 255);
  play_button = new Button(width - 210, height - 110, width - 10, height - 10, 0, "Play", "Play 1 Creature", 255);
  play_all_button = new Button(width - 210, height - 220, width - 10, height - 120, 0, "Play All", "Play 100 Creatures", 255);
  evolve_button = new Button(10, 10, 210, 110, 0, "Evolve Once", "25 seconds", 255);
  evolve_10_button = new Button(220, 10, 420, 110, 0, "Evolve 10 Times", "~4 minutes", 255);
  evolve_100_button = new Button(430, 10, 630, 110, 0, "Evolve 100 Times", "~42 minutes", 255);
  
  exploit_up_button = new Button(width/2 - 400, height/2 - 200, width/2 - 200, height/2 - 100, 255, "Exploit up", "Subtract .1 from Epsilon", 0);
  exploit_down_button = new Button(width/2 - 400, height/2 - 90, width/2 - 200, height/2 + 10, 255, "Exploit down", "Add .1 to Epsilon", 0);
  
  greed_up_button = new Button(width/2 - 150, height/2 - 200, width/2 + 50, height/2 - 100, 255, "Greed up", "Subtract .1 from Gamma", 0);
  greed_down_button = new Button(width/2 - 150, height/2 - 90, width/2 + 50, height/2 + 10, 255, "Greed down", "Add .1 to Gamma", 0);
  
  learning_up_button = new Button(width/2 + 150, height/2 - 200, width/2 + 350, height/2 - 100, 255, "Learning up", "Add .1 to Alpha", 0);
  learning_down_button = new Button(width/2 + 150, height/2 - 90, width/2 + 350, height/2 + 10, 255, "Learning down", "Subtract .1 from Alpha", 0);
  
  evolve_time_up_button = new Button(width/2 + 400, height/2 - 200, width/2 + 700, height/2 - 100, 255, "Evolve Time up", "Add 5 Seconds to each evolution step", 0);
  evolve_time_down_button = new Button(width/2 + 400, height/2 - 90, width/2 + 700, height/2 + 10, 255, "Evolve Time down", "Subtract 5 Seconds from each evolution step", 0);
}

void draw() {
  if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    evolvescreen();
  } else if (gameScreen == 3) {
    settingsscreen();
  }
}


void gameScreen() {
  background(255);
  stop_button.drawbutton();
  play_button.drawbutton();
  play_all_button.drawbutton();
  settings_button.drawbutton();
  evolve_button.drawbutton();  
  evolve_10_button.drawbutton();
  evolve_100_button.drawbutton();
  next_creature_button.drawbutton();
  
  if (play) {
    if (current_creature < num_creatures) {
      creatures[current_creature].makecreature();
    }
  }
  /*
  //Interface Options:
  for (int i = 0; i < creatures[current_creature].brain.statespacesize; i++) {
    for (int j = 0; j < creatures[current_creature].brain.actionspacesize; j++) {
      fill(0);
      textSize(15);
      text(creatures[current_creature].brain.qtable.get(i).get(j), (j * 50), (i * 15));          //display brain qtable
    }
  }
  for (int j = 0; j < 19; j++) {
    fill(0);
    textSize(25);
    text(creatures[current_creature].brain.rewardtable.get(creatures[current_creature].brain.state).get(j).get(2), 220 + ((j) * 75), 100); //display reward table action rewards
  }
  for (int j = 19; j < 38; j++) {
    fill(0);
    textSize(25);
    text(creatures[current_creature].brain.rewardtable.get(creatures[current_creature].brain.state).get(j).get(2), 220 + ((j-19) * 75), 200); //display reward table action rewards
  }
  for (int j = 38; j < 57; j++) {
    fill(0);
    textSize(25);
    text(creatures[current_creature].brain.rewardtable.get(creatures[current_creature].brain.state).get(j).get(2), 220 + ((j-38) * 75), 300); //display reward table action rewards
  }
  for (int j = 57; j < creatures[current_creature].brain.actionspacesize; j++) {
    fill(0);
    textSize(25);
    text(creatures[current_creature].brain.rewardtable.get(creatures[current_creature].brain.state).get(j).get(2), 220 + ((j-57) * 75), 400); //display reward table action rewards
  }
   */


  //text("(Rows = States, Columns = Actions)", 600, 50);
  //text("(Rows = States, Columns = Actions)", 750, 600);
  //text("Q-Table States:", 250, 50);
  //text("Reward Table Rewards:", 250, 600);
  fill(0);
  textSize(50);
  text("Action:", 50, 200);
  text(creatures[current_creature].brain.action, 50, 250);                            //display brain action
  text("State:", 50, 300);
  text(creatures[current_creature].brain.state, 50, 350);                            //display brain state
  text("Reward:", 50, 400);
  text(creatures[current_creature].reward, 50, 450);                                    //display brain action reward
  //text(creatures[current_creature].muscle[0].size, width/2, height/2 + 50);             //display muscle size
  text("Alpha:", 50, 500);
  text(creatures[current_creature].alpha, 50, 550);                                   //display epsilon
  text("Gamma:", 50, 600);
  text(creatures[current_creature].gamma, 50, 650);
  text("Epsilon:", 50, 700);
  text(creatures[current_creature].epsilon, 50, 750);
  text("Distance:", 50, 800);
  text(creatures[current_creature].current_distance, 50, 850);                         //display current distance
  text("Goal Reward:", width - 500, 300);
  text(creatures[current_creature].goal.reward, width - 150, 350);
  text("Success:", width-500, height-600);
  text(creatures[current_creature].success, width - 150, height - 550);
  text("Success Reward:", width-500, height-500);
  text(creatures[current_creature].success_reward, width - 150, height - 450);
  text("Success Reward Ratio:", width-500, height-400);
  text(creatures[current_creature].success_reward_ratio, width - 150, height - 350);
  text("Creature ID:", width-500, height-310);
  text(creatures[current_creature].id, width-500, height - 260);                              //display current creature id
  text("Round:", width/2-50, height-100);
  text(round, width/2, height - 50);


  if (playall) {
    for (int i = 0; i < num_creatures; i++) {                                          //play button
      creatures[i].makecreature();
    }
    strokeWeight(5);
    stroke(0);
    fill(0);
    ellipseMode(CENTER);
    ellipse(creatures[current_creature].average_x, creatures[current_creature].average_y, 25, 25);
    fill(color(255, 215, 0));
    ellipse(creatures[current_creature].goal.x, creatures[current_creature].goal.y, 25, 25);
  }

  if (evolve) {
    for (int n = 0; n < num_evolve; n++) {
      int currenttime = millis();
      while (millis() - currenttime < test_time) {
        for (int i = 0; i < num_creatures; i++) {
          creatures[i].makecreature();
        }
      }
      for (int i = 0; i < num_creatures; i++) {
        if (creatures[i].success_reward_ratio == 0) {
          creatures[i].success_reward_ratio = int(-creatures[i].current_distance) + -999000;
        }
        for (int k = 0; k < creatures[i].brain.statespacesize; k++) {
          for (int j = 0; j < creatures[i].brain.actionspacesize; j++) {
            creatures[i].brain.rewardtable.get(k).get(j).set(3, 0);
          }
        }
      }
      Arrays.sort(creatures, Collections.reverseOrder(Comparator.comparingInt(Creature::getreward))); //if trying to get closer use: Comparator.comparingInt(Creature::getdistance)
      creatures[0].id = "1st" + "of round " + String.valueOf(round) + ":";
      gameScreen = 2;
      for (int i = num_creatures/2; i < num_creatures - (num_creatures/10); i++) {
        creatures[i] = new Creature(creatures[i - num_creatures/2]);
      }

      for (int i = num_creatures - (num_creatures/10); i < num_creatures; i++) {                                               
        //num_parts = getrandom(3, 5);
        //num_muscles = getrandom(num_parts - 1, (num_parts * (num_parts - 1))/2);
        creatures[i] = new Creature(num_parts, num_muscles);
      }

      for (int i = 0; i < num_creatures; i++) {                                                    
        creatures[i].total_reward = 0;
        creatures[i].success_reward_ratio = 0;
        creatures[i].success = 0;
        creatures[i].success_reward = 0;
      }
      round += 1;
    }
    evolve_round += 1;
    evolve = false;
  }
  //controler.control();                                             //Allows manual control of current creature
}

void evolvescreen() {
  background(0);
  evolve_button.drawbutton();
  stop_button.drawbutton();

  if (num_creatures < 38) {
    for (int i = 0; i < num_creatures; i++) {
      fill(255);
      textSize(25);
      text(creatures[i].id, 210, 50 + (i*25));
      text(creatures[i].success_reward_ratio, 350, 50 + (i*25));
    }
  } else {
    for (int i = 0; i < 38; i++) {
      fill(255);
      textSize(25);
      text(creatures[i].id, 210, 50 + (i*25));
      text(creatures[i].success_reward_ratio, 360, 50 + (i*25));
    }
    for (int i = 38; i < 76; i++) {
      fill(255);
      textSize(25);
      text(creatures[i].id, 700, 50 + ((i-38)*25));
      text(creatures[i].success_reward_ratio, 850, 50 + ((i-38)*25));
    }
    for (int i = 76; i < num_creatures; i++) {
      fill(255);
      textSize(25);
      text(creatures[i].id, 1200, 50 + ((i-76)*25));
      text(creatures[i].success_reward_ratio, 1350, 50 + ((i-76)*25));
    }
  }
}

void settingsscreen() {
  background(0);
  fill(255);
  textSize(50);
  //text("Total Reward:", 50, 450);
  text("Alpha:", 50, 500);
  text(creatures[current_creature].alpha, 50, 550);                                           //display alpha
  text("Gamma:", 50, 600);
  text(creatures[current_creature].gamma, 50, 650);                                           //display gamma
  text("Epsilon:", 50, 700);
  text(creatures[current_creature].epsilon, 50, 750);                                         //display epsilon
  text("Evolve Time:", 50, 800);
  text(test_time/1000, 50, 865);                                                              //display evolve time
  text("Creature ID:", width-500, height-310);
  text(creatures[current_creature].id, width-500, height - 260);                              //display current creature id
  text("Round:", width/2-50, height-100);
  text(round, width/2, height - 50);
  stop_button.drawbutton();
  exploit_up_button.drawbutton();
  greed_up_button.drawbutton();
  exploit_down_button.drawbutton();
  greed_down_button.drawbutton();
  learning_down_button.drawbutton();
  learning_up_button.drawbutton();
  evolve_time_down_button.drawbutton();
  evolve_time_up_button.drawbutton();
}

int getrandom(int x, int y) {
  return int(random(x, y));
}

public void mousePressed() {
  if (gameScreen==1) {
    if (evolve_button.topleftx < mouseX && mouseX < evolve_button.bottomrightx && evolve_button.toplefty < mouseY && mouseY < evolve_button.bottomrighty) {
      num_evolve = 1;
      evolve = true;
    }
    if (evolve_10_button.topleftx < mouseX && mouseX < evolve_10_button.bottomrightx && evolve_10_button.toplefty < mouseY && mouseY < evolve_10_button.bottomrighty) {
      num_evolve = 10;
      evolve = true;
    }
    if (evolve_100_button.topleftx < mouseX && mouseX < evolve_100_button.bottomrightx && evolve_100_button.toplefty < mouseY && mouseY < evolve_100_button.bottomrighty) {
      num_evolve = 100;
      evolve = true;
    }
    if (stop_button.topleftx < mouseX && mouseX < stop_button.bottomrightx && stop_button.toplefty < mouseY && mouseY < stop_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        for (int k = 0; k < creatures[i].brain.statespacesize; k++) {
          for (int j = 0; j < creatures[i].brain.actionspacesize; j++) {
            creatures[i].brain.rewardtable.get(k).get(j).set(3, 0);
          }
        }
        if (creatures[i].success_reward_ratio == 0) {
          creatures[i].success_reward_ratio = int(-creatures[i].current_distance) + -999000;
        }
      }

      Arrays.sort(creatures, Collections.reverseOrder(Comparator.comparingInt(Creature::getreward))); //swaped for getdistance //Collections.reverseOrder(                       //Removed for testing 1 creature

      creatures[0].id = "1st" + "of round " + String.valueOf(round) + ":";

      gameScreen = 2;
      stop_button.buttonfill = 255;
      stop_button.buttontextfill = 0;
      stop_button.buttontext = "Start";
      evolve_button.buttonsubtext = "";
      evolve_button.buttonfill = 255;
      evolve_button.buttontextfill = 0;
      play = false;
      playall = false;
    }
    if (settings_button.topleftx < mouseX && mouseX < settings_button.bottomrightx && settings_button.toplefty < mouseY && mouseY < settings_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {                                                   
        for (int k = 0; k < creatures[i].brain.statespacesize; k++) {
          for (int j = 0; j < creatures[i].brain.actionspacesize; j++) {
            creatures[i].brain.rewardtable.get(k).get(j).set(3, 0);
          }
        }
      }
      gameScreen = 3;
      stop_button.buttonfill = 255;
      stop_button.buttontextfill = 0;
      stop_button.buttontext = "Start";
      play = false;
      playall = false;
    }

    if (play_button.topleftx < mouseX && mouseX < play_button.bottomrightx && play_button.toplefty < mouseY && mouseY < play_button.bottomrighty) {
      play_button.buttonfill = 255;
      play = true;
    }
    if (play_all_button.topleftx < mouseX && mouseX < play_all_button.bottomrightx && play_all_button.toplefty < mouseY && mouseY < play_all_button.bottomrighty) {
      play_all_button.buttonfill = 255;
      playall = true;
    }
    if (next_creature_button.topleftx < mouseX && mouseX < next_creature_button.bottomrightx && next_creature_button.toplefty < mouseY && mouseY < next_creature_button.bottomrighty) {
      current_creature += 1;                                                                                                                         
    }
  } else if (gameScreen==2) {
    if (stop_button.topleftx < mouseX && mouseX < stop_button.bottomrightx && stop_button.toplefty < mouseY && mouseY < stop_button.bottomrighty) {
       for (int i = 0; i < num_creatures; i++) {                                                     
        creatures[i].total_reward = 0;
        creatures[i].success_reward_ratio = 0;
        creatures[i].success = 0;
        creatures[i].success_reward = 0;
      }
       
      current_creature = 0;
      play_button.buttonfill = 0;
      play_all_button.buttonfill = 0;
      stop_button.buttonfill = 0;
      stop_button.buttontextfill = 255;
      stop_button.buttontext = "Stop";
      gameScreen = 1;
      round += 1;
    }
    if (evolve_button.topleftx < mouseX && mouseX < evolve_button.bottomrightx && evolve_button.toplefty < mouseY && mouseY < evolve_button.bottomrighty) {
      for (int i = num_creatures/2; i < num_creatures - (num_creatures/10); i++) {                                                                     
        creatures[i] = new Creature(creatures[i - num_creatures/2]);
      }
      for (int i = num_creatures - (num_creatures/10); i < num_creatures; i++) {                                                                 
        //num_parts = getrandom(3,5);
        //num_muscles = getrandom(num_parts - 1, (num_parts * (num_parts - 1))/2);
        creatures[i] = new Creature(num_parts, num_muscles);
      }
    }
  } else if (gameScreen == 3) {
    if (exploit_up_button.topleftx < mouseX && mouseX < exploit_up_button.bottomrightx && exploit_up_button.toplefty < mouseY && mouseY < exploit_up_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].epsilon -= .05;
      }
    }
    if (greed_up_button.topleftx < mouseX && mouseX < greed_up_button.bottomrightx && greed_up_button.toplefty < mouseY && mouseY < greed_up_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].gamma -= .05;
      }
    }
    if (exploit_down_button.topleftx < mouseX && mouseX < exploit_down_button.bottomrightx && exploit_down_button.toplefty < mouseY && mouseY < exploit_down_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].epsilon += .05;
      }
    }
    if (greed_down_button.topleftx < mouseX && mouseX < greed_down_button.bottomrightx && greed_down_button.toplefty < mouseY && mouseY < greed_down_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].gamma += .05;
      }
    }
    if (learning_up_button.topleftx < mouseX && mouseX < learning_up_button.bottomrightx && learning_up_button.toplefty < mouseY && mouseY < learning_up_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].alpha += .05;
      }
    }
    if (learning_down_button.topleftx < mouseX && mouseX < learning_down_button.bottomrightx && learning_down_button.toplefty < mouseY && mouseY < learning_down_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {
        creatures[i].alpha -= .05;
      }
    }
    if (evolve_time_up_button.topleftx < mouseX && mouseX < evolve_time_up_button.bottomrightx && evolve_time_up_button.toplefty < mouseY && mouseY < evolve_time_up_button.bottomrighty) {
      test_time += 5000;
    }
    if (evolve_time_down_button.topleftx < mouseX && mouseX < evolve_time_down_button.bottomrightx && evolve_time_down_button.toplefty < mouseY && mouseY < evolve_time_down_button.bottomrighty) {
      test_time -= 5000;
    }
    if (stop_button.topleftx < mouseX && mouseX < stop_button.bottomrightx && stop_button.toplefty < mouseY && mouseY < stop_button.bottomrighty) {
      for (int i = 0; i < num_creatures; i++) {   
        creatures[i].total_reward = 0;
      }
      evolve_button.buttonsubtext = "~" + String.valueOf(test_time/1000) + "seconds";
      evolve_10_button.buttonsubtext = "~" + String.valueOf(int((test_time/100)/60)) + "minutes";
      evolve_100_button.buttonsubtext = "~" + String.valueOf(int((test_time/10)/60)) + "minutes";
      current_creature = 0;
      play_button.buttonfill = 0;
      stop_button.buttonfill = 0;
      stop_button.buttontextfill = 255;
      stop_button.buttontext = "Stop";
      gameScreen = 1;
      round += 1;
    }
  }
}


void keyPressed() {
  if (key == 'a') {
    controler.grow[0] = true;
  }
  if (key == 's') {
    controler.grow[1] = true;
  }
  if (key == 'd') {
    controler.grow[2] = true;
  }
  if (key == 'f') {
    controler.grow[3] = true;
  }
  if (key == 'g') {
    controler.grow[4] = true;
  }
  if (key == 'h') {
    controler.grow[5] = true;
  }
  if (key == 'q') {
    creatures[current_creature].part[0].stick = true;
  }
  if (key == 'w') {
    creatures[current_creature].part[1].stick = true;
  }
  if (key == 'e') {
    creatures[current_creature].part[2].stick = true;
  }
  if (key == 'r') {
    creatures[current_creature].part[3].stick = true;
  }
  if (key == 't') {
    creatures[current_creature].part[4].stick = true;
  }
  if (key == 'y') {
    creatures[current_creature].part[5].stick = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    controler.grow[0] = false;
  }
  if (key == 's') {
    controler.grow[1] = false;
  }
  if (key == 'd') {
    controler.grow[2] = false;
  }
  if (key == 'f') {
    controler.grow[3] = false;
  }
  if (key == 'g') {
    controler.grow[4] = false;
  }
  if (key == 'h') {
    controler.grow[5] = false;
  }
  if (key == 'q') {
    creatures[current_creature].part[0].stick = false;
  }
  if (key == 'w') {
    creatures[current_creature].part[1].stick = false;
  }
  if (key == 'e') {
    creatures[current_creature].part[2].stick = false;
  }
  if (key == 'r') {
    creatures[current_creature].part[3].stick = false;
  }
  if (key == 't') {
    creatures[current_creature].part[4].stick = false;
  }
  if (key == 'y') {
    creatures[current_creature].part[5].stick = false;
  }
}
