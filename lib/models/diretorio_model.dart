import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:galeria/models/regex_model.dart';
import 'item_model.dart';

class DiretorioModel{

  getPath() {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS
        //ExtStorage.DIRECTORY_PICTURES
    );
  }


  buscarArquivosTodos(Directory dir){

    List<ItemModel> _lista = [];

    RegexModel _regex = new RegexModel();
    List<RegexModel> _listaRegex = _regex.buscarLista;

    dir.list().forEach(( element ) async {

      for (int r = 0; r < _listaRegex.length; r++) {

        RegExp regExp = new RegExp(_listaRegex[r].alvo, caseSensitive: false);

        if (regExp.hasMatch(element.toString())) {

          var nomeArquivoArray = new List();
          nomeArquivoArray = element.toString().split("/");
          String nomearquivo = nomeArquivoArray.last.toString().replaceAll("'", "");
          ItemModel item = new ItemModel(
            tipo: _listaRegex[r].nome,
            nome: nomearquivo,
            caminhoCompleto: element.toString(),
            file: element ,
            objeto: element ,
          );
          _lista.add(item);
          break;
        }
      }
    });
    return _lista;
  }
}