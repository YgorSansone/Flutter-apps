import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Login.dart';
import 'package:whatsapp/telas/AbaContatos.dart';
import 'package:whatsapp/telas/AbaConversas.dart';
import 'package:whatsapp/telas/AbaStatus.dart';

import 'RouteGenerator.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController _tabController;
  List<String> itensMenu =[
    "Configurações", "Deslogar"
  ];
  _escolhaMenuItem(String itemEscolhido){
    switch(itemEscolhido){
      case "Configurações":
        Navigator.pushNamed(context, RouteGenerator.ROTA_CONFI);
        break;
      case "Deslogar" :
        _deslogarUsuario();
        break;
    }
  }
  _deslogarUsuario()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.ROTA_LOGIN,(_)=>false);
  }
  String _emailUsuario = "";
  Future _recuperarDados()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
//    auth.signOut();
  }
  @override
  void initState() {
    _recuperarDados();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 15,
              textBaseline: TextBaseline.alphabetic,
              fontWeight: FontWeight.bold
            ),
            controller: _tabController,
            indicatorColor: Colors.white,

            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: "CHATS",),
              Tab(text: "STATUS" ,),
              Tab(text: "CALLS" ,),
            ]
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
//          CameraScreen(widget.cameras),
          AbaConversas(),
          AbaConversas(),
          AbaStatus(),
          AbaStatus(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, RouteGenerator.ROTA_CONTATO);
        },
        child: Icon(Icons.insert_comment,color: Colors.white,),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
