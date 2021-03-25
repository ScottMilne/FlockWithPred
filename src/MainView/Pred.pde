class Pred extends Prey {

  Pred() {
      maxspeed = 2;
  }
  
  //renders pred shape and colour
  void render() {
      // Draw a triangle rotated in the direction of velocity
      float theta = velocity.heading() + radians(90);
  
      fill(255, 0, 0);
      stroke(0);
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      beginShape(TRIANGLES);
      vertex(0, -r * 2);
      vertex(-r, r * 2);
      vertex(r, r * 2);
      endShape();
      popMatrix();
  }
  
  //returns current position of pred
  PVector getPosition() {
      return position;
  }

}
