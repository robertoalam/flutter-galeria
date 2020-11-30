import 'package:flutter/material.dart';
import 'package:galeria/models/bloc_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/item_model.dart';
import '../pages/pasta_tela.dart';

class thumbGrid extends StatefulWidget {

  final BuildContext context;
  final ItemModel objeto;
  MeuBlocModel bloc = MeuBlocModel();

  thumbGrid({this.context , this.objeto , this.bloc});

  @override
  _thumbGridState createState() => _thumbGridState();
}

class _thumbGridState extends State<thumbGrid> {

  var thumbIcone;
  var _selecionado = false;

  @override
  Widget build(BuildContext context) {

    if(widget.objeto.tipo == "pasta") {
      thumbIcone = Image(image:AssetImage("assets/imagens/pasta.png"),height: 65,);
    }else if(widget.objeto.tipo == "imagem"){
      thumbIcone = Image.file(widget.objeto.file, height: 65,);
    }else if(widget.objeto.tipo == "video"){
      thumbIcone =  Image(image:AssetImage("assets/imagens/video.png"),height: 65,);
    }else if(widget.objeto.tipo == "txt"){
      thumbIcone =  Image(image:AssetImage("assets/imagens/txt.png"),height: 65,);
    }else if(widget.objeto.tipo == "pdf"){
      thumbIcone =  Image(image:AssetImage("assets/imagens/pdf.png"),height: 65,);
    }else{
      thumbIcone = Image(image:AssetImage("assets/imagens/unknow.png"),height: 65,);
    }

    return GestureDetector(
      onTap: () => _navegar() ,
      onLongPress: () => _inverter() ,
      child: Container(
        padding:EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: ( _selecionado ) ? Colors.green : Colors.white ,
        ),
        height: 250,
        child: Column(
          children: [
            thumbIcone,
            Text(widget.objeto.nome, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }

  _navegar(){
    if(widget.objeto.tipo == "pasta") {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          PastaTela(directory: widget.objeto.caminhoCompleto,barraNavigation: widget.bloc.flagExibirBarraNavigation,)));
    }else{
      launch(widget.objeto.file.toString());
    }
  }

  _inverter(){
    setState(() {
      _selecionado = !_selecionado;
      widget.objeto.selecionado = _selecionado;
      widget.bloc.contador(_selecionado);
    });

  }
}
