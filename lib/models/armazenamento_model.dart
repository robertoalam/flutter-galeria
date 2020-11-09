import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import '../models/imagem_model.dart';
import '../models/item_model.dart';
import '../models/pasta_model.dart';

class ArmazenamentoModel {

  List<ItemModel> _lista = new List<ItemModel>();

  Future<String> buscarCaminho(diretorio) {
    if(diretorio.toString() == ""){
      return
        ExtStorage.getExternalStoragePublicDirectory(
            //ExtStorage.DIRECTORY_DOWNLOADS
            ExtStorage.DIRECTORY_PICTURES
          //ExtStorage.DIRECTORY_PICTURES+"/"+diretorio
        );
    }else{
      return
        ExtStorage.getExternalStoragePublicDirectory( diretorio );
    }

  }

  buscarItens(Directory dir) {
    _lista = [];
    _lista = buscarPastas(dir);
    _lista += buscarImagens(dir);
    return _lista;
  }

  buscarPastas(Directory dir){
    dir.list().forEach((element) async {
      RegExp regExp = new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp)", caseSensitive: false);
      // Only add in List if path is an image
      if (!regExp.hasMatch('$element')) {
        var nomeArquivoArray = new List();
        nomeArquivoArray = element.toString().split("/");
        String nomearquivo = nomeArquivoArray.last.toString().replaceAll("'", "");
        PastaModel _objeto = new PastaModel(nome: nomearquivo);
        ItemModel item = new ItemModel(tipo: "pasta",nome: nomearquivo,caminhoCompleto: element.toString(),pasta: _objeto);
        _lista.add(item);
      }

    });

    return _lista;
  }

  buscarImagens(Directory dir){

    dir.list().forEach((element) {
      RegExp regExp = new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) {

        var nomeArquivoArray = new List();
        nomeArquivoArray = element.toString().split("/");
        String nomearquivo = nomeArquivoArray.last.toString().replaceAll("'","");
        ImagemModel _objeto = new ImagemModel(nome: nomearquivo);
        ItemModel item = new ItemModel(tipo: "imagem" , nome:nomearquivo , caminhoCompleto: element.toString() , imagem: _objeto , file: element);
        _lista.add(item);
        //listImage.add(element);
      }
    });
    return _lista;
  }
}