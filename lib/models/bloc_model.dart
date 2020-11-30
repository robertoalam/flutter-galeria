import 'dart:async';

class MeuBlocModel {

  int total = 0;
  bool flag;
  bool flagAcaoPendente = false;
  bool flagExibirBarraNavigation = false;

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
    if( (flagAcaoPendente) && (total>0)){
      exibirBarraSet(true);
    }else if( (flagAcaoPendente) && (total <= 0) ){
      exibirBarraSet(true);
    }else if( (!flagAcaoPendente) && (total>0) ){
      exibirBarraSet(true);
    }else if( (!flagAcaoPendente) && (total<=0) ){
      exibirBarraSet(false);
    }else {
      exibirBarraSet(false);
    }

    input.add(total);
  }

  exibirBarraSet(bool flag){
    flagExibirBarraNavigation = flag;
    input.add(flagExibirBarraNavigation);
  }

  acaoPendenteSet(bool flag){
    flagAcaoPendente = flag;
    input.add(flagAcaoPendente);
  }

}