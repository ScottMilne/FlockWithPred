class Prey {
  
  PVector acceleration;
  PVector velocity;
  PVector location;
  
  Prey(float x, float y){
    acceleration = new PVector();
    velocity = new PVector();
    location = new PVector();
    
  }
  
  void show(){
    strokeWeight(16);
    stroke(255);
    point(location.x, location.y);
    
  }
}
