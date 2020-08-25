import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

import '../Login.dart';
import '../RouteGenerator.dart';
class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {

  List<String> itensMenu =[
    "Configurações", "Deslogar"
  ];
  _escolhaMenuItem(String itemEscolhido){
    switch(itemEscolhido){
      case "Configurações":
        print("Configurações");
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
  List<Conversa> listaConversas = [
    Conversa(
        "Jose Renato",
        "Ola tudo bem?????????????????????????????????????????????????????????????????????????",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=81ed04c2-e1b4-4e1d-8094-d53ba0238789"
    ),    Conversa(
        "Jose Renato",
        "Ola tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=d1f7a6e8-5f93-4bba-90c8-2756e6e6afa8"
    ),    Conversa(
        "Jose Renato",
        "Ola tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=81ed04c2-e1b4-4e1d-8094-d53ba0238789"
    ),    Conversa(
        "Jose Renato",
        "Ola tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=d1f7a6e8-5f93-4bba-90c8-2756e6e6afa8"
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
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

      body: Container(
        child: ListView.builder(
            itemCount: listaConversas.length,
            itemBuilder: (context, indice){
              Conversa conversa = listaConversas[indice];
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(conversa.caminhoFoto),
                ),
                title: Text(
                  conversa.nome,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
