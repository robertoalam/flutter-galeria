import 'package:flutter/material.dart';
import '../models/item_model.dart';

Widget thumbList(BuildContext context , ItemModel objeto) {
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

  if( objeto.tipo != "imagem" ){
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
          vertical: 8 , horizontal: 5
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FittedBox(
                child: thumbIcone,
              ),
            ),
          ),
          title: Text( objeto.nome ),
        ),
      ),
    );
  }else{
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
          vertical: 8 , horizontal: 5
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: thumbIcone ,
          title: Text( objeto.nome ),
        ),
      ),
    );
  }


}
