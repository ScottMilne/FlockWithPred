
ArrayList<Pred> pred = new ArrayList(); //all predators
ArrayList<Prey> prey = new ArrayList<Prey>();


School school;
Hunters hunters;

/** Loads app */
void setup(){
  size(1000, 600);
  
  //number of entities on screen
  int preyNumber = 100;
  int predNumber = 5;
  
  school = new School();
  hunters = new Hunters();
  
  for(int i=0; i< preyNumber; i++){
    prey.add(new Prey(width/2, height/2));
  }
  
 for(int i=0; i< predNumber; i++){
    pred.add(new Pred(width/2, height/2));
  }
  
}

/** Draws Frames */
void draw(){
  background(0, 111, 145);
  
  for(Prey p: prey){
        for (Pred predator: pred) { 
        PVector predBoid = predator.getPosition();
        p.repelForce(predBoid, 60);
      }
      p.run(prey);
    }
  
  
    for (Prey p: pred) {
    p.run(prey); //makes preds act as prey thus chasing them
  }
  hunters.run();
}
