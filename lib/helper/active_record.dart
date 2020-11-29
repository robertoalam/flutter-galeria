import 'database.dart';

class ActiveRecord{
  final dbHelper = DatabaseHelper.instance;
  final String tabela = "arquivos";

  // CRUD - INICIO
  Future<void> insert( json ) async {
    return await dbHelper.insert( tabela , json  );
  }

  inserirLista( lista ){
    for(int i=0; i< lista.length ; i++){
      this.insert(lista[i]);
    }
  }
}