import 'dart:math';

import 'package:caraoucoroa/Resultado.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class Jogar extends StatefulWidget {
  @override
  _JogarState createState() => _JogarState();
}

class _JogarState extends State<Jogar> {
  void jogar(){
    var itens = ["cara", "coroa"];
    var numero = Random().nextInt(itens.length);
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => Resultado(itens[numero])));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
//      backgroundColor: Color.fromRGBO(255, 204, 128, 0.9),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("imagens/logo.png"),
            GestureDetector(
              onTap: (){jogar();},
              child: Image.asset("imagens/botao_jogar.png"),
            ),
          ],

        ),
      ),
    );
  }
}
