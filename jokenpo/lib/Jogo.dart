import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _ImagemApp = AssetImage("images/padrao.png");
  var _mensagem ="Escolha uma opcao abaixo";
  void opcaoSelecionada(int opcaouser){
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(opcoes.length);
    var opcoesapp = opcoes[numero];
    setState(() {
      this._ImagemApp =AssetImage("images/${opcoesapp}.png");
    });
    numero++;
//    print(opcaouser);
    if((numero == 3 && opcaouser == 1) ||
        (numero == 2 && opcaouser == 3) ||
        (numero == 1 && opcaouser == 2)){
      setState(() {
        this._mensagem ="Parabens - Voce ganhou";
      });
      //ganhei
    }else if((numero == 1 && opcaouser == 3) ||
             (numero == 3 && opcaouser == 2) ||
            (numero == 2 && opcaouser == 1)){
      //app- ganhou
      setState(() {
        this._mensagem ="Voce perdeu :(";
      });
    }else{
      //empate
      setState(() {
        this._mensagem ="Empatou";
      });
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("JokenPo"),
        ) ,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //text
          //img
          //resultado
          //linha - 3 imagens
          Padding(
            padding: EdgeInsets.only(top: 32,bottom: 16),
            child: Text(
              "Escolha do app",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
//          Image.asset("images/padrao.png"),
          Image(image: this._ImagemApp,),
          Padding(
            padding: EdgeInsets.only(top: 32,bottom: 16),
            child: Text(
              this._mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => opcaoSelecionada(1),
                child: Image.asset("images/pedra.png", height: 100,),
              ),
              GestureDetector(
                onTap: () => opcaoSelecionada(2),
                child: Image.asset("images/papel.png",height: 100),
              ),
              GestureDetector(
                onTap: () => opcaoSelecionada(3),
                child: Image.asset("images/tesoura.png", height: 100),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
