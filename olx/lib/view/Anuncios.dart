import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../RouteGenerator.dart';
class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];
  _escolheMenuItem(String itemEscolhido){
    switch (itemEscolhido) {
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, RouteGenerator.ROTA_LOGIN);
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Meus anuncios":
        Navigator.pushNamed(context, RouteGenerator.ROTA);
        break;
    }
  }
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(
        context, RouteGenerator.ROTA_LOGIN);
  }

  Future _verificarUsuarioLogado() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    if(usuarioLogado == null){
      itensMenu = ["Entrar / Cadastrar"];
    }else{
      itensMenu = ["Meus anuncios", "Deslogar"];
    }
  }
  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OLX"),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolheMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
              // });
            },
          )
        ],
      ),
      body: Container(
        child: Text("anuncios"),
      ),
    );
  }
}
