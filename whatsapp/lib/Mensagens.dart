import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/model/Mensagem.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'model/Conversa.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;
  Mensagens(this.contato);
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
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
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  Firestore db = Firestore.instance;
  String _idUsuarioDestinatario;
  TextEditingController _controllerMensagem = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  _enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      Mensagem msg = Mensagem();
      msg.idUsuario = _idUsuarioLogado;
      msg.mensagem = textoMensagem;
      msg.url = "";
      msg.tipo = "texto";
      msg.data = Timestamp.now().toString();
      _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, msg);
      _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, msg);
      //salvar conversa
      _salvarConversa(msg);
    }
  }
_salvarConversa(Mensagem mensagem){
    Conversa cRemetente = Conversa();
    cRemetente.idRemetente = _idUsuarioLogado;
    cRemetente.idDestinatario = _idUsuarioDestinatario;
    cRemetente.mensagem = mensagem.mensagem;
    cRemetente.nome = widget.contato.nome;
    cRemetente.caminhoFoto = widget.contato.url;
    cRemetente.tipoMensagem = mensagem.tipo;
    cRemetente.data = mensagem.data;
    cRemetente.salvar();
    Conversa cDestinatario = Conversa();
    cDestinatario.idRemetente = _idUsuarioDestinatario;
    cDestinatario.idDestinatario = _idUsuarioLogado;
    cDestinatario.mensagem = mensagem.mensagem;
    cDestinatario.nome = widget.contato.nome;
    cDestinatario.caminhoFoto = widget.contato.url;
    cDestinatario.tipoMensagem = mensagem.tipo;
    cDestinatario.data = mensagem.data;
    cDestinatario.salvar();
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

  _enviarFoto() async {
    File imagemSelecionada;
    imagemSelecionada =
    await ImagePicker.pickImage(source: ImageSource.gallery);

    _subindoImagem = true;
    String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
        .child("mensagens")
        .child(_idUsuarioLogado)
        .child(nomeImagem + ".jpg");

    //Upload da imagem
    StorageUploadTask task = arquivo.putFile(imagemSelecionada);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent) {
      if (storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    Mensagem mensagem = Mensagem();
    mensagem.idUsuario = _idUsuarioLogado;
    mensagem.mensagem = "";
    mensagem.url = url;
    mensagem.tipo = "imagem";
    mensagem.data = Timestamp.now().toString();
    //Salvar mensagem para remetente
    _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, mensagem);

    //Salvar mensagem para o destinatário
    _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, mensagem);
    _salvarConversa(mensagem);
  }

  Future _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
      _idUsuarioDestinatario = widget.contato.idUsuario;
    });
    _adicionarListenerMensagem();
//    auth.signOut();
  }
  Stream<QuerySnapshot>_adicionarListenerMensagem(){
    final stream = db
        .collection("mensagens")
        .document(_idUsuarioLogado)
        .collection(_idUsuarioDestinatario)
        .orderBy("data",descending: false)
        .snapshots();
    stream.listen((dados){
      _controller.add( dados );
      Timer(Duration(seconds: 1), (){
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } );
    });
  }

  @override
  void initState() {
    _recuperarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var stram = StreamBuilder(
      stream: _controller.stream,
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
              return  Text("Erro ao carregar as mensagens");
            } else {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                    itemCount: querySnapshot.documents.length,
                    itemBuilder: (context, indice) {
                      List<DocumentSnapshot> mensagens =
                          querySnapshot.documents.toList();
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
                            child: item["tipo"] == "texto"
                                ? Text(
                                    item["mensagem"],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  )
                                : Image.network(item["url"]),
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
                hintText: "Digite uma mensagem",
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                suffixIcon: _subindoImagem
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: Icon(Icons.attach_file), onPressed: _enviarFoto),
              ),
            ),
          ),Platform.isIOS
              ? CupertinoButton(
              child: Text("Enviar"),
              onPressed: _enviarMensagem)
              : FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
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
        actions: <Widget>[
          Icon(Icons.videocam),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
          ),
          Icon(Icons.phone),
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
