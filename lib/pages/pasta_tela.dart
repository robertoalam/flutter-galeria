import 'package:flutter/material.dart';
import '../models/permissao_model.dart';
import '../models/armazenamento_model.dart';
import '../models/item_model.dart';

class PastaTela extends StatefulWidget {

  final String caminhoPesquisar;

  PastaTela({this.caminhoPesquisar});

  @override
  _PastaTelaState createState() => _PastaTelaState();
}

class _PastaTelaState extends State<PastaTela> {

  Future _caminhoDiretorio;
  List<ItemModel> _listaItens = List<ItemModel>();
  var _permissionStatus;
  ArmazenamentoModel _armazenamento = new ArmazenamentoModel();

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    _caminhoDiretorio = _armazenamento.buscarCaminho(widget.caminhoPesquisar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Folder"),
      ),
    );
  }

  void _listenForPermissionStatus() async {
    final status = await PermissaoModel.getStatus();
    setState(() => _permissionStatus = status);
  }
}
