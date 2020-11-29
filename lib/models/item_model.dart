import 'dart:io';
import '../models/imagem_model.dart';


class ItemModel{
  String tipo;
  String nome;
  Directory caminhoCompleto;
  String caminhoCompletoTruncado;
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
    this.caminhoCompletoTruncado,
    this.tamanho,
    this.length,
    this.imagem,
    this.file,
    this.function,
    this.objeto,
    this.selecionado = false,
  });

  @override
  String toString() {
    return '{caminhoTruncado: $caminhoCompletoTruncado}';
  }
}