import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frasesdodia/telas/dia.dart';
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


  String _resposta = "";
  int _indiceAtual = 0;
//  int randomNumber = random.nextInt(frases.length);
  List<Widget> telas = [
    Dia(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/amor.png",
          width: 98,
          height: 70,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
//        actions: <Widget>[
//          IconButton(
//            icon:Icon(Icons.cast),
//            onPressed: (){
//              print("acao: cast");
//            },
//          ),
//          IconButton(
//            icon:Icon(Icons.videocam),
//            onPressed: (){
//              print("acao: videocam");
//            },
//          ),
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () async{
////              String res = await showSearch(context: context, delegate: CustomSearchDelegate());
//              setState(() {
////                _resposta = res;
//              });
//            },
//
//          ),
//          IconButton(
//            icon: Icon(Icons.account_circle),
//            onPressed: (){
//              print("acao: conta");
//            },
//          ),
//        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Mensagens"),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text("Tempo"),
            icon: Icon(Icons.access_time),
          ),
          BottomNavigationBarItem(
            title: Text("Especial"),
            icon: Icon(Icons.cake),
          ),

        ],
      ),
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
