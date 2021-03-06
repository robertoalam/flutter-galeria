import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:galeria/models/regex_model.dart';
import 'package:path_provider/path_provider.dart';
import 'item_model.dart';

class DiretorioModel{

  getPath() async {
    return await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS
        //ExtStorage.DIRECTORY_PICTURES
    );
  }

  buscarCaminho(diretorio) async{
    if( (diretorio.toString().length == 0) || (diretorio == null) || diretorio == "Pictures"){
      return await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_PICTURES
      );
    }else{
      return await ExtStorage.getExternalStoragePublicDirectory(
          diretorio
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
          int posicaoAspas = element.toString().indexOf("'");
          String caminhoCompletoTruncado = element.toString().substring(posicaoAspas+1,element.toString().length-1);

          _item = new ItemModel();

          if(_listaRegex[r].nome.toString() == "pasta") {

            _item.tipo = _listaRegex[r].nome;
            _item.nome = nomearquivo;
            _item.caminhoCompleto = element;
            _item.caminhoCompletoTruncado = caminhoCompletoTruncado;
            _item.objeto = element;

          }else if(_listaRegex[r].nome.toString() == "imagem"){
            _item.tipo = _listaRegex[r].nome;
            _item.nome = nomearquivo;
            _item.caminhoCompletoTruncado = caminhoCompletoTruncado;
            _item.file = element;
            _item.objeto = element;
          }else{
            _item.tipo = _listaRegex[r].nome;
            _item.nome = nomearquivo;
            _item.caminhoCompletoTruncado = caminhoCompletoTruncado;
            _item.objeto = element;
          }
          _lista.add(_item);
          break;
        }
      }
    });
    return _lista;
  }

  criarNovaPasta(String folderName) async {
    Map<String,dynamic> retorno = Map();
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    //final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/$folderName/');
    final Directory _appDocDirFolder =  Directory('$folderName/');

    //if folder already exists return path
    if(await _appDocDirFolder.exists()){
      retorno['status'] = false;
      retorno['objeto'] = _appDocDirFolder.path;
      //return _appDocDirFolder.path;
      //if folder not exists create folder and then return its path
    }else{
      final Directory _appDocDirNewFolder= await _appDocDirFolder.create(recursive: true);
      //return _appDocDirNewFolder.path;
      retorno['status'] = true;
      retorno['objeto'] = _appDocDirNewFolder;
    }
    return retorno;
  }


}