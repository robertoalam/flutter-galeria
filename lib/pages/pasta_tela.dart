import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galeria/models/bloc_model.dart';
import 'package:galeria/models/configuracao_model.dart';
import 'package:galeria/models/diretorio_model.dart';
import 'package:galeria/models/item_model.dart';
import 'package:galeria/models/permissao_model.dart';
import 'package:galeria/widgets/adicionar_nova_pasta_modal.dart';
import 'package:galeria/widgets/pop_menu_button.dart';
import 'package:galeria/widgets/thumb_grid.dart';
import 'package:galeria/widgets/thumb_list.dart';
import '../helper/funcoes.dart';


class PastaTela extends StatefulWidget {

  Directory directory;
  PastaTela({this.directory});

  @override
  _PastaTelaState createState() => _PastaTelaState();
}

class _PastaTelaState extends State<PastaTela> {

  MeuBlocModel bloc = MeuBlocModel();
  bool _selecionarTodos = false;
  bool _existeItensSelecionado = false;
  var _permissionStatus;
  String _caminhoDiretorioCompleto;
  String _caminhoDiretorioTruncado = "Pictures";
  DiretorioModel _diretorioModel = new DiretorioModel();
  Directory _diretorio;
  List<ItemModel> _listaItens = List<ItemModel>();

  ConfiguracaoModel _config = new ConfiguracaoModel();
  String _visualizacao;
  int _visualizacaoCrossAxisCount = 2;

  List<Widget> _bodyPage = new List<Widget>();

  List<Map<String,dynamic>> _opcaoLista = [
    {'valor':'selecionar','icone':Icons.apps,'label':'Selecionar Todos'},
    {'valor':'deselecionar','icone':Icons.apps,'label':'Deselecionar Todos'},
    {'valor':'nova','icone':Icons.create_new_folder,'label':'Novo'},
    {'valor':'visualizar','icone':Icons.remove_red_eye,'label':'Visualizar'},
    {'valor':'atualizar','icone':Icons.refresh,'label':'Atualizar'},
  ];

  @override
  void initState() {
    super.initState();

    if(widget.directory != null){
      _caminhoDiretorioCompleto = widget.directory.toString();
      _caminhoDiretorioTruncado = funcoes.corrigirCaminhoPasta(_caminhoDiretorioCompleto);
    }

    _buscarArquivos();
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

        // BLOCO IMPORTANTE

        _caminhoDiretorioCompleto = await _diretorioModel.buscarCaminho( _caminhoDiretorioTruncado );
        if(_caminhoDiretorioCompleto != null){
          var dir = Directory( _caminhoDiretorioCompleto );
          _listaItens = await _diretorioModel.buscarArquivosTodos(dir);
        }

        setState(() {
          _listaItens;
        });
        // BLOCO IMPORTANTE

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    _bodyPage.clear();

    if(_caminhoDiretorioCompleto != null ){
      _bodyPage.add(
          Expanded(
            flex: 1,
            child: Text("${_caminhoDiretorioTruncado} - ${bloc.exibirBarraOpcoes}"),
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
                    return thumbGrid( objeto: _listaItens[index], bloc : bloc );
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


    // ADICIONA FOTTOM BAR COM OPCOES
    _bodyPage.add(
      Expanded(
        flex: 3 ,
        child: Visibility(
          visible: true,
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
      ),
    );

    return StreamBuilder(
      stream: bloc.output,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home - ${bloc.total} - ${bloc.exibirBarraOpcoes}"),
            actions: [
              PopMenuButton(_opcaoLista ,_opcaoPopMenuButton),
            ],
          ),
          body: Column(
            children: _bodyPage.map( (e) {
              return e;
            }).toList(),
          ),
        );
      }
    );
  }

  _opcaoPopMenuButton(String opcao){

    if(opcao=="selecionar"){
      _buscarArquivos();
    }

    if(opcao=="deselecionar"){
      bloc.zerar();
      setState(() {
        _selecionarTodos = false;
      });
      _buscarArquivos();
    }

    if(opcao == "nova") {
      // chamar modal para criar nova pasta
      _modalAdicionarNovaPasta(context);
    }

   if(opcao == "visualizar") {
     // chamar moal com opcoes de vizual
   }

   if( opcao == "atualizar"){
      // atualizar view
      _buscarArquivos();
    }
    
   //atualizar view

  }

  _modalAdicionarNovaPasta(BuildContext context) async {

    var retornoNomePasta = await showDialog(
        context: context,
        builder: (context) {
          return ModalAdicionarNovaPasta();
        }
    );
    // if(retornoNomePasta != null) {
    //   var retornoCriarPasta = await _diretorio.criarNovaPasta(
    //       '$_caminhoDiretorioCompleto/$retornoNomePasta');
    //   if (retornoCriarPasta['status']) {
    //     //pasta criada
    //     print(retornoCriarPasta);
    //   } else {
    //     // pasta ja existe
    //   }
    // }
  }

  void _listenForPermissionStatus() async {
    final status = await PermissaoModel.getStatus();
    setState(() => _permissionStatus = status);
  }

}


