import 'package:sqflite/sqflite.dart';

import '../helper/database.dart';

class ConfiguracaoModel{

  final dbHelper = DatabaseHelper.instance;
  final String tabela = "configuracao";
  List json;
  // CRUD - INICIO
  Future<void> insert( json ) async {
    return await dbHelper.insert( tabela , json  );
  }

  Map<String, dynamic> toMap() {
    return {

    };
  }

  Future udpate() async {
    var map = this.toMap;
    return await dbHelper.update( tabela , " _id " , this.toMap() );
  }

  getConfiguracoes() async {
    Map<String,dynamic> retorno = Map();
    List<Map<String,dynamic>> maps = await dbHelper.queryAllRows(tabela);
    maps.forEach( (elemento) {
      String chave = elemento['chave'];
      String valor = elemento['valor'];
      retorno['$chave'] = valor;
    });
    return retorno;
  }

  aberturaIncrementar() async {
    String query = "UPDATE configuracao SET valor = valor + 1 WHERE chave = 'no_aberturas' ;";
    return await dbHelper.executar( query );
  }



  buscarTudo() async {
    final linhas = await dbHelper.queryAllRows( tabela );
    List lista;
    for(int i=0;i< linhas.length ; i++){
      lista.add(linhas);
    }
    return lista;
  }

  buscarTudo2() async {
    final linhas = await dbHelper.queryCustom( "SELECT * FROM configuracao" );
    return linhas;
  }
}