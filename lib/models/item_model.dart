import 'dart:io';
import '../models/imagem_model.dart';
import '../models/pasta_model.dart';


class ItemModel{
  String tipo;
  String nome;
  String caminhoCompleto;
  int tamanho;
  int length;
  PastaModel pasta;
  ImagemModel imagem;
  File file;
  Function function;
  dynamic objeto;

  // TIPOS
  // [ imagem / pdf / txt / doc / video/ unknow / pasta ]

  ItemModel({
    this.tipo,
    this.nome,
    this.caminhoCompleto,
    this.tamanho,
    this.length,
    this.imagem,
    this.pasta,
    this.file,
    this.function,
    this.objeto,
  });

}