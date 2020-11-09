import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/permissao_model.dart';
import '../widgets/thumbs.dart';
import '../widgets/pop_menu_button.dart';
import '../models/armazenamento_model.dart';
import '../models/item_model.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  Future _caminhoDiretorio;
  List<ItemModel> _listaItens = List<ItemModel>();
  var _permissionStatus;
  ArmazenamentoModel _armazenamento = new ArmazenamentoModel();

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    _caminhoDiretorio = _armazenamento.buscarCaminho("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          PopMenuButton(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _caminhoDiretorio,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  if (_permissionStatus) {
                    pesquisarItens(dir);
                  }
                  return Text(snapshot.data);
                } else {
                  return Text("Loading");
                }
              },
            ),
          ),
          Expanded(
            flex: 19,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: thumbs(context , _listaItens),
            ),
          ),

        ],
      ),
    );
  }

  pesquisarItens(diretorio) {
    _listaItens = [];
    _listaItens = _armazenamento.buscarItens(diretorio);
  }

  void _listenForPermissionStatus() async {
    final status = await PermissaoModel.getStatus();
    setState(() => _permissionStatus = status);
  }

}


