import 'package:flutter/material.dart';

class ModalAdicionarNovaPasta extends StatefulWidget {
  @override
  _ModalAdicionarNovaPastaState createState() => _ModalAdicionarNovaPastaState();
}

class _ModalAdicionarNovaPastaState extends State<ModalAdicionarNovaPasta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(7),
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text("Criar Pasta" ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  //controller: _nomeNovaPastaController,
                  decoration: InputDecoration(
                      labelText: "Nova Pasta"
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      onPressed: () {} ,
                      child: Text("Cancelar"),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                    ),
                    Padding(
                        padding: EdgeInsets.all(5) ,
                        child: RaisedButton(
                          onPressed: () {} ,
                          child: Text("OK"),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).textTheme.button.color,
                        ),
                    ),

                  ],
                ) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
