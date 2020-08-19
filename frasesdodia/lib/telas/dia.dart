import 'dart:math';

import 'package:flutter/material.dart';
class Dia extends StatefulWidget {
  @override
  _DiaState createState() => _DiaState();
}

class _DiaState extends State<Dia> {
  var _frases = ["Gratidao", "Ola", "Teste","boa"];
  var _frasegerada = "Clique abaixo para gerar uma frase!";
  void _gerarFrase(){
    var numero = Random().nextInt(_frases.length);
    setState(() {
      _frasegerada = _frases[numero];
    });

  }
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset("images/dois.gif",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(_frasegerada,
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                        color: Colors.lightGreen,
                        child: Text("Nova frase",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _gerarFrase();
                        }
                    ),
                  ),
                ],
              )
          ),
        );
  }
}