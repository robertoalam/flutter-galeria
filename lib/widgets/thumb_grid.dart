import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../pages/pasta_tela.dart';

Widget thumbGrid(BuildContext context, ItemModel objeto) {
  var thumbIcone;
  if(objeto.tipo == "pasta") {
    thumbIcone = Image(image:AssetImage("assets/imagens/pasta.png"),height: 65,);
  }else if(objeto.tipo == "imagem"){
    thumbIcone = Image.file(objeto.file, height: 65,);
  }else if(objeto.tipo == "video"){
    thumbIcone =  Image(image:AssetImage("assets/imagens/video.png"),height: 65,);
  }else if(objeto.tipo == "txt"){
    thumbIcone =  Image(image:AssetImage("assets/imagens/txt.png"),height: 65,);
  }else if(objeto.tipo == "pdf"){
    thumbIcone =  Image(image:AssetImage("assets/imagens/pdf.png"),height: 65,);
  }else{
    thumbIcone = Image(image:AssetImage("assets/imagens/unknow.png"),height: 65,);
  }

  return InkWell(
    onTap: () => Navigator.push( context,  MaterialPageRoute( builder: (context) => PastaTela( itemModel: objeto, ) ) ),
    onLongPress: () => print('segurando'),
    child: Container(
      height: 250,
      child: Column(
        children: [
          thumbIcone,
          Text(objeto.nome, overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
  );
}