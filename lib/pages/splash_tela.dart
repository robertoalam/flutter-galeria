import 'dart:async';
import 'package:flutter/material.dart';
import 'package:galeria/models/configuracao_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_tela.dart';
import '../helper/database.dart';

class SplashTela extends StatefulWidget {
  @override
  _SplashTelaState createState() => _SplashTelaState();
}

class _SplashTelaState extends State<SplashTela> {

  final dbHelper = DatabaseHelper.instance;
  ConfiguracaoModel config = new ConfiguracaoModel();
  int _no_aberturas = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    config.getConfiguracoes().then( (list) {
      setState(() {
        _no_aberturas = int.parse( list['no_aberturas'] );
        list['ds_view'];
        list['no_view'];
      });
      config.aberturaIncrementar();
      _redirecionar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage("assets/imagens/logo.png"),),
    );
  }

  _redirecionar(){
    int tempo = (_no_aberturas > 2) ? 1 : 5 ;
    Timer( Duration(seconds: tempo) , ()=>
        Navigator.pushReplacement( context,  MaterialPageRoute( builder: (context) => HomeTela() ) ),
    );
  }
}
