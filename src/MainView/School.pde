class School{
  ArrayList<Prey> prey;
  
  School(){
    prey = new ArrayList<Prey>();
  }
  
  void addNew(Prey newPrey){
    prey.add(newPrey);
  }
  
  void run(){
    for(Prey p: prey){
      p.run(prey);
    }
  
  }
  
}
