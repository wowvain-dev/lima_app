enum Subject {
  romana, 
  engleza, 
  aritmetica, 
  geometrie,
  logica,
  economie, 
}

Subject? _chosenSubject;

class SideMenuManager {

  Subject? get subject {
    return _chosenSubject;
  }
  
  void set currentSubject (Subject a) {
    _chosenSubject = a;
  }

  clearChoice() {
    _chosenSubject = null;
  } 
}