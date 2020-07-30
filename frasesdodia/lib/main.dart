import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeStatefull(),
  )
  );
}
class HomeStatefull extends StatefulWidget {
  @override
  _HomeStatefullState createState() => _HomeStatefullState();
}

class _HomeStatefullState extends State<HomeStatefull> {
  var _frases = ["Gratidao", "Ola", "Teste","boa"];
  var _frasegerada = "Clique abaixo para gerar uma frase!";
  void _gerarFrase(){
    var numero = Random().nextInt(_frases.length);
    setState(() {
      _frasegerada = _frases[numero];
    });

  }
//  int randomNumber = random.nextInt(frases.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do dia"),
        backgroundColor: Colors.lightGreen,
      ),
        body:Center(
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
//                border: Border.all(width: 3,color: Colors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset("images/logo.png",
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
        )
    );
  }
}


















































//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
///*
//Stateless -> Widgets que nao podem ser alterados (constantes)
//Stateful -> Widgets que podem ser alterados (variaveis)
// */
//void main(){
//  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    home: HomeStatefull(),
////    Container(
////      padding: EdgeInsets.fromLTRB(0, 0, 0,0),
////      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
////      decoration: BoxDecoration(
////        border: Border.all(width: 3, color: Colors.white),
////      ),
////      child: Image.asset("images/apple.jpg",
////        fit: BoxFit.scaleDown,
////      ),
//////      Row(
//////        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//////        crossAxisAlignment: CrossAxisAlignment.start,
//////        children: <Widget>[
//////          FlatButton(
//////              onPressed: (){
//////                print("pressionado");
//////              },
//////              child: Text("botao",
//////              style: TextStyle(
//////                fontSize: 50,
//////                color: Colors.white,
//////                decoration: TextDecoration.none,
//////              ),
//////              ),
//////          ),
////
//////        ],
//////      ),
//
//  ));
//}
//class HomeStatefull extends StatefulWidget {
//  @override
//  _HomeStatefullState createState() => _HomeStatefullState();
//}
//
//class _HomeStatefullState extends State<HomeStatefull> {
//  var _titulo = "Instagram";
//  @override
//  Widget build(BuildContext context) {
//    print("Build CHAMADO");
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(_titulo),
//        backgroundColor: Colors.green,
//      ),
//      body:Container(
//        child: Column(
//          children: <Widget>[
//            RaisedButton(
//              onPressed: (){
//                setState(() {
//                  _titulo= "ygor";
//                });
//              },
//              color: Colors.green,
//              child: Text("Clique aqui"),
//            ),
//            Text("Nome: $_titulo"),
//          ],
//        ),
//      ),
////      bottomNavigationBar: BottomAppBar(
////          color: Colors.lightGreen,
////          child: Padding(
////            padding: EdgeInsets.all(16),
////            child: Row(
////              children: <Widget>[
////                Text("teste"),
////                Text("teste2"),
////              ],
////            ),
////          )
////      ),
//    );
//  }
//}
//
//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//  }
//}
