import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galeria/widgets/thumb_grid.dart';
import 'package:galeria/widgets/thumb_list.dart';
import '../models/configuracao_model.dart';
import '../models/diretorio_model.dart';
import '../models/permissao_model.dart';
import '../models/item_model.dart';

class PastaTela extends StatefulWidget {

  final ItemModel itemModel;
  PastaTela({this.itemModel});

  @override
  _PastaTelaState createState() => _PastaTelaState();
}

class _PastaTelaState extends State<PastaTela> {

  var _permissionStatus;
  String _caminhoDiretorio;
  DiretorioModel _diretorio = new DiretorioModel();
  List<ItemModel> _listaItens = List<ItemModel>();

  ConfiguracaoModel _config = new ConfiguracaoModel();
  String _visualizacao;
  int _visualizacaoCrossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    _config.getConfiguracoes().then( (list) {
      _visualizacao = list['ds_view'];
      //_visualizacao = "list";
      _visualizacaoCrossAxisCount = int.parse( list['no_view'] );
      _buscarArquivos();
    });

  }

  _buscarArquivos() async {
    await _listenForPermissionStatus();
    if (_permissionStatus) {

      _caminhoDiretorio = await _diretorio.buscarCaminho( widget.itemModel.nome );

      if(_caminhoDiretorio != null){
        var dir = Directory( _caminhoDiretorio );
        _listaItens = await _diretorio.buscarArquivosTodos(dir);
        setState(() {
          _listaItens;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    var view ;
    if(_visualizacao == "grid"){
      view = Padding(
        padding: EdgeInsets.all(5) ,
        child: GridView.count(
            crossAxisCount: _visualizacaoCrossAxisCount,
            children: List.generate( _listaItens.length , (index) {
              return thumbGrid( context: context , objeto: _listaItens[index] );
            })
        ),
      );
    }else if( _visualizacao == "list" ) {
      view = Padding(
        padding: EdgeInsets.all(5) ,
        child: ListView.builder(
          itemCount: _listaItens.length,
          itemBuilder: (context , index){
            return thumbList(context ,_listaItens[index]);
          },
        ),
      );
    }else{
      view = Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemModel.nome),
      ),
      body: (_listaItens != null)
          ?
      view
          :
      Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _listenForPermissionStatus() async {
    final status = await PermissaoModel.getStatus();
    setState(() => _permissionStatus = status);
  }
}
