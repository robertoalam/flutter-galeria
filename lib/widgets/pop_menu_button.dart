import 'package:flutter/material.dart';

enum MenuOption{ Send , Draft , Discar }

class PopMenuButton extends StatelessWidget {

  const PopMenuButton({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      itemBuilder: (BuildContext context){
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
              value: MenuOption.Send,
              child: Row(
                children: [
                  Icon(Icons.add , color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Novo"),
                ],
              )
          ),
          PopupMenuItem(
              value: MenuOption.Send,
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye , color: Colors.black,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Visualizar"),
                ],
              )
          ),
          PopupMenuItem(
              value: MenuOption.Send,
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
