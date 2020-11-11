import 'dart:io';
import 'package:ext_storage/ext_storage.dart';
import 'package:galeria/models/regex_model.dart';
import '../models/item_model.dart';

class ArmazenamentoModel {

  List<ItemModel> _lista = new List<ItemModel>();

  buscarCaminho(diretorio) {
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
}