import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/adicionar_nova_pasta_modal.dart';
import '../models/configuracao_model.dart';
import '../models/diretorio_model.dart';
import '../models/permissao_model.dart';
import '../widgets/pop_menu_button.dart';
import '../widgets/thumb_list.dart';
import '../widgets/thumb_grid.dart';
import '../models/item_model.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  var _permissionStatus;
  String _caminhoDiretorio;
  DiretorioModel _diretorio = new DiretorioModel();
  List<ItemModel> _listaItens = List<ItemModel>();

  ConfiguracaoModel _config = new ConfiguracaoModel();
  String _visualizacao;
  int _visualizacaoCrossAxisCount = 2;

  List<Widget> _bodyPage = new List<Widget>();
  Widget _bodyBottom ;

  @override
  void initState() {
    super.initState();

    _buscarArquivos();

    // _config.getConfiguracoes().then( (list) {
    //   _visualizacao = list['ds_view'];
    //   //_visualizacao = "list";
    //   _visualizacaoCrossAxisCount = int.parse( list['no_view'] );
    // });
  }


  _buscarArquivos() async {
    await _listenForPermissionStatus();
    if (_permissionStatus) {

      // busca arquivos de configuracao
      _config.getConfiguracoes().then( (list) async {

        // variaveis
        _visualizacao = list['ds_view'];
        //_visualizacao = "list";
        _visualizacaoCrossAxisCount = int.parse( list['no_view'] );


        _caminhoDiretorio = await _diretorio.buscarCaminho("");
        //_caminhoDiretorio = await _diretorio.getPath();

        if(_caminhoDiretorio != null){
          var dir = Directory( _caminhoDiretorio );
          _listaItens =  await _diretorio.buscarArquivosTodos(dir);
          setState(() {
            _listaItens;
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    _bodyPage.clear();

    if(_caminhoDiretorio != null ){
      _bodyPage.add(
          Expanded(
            flex: 1,
            child: Text(_caminhoDiretorio ),
          )
      );
    }

      if(_visualizacao != null && _visualizacao == "grid"){

        _bodyPage.add(
          Expanded(
            flex: 19,
            child: Padding(
              padding: EdgeInsets.all(5) ,
              child: GridView.count(
                  crossAxisCount: _visualizacaoCrossAxisCount,
                  children: List.generate( _listaItens.length , (index) {
                    return thumbGrid(context: context , objeto: _listaItens[index], );
                  })
              ),
            ) ,
          )
        );

      }else if(_visualizacao != null && _visualizacao == "list" ) {
        _bodyPage.add(
            Expanded(
              flex: 19,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: _listaItens.length,
                  itemBuilder: (context, index) {
                    return thumbList(context, _listaItens[index]);
                  },
                ),
              ),
            )
        );
    }else if( _visualizacao != null ){
      _bodyPage.add(
        Expanded(
          flex: 20,
          child: Center(
            child: CircularProgressIndicator(),
          )
        )
      );
    }

    var _existeItensSelecionado = true;
    if(_existeItensSelecionado){
      _bodyPage.add(
        Expanded(
          flex: 3 ,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  padding: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.copy , color: Colors.white , size: 26, ),
                      Text("Copiar" ,style: TextStyle(color: Colors.white ) , ),
                    ],
                  ),
                ),

                Container(
                  width: 80,
                  padding: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cut , color: Colors.white , size: 26, ),
                      Text("Recortar" ,style: TextStyle(color: Colors.white ) , ),
                    ],
                  ),
                ),

                Container(
                  width: 80,
                  padding: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete , color: Colors.white , size: 26, ),
                      Text("Deletar" ,style: TextStyle(color: Colors.white ) , ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // _bodyBottom = Theme(
      //   data: Theme.of(context).copyWith(
      //       canvasColor: Theme.of(context).accentColor,
      //       primaryColor: Colors.white,
      //       textTheme: Theme.of(context).textTheme.copyWith(
      //           caption: TextStyle(color: Colors.white54)
      //       )
      //   ),
      //   child: BottomNavigationBar(
      //     // currentIndex: _page,
      //     onTap: (page){
      //       // _pageController.animateToPage(
      //       //     page,
      //       //     duration: Duration(milliseconds: 500),
      //       //     curve: Curves.ease
      //       // );
      //     },
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.copy),
      //           title: const Text("Copiar")
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.cut),
      //           title: const Text("Recortar")
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.delete),
      //           title: const Text("Deletar")
      //       )
      //     ],
      //   ),
      // );
    }
      
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
           PopMenuButton(_opcaoPopMenuButton),
        ],
      ),
      body: Column(
        children: _bodyPage.map((e) {
          return e;
        }).toList(),
      ),
      bottomNavigationBar: _bodyBottom ,
    );
  }
  _opcaoPopMenuButton(String opcao){
    if(opcao == "nova-pasta"){
      // chamar modal para criar nova pasta
      _modalAdicionarNovaPasta( context );
    }else if(opcao == "visualizar"){
      // chamar moal com opcoes de vizual
    }else if( opcao == "atualizar"){
      // atualizar view
    }else{

    }
    //atualizar view

  }

  _modalAdicionarNovaPasta(BuildContext context) async {

    var retornoLista = await showDialog(
        context: context,
        builder: (context) {
          return ModalAdicionarNovaPasta();
        }
    );

    // var retornoLista = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(
    //         child: Container(
    //           padding: EdgeInsets.all(7),
    //           width: 250,
    //           height: 300,
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //           ),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.all(5),
    //                 child: Text("Criar Pasta" ),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.all(5),
    //                 child: TextFormField(
    //                   //controller: _nomeNovaPastaController,
    //                   decoration: InputDecoration(
    //                       labelText: "Nova Pasta"
    //                   ),
    //                 ),
    //               ),
    //               Row(
    //                 children: [
    //                   RaisedButton(
    //                     onPressed: null ,
    //                     child: Text("Cancelar"),
    //                     color: Theme.of(context).primaryColor,
    //                     textColor: Theme.of(context).textTheme.button.color,
    //                   ),
    //                   RaisedButton(
    //                     onPressed: null ,
    //                     child: Text("OK"),
    //                     color: Theme.of(context).primaryColor,
    //                     textColor: Theme.of(context).textTheme.button.color,
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    // );
    // //SE A LISTA VIER PREENCHIDA
    // if(retornoLista != null) {
    //   //adicionarConcentrado(int.parse( retornoLista[0] ) , int.parse( retornoLista[1] ) , double.parse( retornoLista[2] ) );
    // }
  }
  void _listenForPermissionStatus() async {
    final status = await PermissaoModel.getStatus();
    setState(() => _permissionStatus = status);
  }

}


