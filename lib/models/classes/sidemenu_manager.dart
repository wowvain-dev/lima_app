import 'package:stack/stack.dart';

enum Subject {
  romana, 
  engleza, 
  aritmetica, 
  geometrie,
  logica,
  economie, 
}


class SideMenuManager {
  Subject? _chosenSubject;
  Stack<Subject> navHistory = Stack();

  Subject? get subject {
    return _chosenSubject;
  }
  
  set currentSubject (Subject a) {
    navHistory.push(a);
    _chosenSubject = a;
  }

  Subject? pop() {
    navHistory.pop();
    if (navHistory.isNotEmpty) {
      _chosenSubject = navHistory.top();
    } else {
      _chosenSubject = null;
    }
    return _chosenSubject;
  }

  clearChoice() {
    while(navHistory.isNotEmpty) {
      navHistory.pop();
    }
    _chosenSubject = null;
  } 
}