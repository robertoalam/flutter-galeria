import 'dart:async';

class MeuBlocModel {

  int total = 0;
  bool flag;
  bool exibirBarraOpcoes = false;

  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  zerar(){
    total = 0;
    input.add(total);
  }

  contador(flag){
    if(flag){
      total++;
    }else{
      total--;
    }
    exibirBarra();
    input.add(total);
  }

  exibirBarra(){
    if(total <= 0){
      exibirBarraOpcoes = false;
      input.add(exibirBarraOpcoes);
    }else{
      exibirBarraOpcoes = true;
      input.add(exibirBarraOpcoes);
    }
  }

}