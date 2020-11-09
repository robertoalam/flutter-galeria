import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_tela.dart';
import '../helper/database.dart';

class SplashTela extends StatefulWidget {
  @override
  _SplashTelaState createState() => _SplashTelaState();
}

class _SplashTelaState extends State<SplashTela> {

  final dbHelper = DatabaseHelper.instance;
  int _aberturasNumero = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _redirecionar(int tempo){
    int tempo = (_aberturasNumero > 2) ? 2 : 5 ;
    Timer( Duration(seconds: tempo) , ()=>
        Navigator.pushReplacement( context,  MaterialPageRoute( builder: (context) => HomeTela() ) ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage("imagens/logo.png"),),
    );
  }

  void _init() async {
    await _aberturasSetar();
    await _buscarAberturas();
    final allRows = await dbHelper.queryAllRows('propriedades');
    print('query all rows:');
    allRows.forEach((row) => print(row));
    await _redirecionar(_aberturasNumero);
  }


  _aberturasSetar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _aberturasNumero = (prefs.getInt('aberturas') ?? 0) + 1;
    await prefs.setInt('aberturas', _aberturasNumero);
    return ;
  }

  _buscarAberturas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _aberturasNumero = prefs.getInt('aberturas');
    setState(() {
      _aberturasNumero;
    });
  }

}
