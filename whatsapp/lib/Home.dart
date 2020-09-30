import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp/telas/AbaConversas.dart';
import 'package:whatsapp/telas/AbaStatus.dart';
import 'dart:io';
import 'RouteGenerator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> itensMenu = ["Configurações", "Deslogar"];
  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configurações":
        Navigator.pushNamed(context, RouteGenerator.ROTA_CONFI);
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, RouteGenerator.ROTA_LOGIN, (_) => false);
  }

  String _emailUsuario = "";
  Future _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
//    auth.signOut();
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    if (usuarioLogado != null) {
      // Navigator.pushReplacementNamed(context, RouteGenerator.ROTA_HOME);
    }
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
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
        elevation: Platform.isIOS ? 0 : 4,
        bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: TextStyle(
                fontSize: 15,
                textBaseline: TextBaseline.alphabetic,
                fontWeight: FontWeight.bold),
            controller: _tabController,
            indicatorColor: Platform.isIOS ? Colors.grey[400] : Colors.white,
            isScrollable: true,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.camera_alt,
                textDirection: TextDirection.ltr,
              )),
              Tab(
                text: "CONVERSAS",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "CHAMADAS",
              ),
            ]),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
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
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteGenerator.ROTA_CONTATO);
        },
        child: Icon(
          Icons.insert_comment,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
