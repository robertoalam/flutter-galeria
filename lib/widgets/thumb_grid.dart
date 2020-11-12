import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../pages/pasta_tela.dart';

class thumbGrid extends StatefulWidget {

  final BuildContext context;
  final ItemModel objeto;

  thumbGrid({this.context, this.objeto});

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

    return InkWell(
      onTap: () => Navigator.push( context,  MaterialPageRoute( builder: (context) => PastaTela( itemModel: widget.objeto, ) ) ),
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
  _marcar( selecionar ){
    _selecionado = (selecionar) ? true : false ;
    setState(() {
      _selecionado = true;
    });
  }

  _inverter(){
    setState(() {
      _selecionado = !_selecionado;
    });
  }
}
