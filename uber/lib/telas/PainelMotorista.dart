import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Rotas.dart';
class PainelMotorista extends StatefulWidget {
  @override
  _PainelMotoristaState createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {
  List<String> itensMenu = ["Deslogar"];
  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Rotas.ROTA, (_) => false);
  }
  _escolharMenuItem(String escolha) {
    switch(escolha){
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Motorista"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolharMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList();
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
