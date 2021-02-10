class Prey {
  
  PVector acceleration = new PVector();
  PVector velocity = new PVector();
  PVector location; //randomly set via constructor
  
  Prey(PVector l){
    location = l;
  }
}
