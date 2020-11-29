import 'package:flutter/material.dart';

class PopMenuButton extends StatefulWidget {
  final List listagem;
  final void Function(String) onSubmit;

  const PopMenuButton(this.listagem , this.onSubmit , {Key key } ) : super(key : key);

  @override
  _PopMenuButtonState createState() => _PopMenuButtonState();
}

class _PopMenuButtonState extends State<PopMenuButton> {

  @override
  Widget build(BuildContext context) {

    final List<Map<String,dynamic>> listagem = widget.listagem;

    return PopupMenuButton<String>(
      onSelected: (value) => widget.onSubmit( value.toString() ),

      itemBuilder: (BuildContext context){
        return <PopupMenuEntry<String>>[
          ...listagem.map( (tr){
            return PopupMenuItem(
              value: tr['valor'].toString(),
              child: Row(
                children: [
                  Icon( tr['icone'] ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text(tr['label'] ),
                ],
              ),
            );
          })
        ];
      },
    );
  }
}

