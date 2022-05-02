class Creature {
  Part [] part;
  Muscle [] muscle;
  Goal goal;
  Brain brain;
  float average_x;
  float average_y;
  float current_distance;
  float previous_distance;
  int num_parts;
  int num_muscles;
  String id = "";
  int generation = 0;
  ArrayList<Integer> currentstate;
  
  //For qtable:
  float alpha = .5;
  float gamma = .7;
  float epsilon = .01;
  ArrayList<Integer> currentaction = new ArrayList<Integer>();
  int reward;
  int total_reward;
  int success;
  int success_reward;
  int success_reward_total;
  int success_reward_ratio;
  float old_value;
  float next_max;   
  Float new_value;

  Creature(int creature_num_parts, int creature_num_muscles) {
    num_parts = creature_num_parts;
    num_muscles = creature_num_muscles;

    part = new Part[num_parts];
    int partcolor = color(0, 0, 0);
    for (int i = 0; i < num_parts; i++) {
      if (i == 0) {
        partcolor = color(255, 0, 0);
      }
      if (i == 1) {
        partcolor = color(0, 255, 0);
      }
      if (i == 2) {
        partcolor = color(0, 0, 255);
      }
      if (i == 3) {
        partcolor = color(255, 255, 0);
      }
      if (i == 4) {
        partcolor = color(128, 0, 128);
      }
      if (i == 5) {
        partcolor = color(255, 127, 80);
      }
      if (i == 6) {
        partcolor = color(155, 0, 0);
      }
      if (i == 7) {
        partcolor = color(0, 155, 0);
      }
      if (i == 8) {
        partcolor = color(0, 0, 155);
      }
      if (i == 9) {
        partcolor = color(155, 155, 0);
      }
      if (i == 10) {
        partcolor = color(28, 0, 28);
      }
      if (i == 0) {                                                                     //Part positions set up for  3 parts only
        part[i] = new Part(i, width/2 + 25, height/2 + 25, 25, false, partcolor);
      }
      if (i == 1) {
        part[i] = new Part(i, width/2 - 25, height/2, 25, false, partcolor);
      }
      if (i == 2) {
        part[i] = new Part(i, width/2 + 25, height/2 + 25, 25, false, partcolor);
      }
    }
    
    int [][] check = new int[num_muscles][2];
    int leftpart;
    int rightpart;
                                                                  //Randomly assigns left and right parts to muscles but is broken for some reason?????
    for (int i = 0; i < num_muscles; i++) {
      While: while (true) {
        leftpart = int(random(0, num_parts));
        rightpart = int(random(0, num_parts));
        if (leftpart == rightpart) {
          continue While;
        }
        for (int j = 0; j < num_muscles; j++) {
          if (leftpart == check[j][0] && rightpart == check[j][1]) {
            continue While;
          } 
          if (rightpart == check[j][0] && leftpart == check[j][1]) {
            continue While;
          }
        }
        break While;
      }
      check[i][0] = leftpart;
      check[i][1] = rightpart;
    }

    muscle = new Muscle[num_muscles];
    int musclecolor = color(0);
    for (int i = 0; i < num_muscles; i++) {
      if (i == 0) {
        musclecolor = color(255, 0, 0);
      }
      if (i == 1) {
        musclecolor = color(0, 255, 0);
      }
      if (i == 2) {
        musclecolor = color(0, 0, 255);
      }
      if (i == 3) {
        musclecolor = color(255, 255, 0);
      }
      if (i == 4) {
        musclecolor = color(128, 0, 128);
      }
      if (i == 5) {
        musclecolor = color(255, 127, 80);
      }
      if (i == 6) {
        musclecolor = color(0);
      }
      muscle[i] = new Muscle(i, check[i][0], check[i][1],
      part[check[i][0]].x, part[check[i][0]].y, part[check[i][1]].x, part[check[i][1]].y,
      dist(part[check[i][0]].x, part[check[i][0]].y, part[check[i][1]].x, part[check[i][1]].y), 4, musclecolor);
    }
    
    
    brain = new Brain();
    
    
    currentaction = new ArrayList<>();
    for (int i = 0; i < 3; i++) {
      currentaction.add(0);
    }
    currentstate = new ArrayList<>();
    for (int i = 0; i < num_parts; i++) {
      currentstate.add(int(part[i].x - width/2));
    }
    for (int i = 0; i < num_muscles; i++) {
      currentstate.add(int(muscle[i].size));
    }

    
    goal = new Goal(1, width/2 + 200, height/2 - 200, 25, color(255, 215, 0), true);
    goal.reward = 10*int(sqrt(sq(average_x - goal.x) + sq(average_y - goal.y)));
    
    //alpha = random(0, 1);
    //gamma = random(0, 1);
    //epsilon = random(0, 1);
    
    //Gen name:
    id = "GEN" + String.valueOf(generation);
    //brain name:
    //id = String.format("%.2f", alpha) + "-" + String.format("%.2f", gamma) + "-" + String.format("%.2f", epsilon) + "GEN" + String.valueOf(generation);
    
    //body name:
    /*
    for (int i = 0; i < num_muscles; i++) {
      id += String.valueOf(muscle[i].leftpart) + String.valueOf(muscle[i].rightpart) + "-";
    }
    id += "GEN" + String.valueOf(generation);
    */
  }
//COPY------------------------------------------------------------------------------------------------------------------------------------------------------  
  public Creature(Creature source) {
    if (random(-1, 1) < 0) {                                       //NOT A TRUE 50/50 (Leaning toward addition)
      alpha = source.alpha + source.brain.learning_rate;
    }
    else {
      alpha = source.alpha - source.brain.learning_rate;
    }
    if (random(-1, 1) < 0) {                                       //NOT A TRUE 50/50 (Leaning toward addition)
      gamma = source.gamma + source.brain.learning_rate;
    }
    else {
      gamma = source.gamma - source.brain.learning_rate;
    }
    if (random(-1, 1) < 0) {                                       //NOT A TRUE 50/50 (Leaning toward addition)
      epsilon = source.epsilon + source.brain.learning_rate;
    }
    else {
      epsilon = source.epsilon - source.brain.learning_rate;
    }
    num_parts = source.num_parts;
    num_muscles = source.num_muscles;
    generation = source.generation;

    part = new Part[num_parts];
    for (int i = 0; i < num_parts; i++) {
      part[i] = new Part(i, source.part[i].x, source.part[i].y, source.part[i].size, source.part[i].stick, source.part[i].partcolor); //spawn coord changed for 2part test
    }
    
    muscle = new Muscle[num_muscles];
    for (int i = 0; i < num_muscles; i++) {
      muscle[i] = new Muscle(i, source.muscle[i].leftpart, source.muscle[i].rightpart, source.muscle[i].leftx, source.muscle[i].lefty, source.muscle[i].rightx, source.muscle[i].righty, dist(source.muscle[i].leftx, source.muscle[i].lefty, source.muscle[i].rightx, source.muscle[i].righty), 4, source.muscle[i].musclecolor);
    }
    
    
    generation += 1;
    
    brain = source.brain;
    
    currentstate = new ArrayList<>();
    for (int i = 0; i < num_parts; i++) {
      currentstate.add(int(part[i].x - width/2));
    }
    for (int i = 0; i < num_muscles; i++) {
      currentstate.add(int(muscle[i].size));
    }
    
    //Generation Name:
    id = "GEN" + String.valueOf(generation) + "Clone";
    //brain name:
    //id = String.format("%.2f", alpha) + "-" + String.format("%.2f", gamma) + "-" + String.format("%.2f", epsilon) + "GEN" + String.valueOf(generation) + "Clone";
    
    //body name:
    /*
    for (int i = 0; i < num_muscles; i++) {
      id += String.valueOf(muscle[i].leftpart) + String.valueOf(muscle[i].rightpart) + "-";
    }
    id += "GEN" + String.valueOf(generation) + "Clone";
    */
    //rightgoal = new Goal(1, width/2 + 150, height/2-50, width/2+150, height/2+50, color(255, 215, 0), false);
    //leftgoal = new Goal(2, width/2 - 150, height/2-50, width/2-150, height/2+50, color(255, 215, 0), true);
    
    goal = new Goal(1, source.goal.x, source.goal.y, 25, color(255, 215, 0), true);
  }
//COPY--------------------------------------------------------------------------------------------------------------------------------------------------------

  void makecreature() {
    checkbrain();
    movemuscles();
    drawcreature();
    creature_relax();
    //leftgoal.drawgoal();
    //rightgoal.drawgoal();
    average_distance_draw();
    goal.drawgoal();
  }
  
  void movemuscles() {
    for (int i = 0; i < num_muscles; i++) {
      muscle[i].moveparts(part[muscle[i].leftpart], part[muscle[i].rightpart]);
    }
  }
  
  void drawcreature() {
    for (int i = 0; i < num_parts; i++) {
      part[i].drawpart();
    }
    for (int i = 0; i < num_muscles; i++) {
      muscle[i].drawmuscle();
    }
  }
  
  void creature_relax() {                                 
    for (int i = 0; i < num_muscles; i++) {
      if (muscle[i].size > 100) {                        //for experimenting with 2part creature allways pull
        muscle[i].pullmuscle();
      }
    }
    for (int i = 0; i < num_muscles; i++) {
      if (muscle[i].size < 100) {
        muscle[i].relaxmuscle();                          //for experimenting with 2part creature allways pull         
      } 
    } 
  }
  
  void checkdistance() {
    //ArrayList<Integer> absolutedistance = new ArrayList<Integer>();
    //ArrayList<Integer> truedistance = new ArrayList<Integer>();
    //int truevalue;
    //previous_creature_distance = creature_distance;
    average_x = 0;
    average_y = 0;
    previous_distance = current_distance;
    
    for (int i = 0; i < num_parts; i++) {
       average_x += part[i].x;
       average_y += part[i].y;
    }
    average_x = average_x/num_parts;
    average_y = average_y/num_parts;
    current_distance = sqrt(sq(average_x - goal.x) + sq(average_y - goal.y));

      /*
      creature_distance += int(part[i].x - width/2);
      truevalue = int(part[i].x - width/2);
      truedistance.add(truevalue);
      absolutedistance.add(abs(truevalue));
    creature_distance = creature_distance/2;
    current_distance = truedistance.get(absolutedistance.indexOf(Collections.max(absolutedistance)));
    */
  }
  
  void average_distance_draw() {
    strokeWeight(1);
    stroke(0);
    fill(0);
    ellipseMode(CENTER);
    ellipse(average_x, average_y, 5, 5);
  }
  
  int getdistance() {
    return int(current_distance);
  }
  
  
  int getreward() {
    return success_reward_ratio;
  }
  
  void checkbrain() {
    checkdistance();
    loadstate();
    qtrain();
    loadreward();
    
  }
  
  void randomcontrol() {
    currentaction = (ArrayList<Integer>) brain.actionspace.get(int(random(0, brain.actionspacesize))).clone();
    if (brain.actionspace.contains(currentaction)) {
      brain.action = brain.actionspace.indexOf(currentaction);
    }
    /*
    if (brain.action == 8) {                                     //END ACTION
      for (int i = 0; i < brain.statespacesize; i++) {
        for (int j = 0; j < brain.actionspacesize; j++) {
          brain.rewardtable.get(i).get(j).set(3, 1);
        }
      }
    } 
    */
    for( int i = 0; i < num_parts; i++) {
      if (currentaction.get(i) > .5) {
        part[i].stick = true;
      }
      else {
        part[i].stick = false;
      }
    }
    for( int i = num_parts; i < num_parts + num_muscles-1; i++) {
      if (currentaction.get(i) > .5) {
        if (muscle[i - num_parts].size < 150) {
          muscle[i - num_parts].growmuscle();
        }
      }
    }
  }
  
  void control() {
    currentaction = (ArrayList<Integer>) brain.actionspace.get(brain.qtable.get(brain.state).indexOf(Collections.max(brain.qtable.get(brain.state)))).clone(); 
    if (brain.actionspace.contains(currentaction)) {
      brain.action = brain.actionspace.indexOf(currentaction);
    }
    /*
    if (brain.action == 8) {                                     //END ACTION
      for (int i = 0; i < brain.statespacesize; i++) {
        for (int j = 0; j < brain.actionspacesize; j++) {
          brain.rewardtable.get(i).get(j).set(3, 1);
        }
      }
    }
    */
    for( int i = 0; i < num_parts; i++) {
      if (currentaction.get(i) > .5) {
        part[i].stick = true;
      }
      else {
        part[i].stick = false;                                             //ERROR: Index 5 out of bounds for length 5. Occurred when Play all hit in 3rd roung
      }
    }
    for( int i = num_parts; i < num_parts + num_muscles-1; i++) {
      if (currentaction.get(i) > .5) {
        if (muscle[i - num_parts].size < 150) {
          muscle[i - num_parts].growmuscle();
        }
      }
    }
  }
  
  void loadstate() {
     // state as copy of action
    currentstate = new ArrayList<>();
    for (int i = 0; i < num_parts; i++) {
      if (part[i].stick) {
        currentstate.add(1);
      }
      else {
        currentstate.add(0);
      }
    }
    for (int i = 0; i < num_muscles; i++) {
      if (muscle[i].previous_size < muscle[i].size) {
        currentstate.add(1);
      }
      else {
        currentstate.add(0);
      }
    }

    //For statespace with muscle size:
    //for (int i = 0; i < num_muscles; i++) {
      //currentstate.add(int(muscle[i].size));
    //}

    //currentstate.add(0);                                                         //Currently NOT adding a 0 for done action to state
    
    if (brain.statespace.contains(currentstate)) {
      brain.state = brain.statespace.indexOf(currentstate);
    }
    
  }
  
  //END ACTION
  void loadreward() { 
    for (int i = 0; i < brain.statespacesize; i++) {
      for (int j = 0; j < brain.actionspacesize; j++) {
        brain.rewardtable.get(i).get(j).set(3, 0);
      }
    }
    if (current_distance < previous_distance) {
      brain.rewardtable.get(brain.state).get(brain.action).set(2, -1);
    }
    if (current_distance > previous_distance) {
      brain.rewardtable.get(brain.state).get(brain.action).set(2, -3);
    }
    
    //Lets them touch the goal with a part
    for (int i = 0; i < num_parts; i++) {
      if (sqrt(sq(part[i].x - goal.x) + sq(part[i].y - goal.y)) <= 25) {
        if(brain.rewardtable.get(brain.state).get(brain.action).get(3) == 0) {  
          brain.rewardtable.get(brain.state).get(brain.action).set(2, goal.reward);
        }
      }  
      else {
        if(brain.rewardtable.get(brain.state).get(brain.action).get(3) == 1) {
          brain.rewardtable.get(brain.state).get(brain.action).set(2, -1);
        }
      }
    }
    
    if (current_distance <= 25) {
      if(brain.rewardtable.get(brain.state).get(brain.action).get(3) == 0) { 
        brain.rewardtable.get(brain.state).get(brain.action).set(2, goal.reward);
      }
    }  
    else {
      if(brain.rewardtable.get(brain.state).get(brain.action).get(3) == 1) {
        brain.rewardtable.get(brain.state).get(brain.action).set(2, -1);
      }
    }
    
    if (reward == goal.reward) {
      for (int i = 0; i < brain.statespacesize; i++) {
        for (int j = 0; j < brain.actionspacesize; j++) {
          brain.rewardtable.get(i).get(j).set(3, 1);
          brain.rewardtable.get(i).get(j).set(2, -1);
        }
      }
      goal.previousx = goal.x;
      goal.previousy = goal.y;
      goal.x = random(width/2-200, width/2+200);
      goal.y = random(height/2-200, height/2+200);
      goal.reward = 10*int(sqrt(sq(goal.previousx - goal.x) + sq(goal.previousy - goal.y)));
    }
  }

  void qtrain() {    
    if (random(0,1) < epsilon) { //RANDOM CONTROL   
      randomcontrol();
    }
    else {
      control();
    }
    
    brain.next_state = brain.rewardtable.get(brain.state).get(brain.action).get(1);   
    reward = brain.rewardtable.get(brain.state).get(brain.action).get(2);
    total_reward += reward;
    success_reward += reward;
    old_value = brain.qtable.get(brain.state).get(brain.action);
    next_max = Collections.max(brain.qtable.get(brain.next_state));      
    new_value = old_value + alpha * (reward + gamma * next_max - old_value);
    //new_value = (1 - alpha) * old_value + alpha * (reward + gamma * next_max);               //Alternate QVALUE FORMULA
    brain.qtable.get(brain.state).set(brain.action, new_value);
    
    //if (success > 0) {
     // success_reward_ratio = int(success_reward/success);
    //}
    
    if (reward == goal.reward) {
      success += 1;
      success_reward_total += int(success_reward);
      success_reward_ratio = int(success_reward_total/success);
      success_reward = 0;
    }
  }
}
