import 'package:flutter/material.dart';
import '../pages/pasta_tela.dart';
import '../models/item_model.dart';

List<Widget> thumbs(BuildContext context , List<ItemModel> listagem) {
  List<Widget> lista = List<Widget>();
  for (var objeto in listagem) {
    if(objeto.tipo == "pasta"){
      lista.add(
        InkWell(
          onTap: () => Navigator.push( context , MaterialPageRoute( builder: (context) => PastaTela(caminhoPesquisar: objeto.caminhoCompleto) ) ),
          child:Container(
            height: 250,
            child: Column(
              children: [
                Image(image: AssetImage("imagens/pasta.png"), height: 65,),
                Text(objeto.nome, overflow: TextOverflow.ellipsis,),
              ],
            ),
          ) ,
        )

      );
    }else{
        lista.add(
          Container(
            height: 250,
            child: Column(
              children: [
                Image.file(objeto.file, height: 65,),
                Text(objeto.nome, overflow: TextOverflow.ellipsis,),
              ],
            ),
          )
        );
    }
  }
  return lista;
}