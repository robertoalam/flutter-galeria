import 'dart:io';
import 'package:flutter/material.dart';
import 'package:galeria/helper/active_record.dart';
import 'package:galeria/models/bloc_model.dart';
import 'package:galeria/models/configuracao_model.dart';
import 'package:galeria/models/diretorio_model.dart';
import 'package:galeria/models/item_model.dart';
import 'package:galeria/models/permissao_model.dart';
import 'package:galeria/widgets/adicionar_nova_pasta_modal.dart';
import 'package:galeria/widgets/bottom_footer.dart';
import 'package:galeria/widgets/pop_menu_button.dart';
import 'package:galeria/widgets/thumb_grid.dart';
import 'package:galeria/widgets/thumb_list.dart';
import '../helper/funcoes.dart';


class PastaTela extends StatefulWidget {

  Directory directory;
  bool barraNavigation;
  PastaTela({this.directory,this.barraNavigation});

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

  List<Map<String,dynamic>> _listaPopMenuButton = [
    {'valor':'selecionar','icone':Icons.apps,'label':'Selecionar Todos'},
    {'valor':'deselecionar','icone':Icons.apps,'label':'Deselecionar Todos'},
    {'valor':'nova','icone':Icons.create_new_folder,'label':'Novo'},
    {'valor':'visualizar','icone':Icons.remove_red_eye,'label':'Visualizar'},
    {'valor':'atualizar','icone':Icons.refresh,'label':'Atualizar'},
  ];

  int _flagBotoesNavigationBar = 1;
  List<Map<String,dynamic>> _listaBottomNavigationBarAcaoPrimeira = [
    {'valor':'copiar','icone':Icons.copy,'label':'Copiar'},
    {'valor':'recortar','icone':Icons.cut,'label':'Recortar'},
    {'valor':'deletar','icone':Icons.delete,'label':'Deletar'},
  ];

  List<Map<String,dynamic>> _listaBottomNavigationBarAcaoDois = [
    {'valor':'colar','icone':Icons.paste,'label':'Colar'},
    {'valor':'cancelar','icone':Icons.cancel,'label':'Cancelar'},
  ];

  @override
  void initState() {
    super.initState();

    if(widget.directory != null){
      _caminhoDiretorioCompleto = widget.directory.toString();
      _caminhoDiretorioTruncado = funcoes.corrigirCaminhoPasta(_caminhoDiretorioCompleto);
      bloc.flagExibirBarraNavigation = widget.barraNavigation;
      _flagBotoesNavigationBar = 2;
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
            child: Text("${_caminhoDiretorioTruncado} - ${bloc.flagExibirBarraNavigation}"),
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
    // _bodyPage.add(
    //
    // );

    return StreamBuilder(
        stream: bloc.output,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Home - ${bloc.total} - ${bloc.flagExibirBarraNavigation}"),
              actions: [
                PopMenuButton(_listaPopMenuButton ,_opcaoPopMenuButton),
              ],
            ),
            body: Column(
              children: <Widget>[
                ..._bodyPage.map((e) {
                  return e;
                }).toList(),
                BottomFooter(listagem: (_flagBotoesNavigationBar==1)? _listaBottomNavigationBarAcaoPrimeira: _listaBottomNavigationBarAcaoDois, bloc: bloc , onSubmit: _opcaobottomNavigationBar),

              ]
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

  _opcaobottomNavigationBar(String opcao){
    var lista = _buscarObjetosSelecionados;
    ActiveRecord persistencia = new ActiveRecord();
    if(opcao=="copiar"){
      setState(() {
        bloc.acaoPendenteSet(true);
        _flagBotoesNavigationBar = 2;
      });
    }
    if(opcao=="recortar"){
      //persistencia.inserirLista(lista);
      setState(() {
        _flagBotoesNavigationBar = 2;
      });
    }
    if(opcao=="deletar"){
      setState(() {
        _flagBotoesNavigationBar = 1;
        bloc.flagExibirBarraNavigation = false;
      });
    }

    if(opcao=="colar"){
      persistencia.colar(lista);
      setState(() {
        _flagBotoesNavigationBar = 1;
        bloc.flagExibirBarraNavigation = false;
      });
    }

    if(opcao=="cancelar"){
      setState(() {
        bloc.acaoPendenteSet(false);
        bloc.exibirBarraSet(false);
        _flagBotoesNavigationBar = 1;
      });
    }
  }

  get _buscarObjetosSelecionados{
    List<Map<String,String>> listaObjetosSelecionados = [];
    _listaItens.forEach((e) {
      if(e.selecionado){
        listaObjetosSelecionados.add({'arquivo':e.caminhoCompletoTruncado.toString()});
      }
    });
    return listaObjetosSelecionados;
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


