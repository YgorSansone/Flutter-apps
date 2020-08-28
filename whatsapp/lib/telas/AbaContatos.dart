import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

import '../RouteGenerator.dart';
import '../model/Usuario.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  String _id_user_logado;
  String _email_user_logado;
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

  List<Conversa> listaConversas;
  Future<List<Usuario>> _recuperarContatos() async {
    Firestore db = Firestore.instance;
    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();
    List<Usuario> listaUsuario = List();
    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      if(dados["email"] != _email_user_logado){
        Usuario usuario = Usuario();
        usuario.email = dados["email"];
        usuario.nome = dados["nome"];
        usuario.url = dados["urlImagem"];
        usuario.idUsuario = item.documentID;
        listaUsuario.add(usuario);
      }
    }
    return listaUsuario;
  }

  Future _recuperarDados()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _id_user_logado = usuarioLogado.uid;
      _email_user_logado = usuarioLogado.email;
    });
//    auth.signOut();
  }
@override
  void initState() {
    _recuperarDados();
    super.initState();
  }
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
      body: Container(
        child: FutureBuilder<List<Usuario>>(
            future: _recuperarContatos(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: [
                        Text("Carregando contatos"),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, indice) {
                        List<Usuario> listaitens = snapshot.data;
                        Usuario usuario = listaitens[indice];
                        return ListTile(
                          onTap: (){
                            Navigator.pushNamed(
                              context,
                              RouteGenerator.ROTA_MSG,
                              arguments: usuario
                            );
                          } ,
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          leading: CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: usuario.url != null
                                ?
                            NetworkImage(usuario.url)
                                : null
                          ),
                          title: Text(
                            usuario.nome,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      });
                  break;
              }
            }),
      ),
    );
  }
}
