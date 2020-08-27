import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Mensagem.dart';
import 'package:whatsapp/model/Usuario.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;
  Mensagens(this.contato);
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  String _idUsuarioLogado;
  Firestore db = Firestore.instance;
  String _idUsuarioDestinatario;
  TextEditingController _controllerMensagem = TextEditingController();
  List<String> listaMensagens = [
    "ola tudo bem ?",
    "tudo",
    "boa",
  ];
  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      Mensagem msg = Mensagem();
      msg.idUsuario = _idUsuarioLogado;
      msg.mensagem = textoMensagem;
      msg.url = "";
      msg.tipo = "texto";
      _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, msg);
      _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, msg);
    }
  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .document(idRemetente)
        .collection(idDestinatario)
        .add(msg.toMap());
    _controllerMensagem.clear();
  }

  _enviarFoto() {

  }
  Future _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
      _idUsuarioDestinatario = widget.contato.idUsuario;
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
    var stram = StreamBuilder(
      stream: db
          .collection("mensagens")
          .document(_idUsuarioLogado)
          .collection(_idUsuarioDestinatario)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text("Carregando mensagens"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;
            if (snapshot.hasError) {
              return Expanded(child: Text("Erro ao carregar as mensagens"));
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context, indice) {
                      List<DocumentSnapshot> mensagens = querySnapshot.documents.toList();
                      DocumentSnapshot item = mensagens[indice];
                      double larguraContainer =
                          (MediaQuery.of(context).size.width * 0.8);
                      Alignment alinhamento = Alignment.centerRight;
                      Color cor = Color(0xffd2ffa5);
                      if (_idUsuarioLogado != item["idUsuario"]) {
                        alinhamento = Alignment.centerLeft;
                        cor = Colors.white;
                      }
                      return Align(
                        alignment: alinhamento,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            width: larguraContainer,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: cor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              item["mensagem"],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            break;
        }
      },
    );
    var caixaMensagem = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20),
              controller: _controllerMensagem,
              autofocus: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                  hintText: "Senha",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  prefixIcon: IconButton(
                      icon: Icon(Icons.camera_alt), onPressed: _enviarFoto)),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: _enviarMensagem,
          ),
        ],
      ),
    );
    var listView = Expanded(
      child: ListView.builder(
          itemCount: listaMensagens.length,
          itemBuilder: (context, indice) {
            double larguraContainer = (MediaQuery.of(context).size.width * 0.8);
            Alignment alinhamento = Alignment.centerRight;
            Color cor = Color(0xffd2ffa5);
            if (indice % 2 == 0) {
              alinhamento = Alignment.centerLeft;
              cor = Colors.white;
            }
            return Align(
              alignment: alinhamento,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Container(
                  width: larguraContainer,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: cor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    listaMensagens[indice],
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            );
          }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              radius: 20,
              backgroundImage: widget.contato.url != null
                  ? NetworkImage(widget.contato.url)
                  : null,
            ),
            Padding(padding: EdgeInsets.only(left: 6)),
            Text(widget.contato.nome),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Imagens/bg.png"), fit: BoxFit.cover)),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              stram,
              caixaMensagem,

              //LISTVIEW
              //CAIXA DE MENSAGEM
            ],
          ),
        )),
      ),
    );
  }
}
