import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUsuarioLogado;
  List<Conversa> _listaConversas = List();
  @override
  void initState() {
    Conversa conversa = Conversa();
    conversa.nome = "Vera";
    conversa.mensagem = "ola";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=81ed04c2-e1b4-4e1d-8094-d53ba0238789";
    _listaConversas.add(conversa);
    _recuperarDados();
    super.initState();
  }
  Stream<QuerySnapshot>_adicionarListenerConversas(){
    final stream = db.collection("conversas")
        .document(_idUsuarioLogado)
        .collection("ultima_conversa")
        .snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }
  Future _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
    });
    _adicionarListenerConversas();
//    auth.signOut();
  }
  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
            child: Column(
              children: [
                Text("Carregando conversas"),
                CircularProgressIndicator()
              ],
            ),
          );
          break;
          case ConnectionState.active:
          case ConnectionState.done:
          if (snapshot.hasError) {
            return  Text("Erro ao carregar as mensagens");
          }else{
            QuerySnapshot querySnapshot = snapshot.data;
            if(querySnapshot.documents.length == 0){
              return Center(
                child: Text("Voce nao tem nenhuma mensagem ainda :(",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),)
              );
            }
            return ListView.builder(
                itemCount: _listaConversas.length,
                itemBuilder: (context, indice){
                  List<DocumentSnapshot> conversas= querySnapshot.documents.toList();
                  DocumentSnapshot item = conversas[indice];
                  String urlImagem = item["caminhoFoto"];
                  String tipo = item["tipoMensagem"];
                  String menagem = item["mensagem"];
                  String nome = item["nome"];
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: urlImagem!= null ?
                      NetworkImage(urlImagem)
                          :null
                    ),
                    title: Text(
                      nome,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    subtitle: Text(
                      tipo == "texto"?
                          menagem :
                          "Imagem ...",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                      ),
                    ),
                  );
                }
            );
          }

          }
        },
    );

  }
}
