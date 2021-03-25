class Prey {

  PVector acceleration;
  PVector velocity;
  PVector position;
  float r;
  float maxforce;
  float maxspeed;
  float mass = 3.4;

  Prey() {
      acceleration = new PVector(0, 0);
      velocity = PVector.random2D();

      float angle = random(TWO_PI);
      velocity = new PVector(cos(angle), sin(angle));

      position = new PVector(random(width), random(height));
      r = 2.0;
      maxspeed = 2.5;
      maxforce = 0.03;
  }

  //updates all forces
  void update() {
      velocity.add(acceleration); //updating velocity
      velocity.limit(maxspeed); //limit speed
      position.add(velocity); //updating position
      acceleration.mult(0); //resetting acceleration to 0
  }

  //creates screen wrap around
  void borders() {
      if (position.x < -r) position.x = width + r;
      if (position.y < -r) position.y = height + r;
      if (position.x > width + r) position.x = -r;
      if (position.y > height + r) position.y = -r;
  }

  //renders prey shape and colour
  void render() {
      float theta = velocity.heading() + radians(90); //draws triangle to face velocity direction

      fill(255); //colour white
      stroke(255); //border white

      //transforming shape
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

  //launches all force checks and needed updaters
  void run(ArrayList < Prey > prey) {
      flock(prey);
      update();
      borders();
      render();
  }

  //launches the three rules
  void flock(ArrayList < Prey > prey) {
      PVector sep = separate(prey); // Separation
      PVector ali = align(prey); // Alignment
      PVector coh = cohesion(prey); // Cohesion

      //weights for forces
      sep.mult(2.0);
      ali.mult(1.0);
      coh.mult(1.0);

      //adding the force vectors to acceleration
      applyForce(sep);
      applyForce(ali);
      applyForce(coh);
  }

  //adds force to acceleration
  void applyForce(PVector force) {
      acceleration.add(force);
  }

  //keeps Boids seperate
  PVector separate(ArrayList < Prey > prey) {
      float desiredseparation = 25.0f;
      PVector steer = new PVector(0, 0, 0);
      int count = 0;

      //checking for neighbors
      for (Prey other: prey) {
          float d = PVector.dist(position, other.position); //distance from other Boid

          //if distance greater than 0 and less disired amount
          if ((d > 0) && (d < desiredseparation)) {

              //calculating vector pointing away from Boid
              PVector diff = PVector.sub(position, other.position);
              diff.normalize();
              diff.div(d);
              steer.add(diff);
              count++; //counting how many are too close
          }
      }

      // Average -- divide by how many
      if (count > 0) {
          steer.div((float) count);
      }

      //as long as the vector is greater than 0
      if (steer.mag() > 0) {
          steer.setMag(maxspeed);
          steer.sub(velocity);
          steer.limit(maxforce);
      }
      return steer;
  }


  //Makes Boids face the same way
  PVector align(ArrayList < Prey > prey) {
      float neighbordist = 50; //field of vision
      PVector sum = new PVector(0, 0);
      int count = 0;

      //checking for neighbors
      for (Prey other: prey) {
          float d = PVector.dist(position, other.position); //distance from other Boid

          //if within vision
          if ((d > 0) && (d < neighbordist)) {
              sum.add(other.velocity);
              count++; //counting neighbors
          }
      }
      if (count > 0) {
          sum.div((float) count);
          sum.setMag(maxspeed);
          PVector steer = PVector.sub(sum, velocity);
          steer.limit(maxforce);
          return steer; //aligned steer force
      } else {
          return new PVector(0, 0); //no neighbors
      }
  }

  //Gets central point of neighboring Boids
  PVector cohesion(ArrayList < Prey > prey) {
      float neighbordist = 70; //field of vision
      PVector sum = new PVector(0, 0);
      int count = 0;

      //checking for neighbors
      for (Prey other: prey) {
          float d = PVector.dist(position, other.position); //distance from other Boid

          //if within vision
          if ((d > 0) && (d < neighbordist)) {
              sum.add(other.position); // Add position
              count++;
          }
      }
      if (count > 0) {
          sum.div(count);
          return seek(sum); //steer towards the position
      } else {
          return new PVector(0, 0); //no neighbors
      }
  }

  //finds path from one position to another
  PVector seek(PVector target) {
      PVector desired = PVector.sub(target, position); //vector pointing from the central target to the Boids current position 

      //makes Boid move to target at max speed
      desired.setMag(maxspeed);

      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce); //limit to maximum steering force
      return steer;
  }

  //repels the prey from an obstacle
  void repelForce(PVector obstacle, float radius) {
      PVector futPos = PVector.add(position, velocity); //future position
      PVector dist = PVector.sub(obstacle, futPos); //distance from pred
      float d = dist.mag();

      //if distance is too close
      if (d <= radius) {
          PVector repelVec = PVector.sub(position, obstacle);
          repelVec.normalize();
          if (d != 0) {
              //adding repel force
              repelVec.normalize();
              repelVec.mult(maxforce * 15);
              if (repelVec.mag() < 0) {
                  //doesnt let boid turn around to avoid obstacle
                  repelVec.y = 0;
              }
          }
          applyF(repelVec); //applying repel force
      }
  }

  //applies the repel force to acceleration 
  void applyF(PVector force) {
      //F=ma
      force.div(mass);
      acceleration.add(force);
  }
    
}
