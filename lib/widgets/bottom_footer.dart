import 'package:flutter/material.dart';
import 'package:galeria/models/bloc_model.dart';

class BottomFooter extends StatefulWidget {

  List listagem;
  MeuBlocModel bloc = MeuBlocModel();
  final void Function(String) onSubmit;

  BottomFooter({this.listagem, this.bloc ,  this.onSubmit});

  @override
  _BottomFooterState createState() => _BottomFooterState();
}

class _BottomFooterState extends State<BottomFooter> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3 ,
      child: Visibility(
        visible: widget.bloc.flagExibirBarraNavigation,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ...widget.listagem.map( (e) {
                return GestureDetector(
                  onTap: () => widget.onSubmit(e['valor'] ),
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(e['icone'] , color: Colors.white , size: 26, ),
                        Text(e['label'] ,style: TextStyle(color: Colors.white ) , ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              // Container(
              //   width: 80,
              //   padding: EdgeInsets.all(5),
              //   decoration: new BoxDecoration(
              //     borderRadius: new BorderRadius.circular(16.0),
              //     color: Colors.green,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.copy , color: Colors.white , size: 26, ),
              //       Text("Copiar" ,style: TextStyle(color: Colors.white ) , ),
              //     ],
              //   ),
              // ),
              //
              // Container(
              //   width: 80,
              //   padding: EdgeInsets.all(5),
              //   decoration: new BoxDecoration(
              //     borderRadius: new BorderRadius.circular(16.0),
              //     color: Colors.green,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.cut , color: Colors.white , size: 26, ),
              //       Text("Recortar" ,style: TextStyle(color: Colors.white ) , ),
              //     ],
              //   ),
              // ),
              //
              // Container(
              //   width: 80,
              //   padding: EdgeInsets.all(5),
              //   decoration: new BoxDecoration(
              //     borderRadius: new BorderRadius.circular(16.0),
              //     color: Colors.green,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.delete , color: Colors.white , size: 26, ),
              //       Text("Deletar" ,style: TextStyle(color: Colors.white ) , ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
