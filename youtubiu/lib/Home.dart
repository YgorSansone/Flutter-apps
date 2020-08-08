import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubiu/CustomSearchDelegate.dart';
import 'package:youtubiu/telas/biblioteca.dart';
import 'package:youtubiu/telas/emalta.dart';
import 'package:youtubiu/telas/inicio.dart';
import 'package:youtubiu/telas/inscricao.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resposta = "";
  int _indiceAtual = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(_resposta),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "Imagens/youtube.png",
          width: 98,
          height: 22,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1,
        ),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.cast),
            onPressed: (){
              print("acao: cast");
            },
          ),
          IconButton(
            icon:Icon(Icons.videocam),
            onPressed: (){
              print("acao: videocam");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
              String res = await showSearch(context: context, delegate: CustomSearchDelegate());
              setState(() {
                _resposta = res;
              });
            },

          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              print("acao: conta");
            },
          ),
        ],
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
            title: Text("Inicio"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Em alta"),
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            title: Text("Inscrições"),
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            title: Text("Biblioteca"),
            icon: Icon(Icons.folder),
          ),

        ],
      ),
    );
  }
}
