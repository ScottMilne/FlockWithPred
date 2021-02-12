
ArrayList<Pred> pred = new ArrayList(); //all predators



School school;

/** Loads app */
void setup(){
  size(600, 600);
  
  //number of entities on screen
  int preyNumber = 100;
  int predNumber = 3;
  
  school = new School();
  
  for(int i=0; i< preyNumber; i++){
    school.addNew(new Prey(width/2, height/2));
  }
  
}

/** Draws Frames */
void draw(){
  //background(255, 204, 0);

}
