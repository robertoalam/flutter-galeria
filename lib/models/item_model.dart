import 'dart:io';
import '../models/imagem_model.dart';
import '../models/pasta_model.dart';


class ItemModel{
  String tipo;
  String nome;
  Directory caminhoCompleto;
  int tamanho;
  int length;
  ImagemModel imagem;
  File file;
  Function function;
  dynamic objeto;
  bool selecionado;
  // TIPOS
  // [ imagem / pdf / txt / doc / video/ unknow / pasta ]

  ItemModel({
    this.tipo,
    this.nome,
    this.caminhoCompleto,
    this.tamanho,
    this.length,
    this.imagem,
    this.file,
    this.function,
    this.objeto,
    this.selecionado = false,
  });

}