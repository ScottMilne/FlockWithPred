
ArrayList<Prey> prey = new ArrayList(); //all prey
ArrayList<Pred> pred = new ArrayList(); //all predators

/** Loads app */
void setup(){
  size(600, 600);
  
  //number of entities on screen
  int preyNumber = 100;
  int predNumber = 3;
  
  
  for(int i=0; i<preyNumber; i++){
    Prey newPrey = new Prey(new PVector(random(0, height), random(0, width))); //passing random location val
    prey.add(newPrey);
    println("Adding prey number: "+(i+1));
  }
  
}

/** Draws Frames */
void draw(){
  //fill(255, 249, 240, 90);
}
