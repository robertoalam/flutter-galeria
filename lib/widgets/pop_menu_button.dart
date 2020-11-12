import 'package:flutter/material.dart';

//enum MenuOption{ NewFolder , Send, Draft , Discar }

class PopMenuButton extends StatefulWidget {

  final void Function(String) onSubmit;

  const PopMenuButton(this.onSubmit , {Key key } ) : super(key : key);

  @override
  _PopMenuButtonState createState() => _PopMenuButtonState();
}

class _PopMenuButtonState extends State<PopMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => widget.onSubmit( value.toString() ),

      itemBuilder: (BuildContext context){
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
              value: "nova-pasta",
              child: Row(
                children: [
                  Icon(Icons.create_new_folder , color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Novo"),
                ],
              )
          ),
          PopupMenuItem(
              value: "visualizar",
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye , color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Visualizar"),
                ],
              )
          ),
          PopupMenuItem(
              value: "atualizar",
              child: Row(
                children: [
                  Icon(Icons.refresh , color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Atualizar"),
                ],
              )
          ),
        ];
      },
    );
  }
}

