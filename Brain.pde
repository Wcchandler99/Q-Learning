class Brain {
  /*
  float [] inputs;
  float [][] weights1;
  float [] hidden;
  float [][] weights2;
  float [] output;
  float score;
  */
  float learning_rate;
  ArrayList<Collection<List<Integer>>> actionspacesettup = new ArrayList<Collection<List<Integer>>>(); 
  ArrayList<ArrayList<Integer>> actionspace = new ArrayList<ArrayList<Integer>>(); //actionspace for 3 part creature
  //ArrayList<ArrayList<Integer>> actionspace = new ArrayList<ArrayList<Integer>>();         //actionspace for 2 part creature
  Integer state = 0;  
  Integer next_state;  
  Integer action = 0;
  int actionsize = num_parts + num_muscles;
  double statespacesizesettup = Math.pow(2, actionsize); //600;
  double actionspacesizesettup = Math.pow(2, actionsize);
  int statespacesize = (int) statespacesizesettup;
  int actionspacesize = (int) actionspacesizesettup;
  ArrayList<Collection<List<Integer>>> statespacesettup = new ArrayList<Collection<List<Integer>>>();
  ArrayList<List<Integer>> statespace = new ArrayList<List<Integer>>(); //statespace for 3 part creature
  //ArrayList<ArrayList<Integer>> statespace = new ArrayList<ArrayList<Integer>>();
  ArrayList<ArrayList<ArrayList<Integer>>> rewardtable = new ArrayList<ArrayList<ArrayList<Integer>>>();
  ArrayList<ArrayList<Float>> qtable = new ArrayList<ArrayList<Float>>();
  ArrayList<ArrayList<Integer>> rtmap = new ArrayList<ArrayList<Integer>>();
  
  
  Brain() {
    learning_rate = random(-.1,.1);
    /*
    //Statespace for states including muscle size:
    ArrayList<Integer> states0 = new ArrayList<Integer>();
    ArrayList<Integer> states1 = new ArrayList<Integer>();
    ArrayList<Integer> states2 = new ArrayList<Integer>();
    ArrayList<Integer> states3 = new ArrayList<Integer>();
    
    states0.add(0);
    states0.add(0);
    
    states1.add(1);
    states1.add(0);
    
    states2.add(0);
    states2.add(1);
    
    states3.add(1);
    states3.add(1);
    
    for(int i = 0; i < 150; i++) {
      states0.add(i);
      states1.add(i);
      states2.add(i);
      states3.add(i);
      ArrayList<Integer> state0 = (ArrayList<Integer>) states0.clone();
      ArrayList<Integer> state1 = (ArrayList<Integer>) states1.clone();
      ArrayList<Integer> state2 = (ArrayList<Integer>) states2.clone();
      ArrayList<Integer> state3 = (ArrayList<Integer>) states3.clone();
      statespace.add(state0);
      statespace.add(state1);
      statespace.add(state2);
      statespace.add(state3);
      states0.remove(2);
      states1.remove(2);
      states2.remove(2);
      states3.remove(2);
    }
    */
    
    //Reward Table:
    /*
    // if the above is re added then int i = 1 should be put in for int i = 0:
    for(int i = 0; i < 150; i++) { 
      ArrayList<Integer> rtentry0 = new ArrayList<Integer>();
      rtentry0.add(1);
      rtentry0.add(0);
      rtentry0.add(-2);
      rtentry0.add(0);//END ACTION
      ArrayList<Integer> rtentry1 = new ArrayList<Integer>();
      rtentry1.add(1);
      rtentry1.add(0);
      rtentry1.add(-2);
      rtentry1.add(0);//END ACTION
      ArrayList<Integer> rtentry2 = new ArrayList<Integer>();
      rtentry2.add(1);
      rtentry2.add(0);
      rtentry2.add(-2);
      rtentry2.add(0);//END ACTION
      ArrayList<Integer> rtentry3 = new ArrayList<Integer>();
      rtentry3.add(1);
      rtentry3.add(0);
      rtentry3.add(-2);
      rtentry3.add(0);//END ACTION
      ArrayList<Integer> rtentry4 = new ArrayList<Integer>();
      rtentry4.add(1);
      rtentry4.add(0);
      rtentry4.add(-2);
      rtentry4.add(0);//END ACTION
      ArrayList<Integer> rtentry5 = new ArrayList<Integer>();
      rtentry5.add(1);
      rtentry5.add(0);
      rtentry5.add(-2);
      rtentry5.add(0);//END ACTION
      ArrayList<Integer> rtentry6 = new ArrayList<Integer>();
      rtentry6.add(1);
      rtentry6.add(0);
      rtentry6.add(-2);
      rtentry6.add(0);//END ACTION
      ArrayList<Integer> rtentry7 = new ArrayList<Integer>();
      rtentry7.add(1);
      rtentry7.add(0);
      rtentry7.add(-2);
      rtentry7.add(0);//END ACTION
      //END ACTION
      ArrayList<Integer> rtentry8 = new ArrayList<Integer>();
      rtentry8.add(1);
      rtentry8.add(0);
      rtentry8.add(-10);
      rtentry8.add(0);
      ArrayList<ArrayList<Integer>> rtmap = new ArrayList<ArrayList<Integer>>();
      rtmap.add(rtentry0);
      rtmap.add(rtentry1);
      rtmap.add(rtentry2);
      rtmap.add(rtentry3);
      rtmap.add(rtentry4);
      rtmap.add(rtentry5);
      rtmap.add(rtentry6);
      rtmap.add(rtentry7);
      rtmap.add(rtentry8); // END ACTION
      ArrayList<ArrayList<Integer>> rtmapclone = (ArrayList<ArrayList<Integer>>) rtmap.clone();
      rtmapclone.get(0).set(1, i-1);
      rtmapclone.get(1).set(1, i);
      rtmapclone.get(2).set(1, i+1);
      rtmapclone.get(3).set(1, i-1);
      rtmapclone.get(4).set(1, i+1);
      rtmapclone.get(5).set(1, i);
      rtmapclone.get(6).set(1, i-1);
      rtmapclone.get(7).set(1, i+1);
      rtmapclone.get(8).set(1, i);
      rewardtable.add(rtmapclone);
      rewardtable.add(rtmapclone);
      rewardtable.add(rtmapclone);
      rewardtable.add(rtmapclone);
    }
    */
    //Generalized state and action space:
    ArrayList<ArrayList<Integer>> vals = new ArrayList<ArrayList<Integer>>();
    ArrayList<Integer> vals0 = new ArrayList<Integer>();
    
    for (int i = 0; i <= actionsize; i++) {
      for (int j = 0; j < actionsize - i; j++) {
        vals0.add(0);
      }
      for (int j = 0; j < i; j++) {
        vals0.add(1);
      }
      vals.add(vals0);
      vals0 = new ArrayList<Integer>();
    }
    
    for (int i = 0; i <= actionsize; i++) {
      Collection<List<Integer>> orderPerm = Collections2.orderedPermutations(vals.get(i));
      for (List<Integer> val : orderPerm) {
        ArrayList<Integer> set = new ArrayList<Integer>(val);
        actionspace.add(set);
        statespace.add(set);                                                                 //Removing statespace as copy of action space
      }
    }
    //reward table for statespace as copy of action space
    for(int i = 0; i < statespacesize; i++) {
      ArrayList<ArrayList<Integer>> rtmap = new ArrayList<ArrayList<Integer>>();
      for(int j = 0; j < actionspacesize; j++) {
        ArrayList<Integer> rtentry0 = new ArrayList<Integer>();
        rtentry0.add(1);
        rtentry0.add(j);
        rtentry0.add(-2);
        rtentry0.add(0);//END ACTION
        rtmap.add(rtentry0);
      }
      ArrayList<ArrayList<Integer>> rtmapclone = (ArrayList<ArrayList<Integer>>) rtmap.clone();
      rewardtable.add(rtmapclone);
    }

    
    //QTABLE:
    for(int i = 0; i < statespacesize; i++) {
      ArrayList<Float> arr = new ArrayList<Float>();
      for(int j = 0; j < actionspacesize; j++) {
        arr.add(0.0);
      }
      qtable.add(arr);
    }
    
    //state = 0;

  }
  
  public Brain(Brain source) {
    learning_rate = source.learning_rate;
    actionspace = source.actionspace;
    statespacesize = source.statespacesize;
    actionspacesize = source.actionspacesize;
    statespace = source.statespace;
    rewardtable = source.rewardtable;
    qtable = source.qtable;
    rtmap = source.rtmap; 
  } 
}
