import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class AbaStatus extends StatefulWidget {
  @override
  _AbaStatusState createState() => _AbaStatusState();
}

class _AbaStatusState extends State<AbaStatus> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  bool foi = false;
  String _frase;
  bool msge;
  List<String> _frases = [
    "Meu amor, eu te amo demais",
    "Sonhou comigo ?",
    "Eu tenho a melhor pessoa do mundo ao meu lado",
    "Voce e tao bebezinha ne",
    "Se vc estiver vendo me manda uma msg",
    "Voce e extremamente importante para mim",
    "Nos viemos do macarrao",
    "A felicidade é constante por ter você em minha vida",
    "Você é a mulher que sempre sonhei em ter ao meu lado",
    "Vida, você mudou a minha vida",
    "Todo dia agradeço por ser digno do seu amor",
    "Eu estou morrendo de saudade",
    "Amor, esta com saudades ?",
    "Falta quanto tempo ?, morrendo de vontade de te apertar",
    "Voce e o meu maior orgulho <3"
  ];
  List<String> _imagens = [
    "https://static.mundodasmensagens.com/upload/textos/a/-/a-luz-dos-seus-olhos-ilumina-meu-coracao-de-um-jeito-magico-e-des-7rLAB-w.jpg",
    "https://static.mundodasmensagens.com/upload/textos/e/u/eu-te-amo-e-isso-basta-para-eu-ser-feliz-3VRxz-w.jpg",
    "https://static.mundodasmensagens.com/upload/textos/p/a/pararia-o-tempo-e-ficaria-no-seu-abraco-a-vida-inteira-meu-amor-k10Ln-w.jpg",
    "https://i.pinimg.com/originals/8b/e6/fc/8be6fcda47b65c5b1d4af1cc6e15ce22.jpg",
    "https://amplino.org/wp-content/uploads/2018/09/848ce244f0acddc4483f126214200ac8.jpg"
  ];
  _status() {
    Random random = new Random();
    String frase;
    bool msg = random.nextBool();
    if (msg) {
      //frases
      var tmb = _frases.length;
      frase = _frases[random.nextInt(tmb)];
      print(frase);
    } else {
      //img
      var tmb = _imagens.length;
      frase = _imagens[random.nextInt(tmb)];
      print(frase);
    }
    setState(() {
      msge = msg;
      _frase = frase;
      foi = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: foi == true
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: msge == true
                          ? Text(
                              _frase,
                              style:
                                  TextStyle(fontSize: 18,
                                      color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          : Image.network(
                              _frase,
                            ),
                    )
                  : Text(
                      "Clique para gerar uma mensagem",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
            ),
          ),
          Expanded(
            child: FloatingActionButton(
              child: Icon(
                Icons.control_point,
                color: Colors.white,
              ),
              onPressed: () {
                _status();
              },
            ),
          ),
        ],
      ),
    );
  }
}
