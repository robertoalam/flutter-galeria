import 'dart:async';

class MeuBlocModel {

  int total = 0;
  bool flag;

  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  contador(flag){
    if(flag){
      total++;
    }else{
      total--;
    }
    input.add(total);
  }

}