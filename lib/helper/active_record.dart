import 'database.dart';

class ActiveRecord{
  final dbHelper = DatabaseHelper.instance;
  final String tabela = "arquivos";

  // CRUD - INICIO
  Future<void> insert( json ) async {
    return await dbHelper.insert( tabela , json  );
  }

  inserirLista( lista ){

    var linha = Map<String,dynamic>();

    for(int i=0; i< lista.length ; i++){
      linha.clear();
      linha['acao'] = 'I';
      linha['origem'] = lista[i].toString();
      this.insert(linha);
    }
  }

  colar( lista ){

  }
}