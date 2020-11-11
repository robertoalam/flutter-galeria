import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:galeria/models/regex_model.dart';
import 'item_model.dart';

class DiretorioModel{

  getPath() async {
    return await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS
        //ExtStorage.DIRECTORY_PICTURES
    );
  }

  buscarCaminho(diretorio) async{
    if(diretorio.toString().length == 0){
      return await
        ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_PICTURES
        );
    }else{
      return await
        ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_PICTURES+"/"+diretorio
        );
    }
  }

  Future<List> buscarArquivosTodos(Directory dir) async{

    List<ItemModel> _lista = List<ItemModel>();

    RegexModel _regex = new RegexModel();
    List<RegexModel> _listaRegex = _regex.buscarLista;

    await dir.list().forEach(( element ) {

      for (int r = 0; r < _listaRegex.length; r++) {
        RegExp regExp = new RegExp(_listaRegex[r].alvo, caseSensitive: false);

        if (regExp.hasMatch(element.toString())) {

          var nomeArquivoArray = new List();
          nomeArquivoArray = element.toString().split("/");
          String nomearquivo = nomeArquivoArray.last.toString().replaceAll("'", "");

          ItemModel _item;

          if(_listaRegex[r].nome.toString() == "imagem"){
            _item = new ItemModel(
              tipo: _listaRegex[r].nome,
              nome: nomearquivo,
              caminhoCompleto: element.toString(),
              file: element ,
              objeto: element ,
            );
          }else{
            _item = new ItemModel(
              tipo: _listaRegex[r].nome,
              nome: nomearquivo,
              caminhoCompleto: element.toString(),
              objeto: element ,
            );
          }
          _lista.add(_item);
          break;
        }
      }
    });
    return _lista;
  }
}