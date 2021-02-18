class Hunters{
  ArrayList<Prey> pred;
  
  Hunters(){
    pred = new ArrayList<Prey>();
  }
  
  void addNew(Prey newPred){
    pred.add(newPred);
  }
  
  void run(){
    for(Prey p: pred){
      p.run(pred);
    }
  
  }
  
}
