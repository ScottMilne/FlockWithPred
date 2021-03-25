ArrayList < Pred > pred = new ArrayList(); //all predators
ArrayList < Prey > prey = new ArrayList < Prey > ();

//sets up view and entities
void setup() {
    size(1200, 900);
    //fullScreen(1);
    //number of entities on screen
    int preyNumber = 400;
    int predNumber = 10;

    //Populating entities  
    for (int i = 0; i < preyNumber; i++) {
        prey.add(new Prey());
    }
    for (int i = 0; i < predNumber; i++) {
        pred.add(new Pred());
    }

}

//draws Boids
void draw() {
    background(0, 111, 145); //redrawing background

    for (Prey p: prey) {
        for (Pred predator: pred) {
            PVector predBoid = predator.getPosition();
            p.repelForce(predBoid, 60); //passing pred pos to prey
        }
        p.run(prey); //running flock behaviour
    }

    for (Prey p: pred) {
        p.run(prey); //makes preds attempt to flock with prey
    }
}
