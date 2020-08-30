import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsuarioLogado;
  String _imagemRecuperada;
  File imagemSelecionada;
  String _nomeusuario;
  bool _subindoImagem = false;
  Future _recuperarImagem(bool daCamera) async {
    if (daCamera) {
      // ignore: deprecated_member_use
      imagemSelecionada =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    } else {
      // ignore: deprecated_member_use
      imagemSelecionada =
          await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo =
        pastaRaiz.child("perfil").child("${_idUsuarioLogado}.jpg");
    StorageUploadTask task = arquivo.putFile(_imagem);
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
      task.onComplete.then((StorageTaskSnapshot snapshot) {
        _recuparUrlImagem(snapshot);
      });
    });
  }

  Future _recuparUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFiresStore(url);
    setState(() {
      _imagemRecuperada = url;
    });
  }

  Future _atualizarUrlImagemFiresStore(String url) async {
    Firestore db = Firestore.instance;
    Map<String, dynamic> dadosAtualizar = {"urlImagem": url};
    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  Future _atualizarNomeFiresStore(bool doBotao, {String texto}) async {
    var nome;
    if (doBotao) {
      nome = _controllerNome.text;
    } else {
      nome = texto;
    }
    Firestore db = Firestore.instance;
    Map<String, dynamic> dadosAtualizar = {"nome": nome};
    db
        .collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);
  }

  Future _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
    });
    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(_idUsuarioLogado).get();
    Map<String, dynamic> dados = snapshot.data;
    setState(() {
      _controllerNome.text = dados["nome"];
    });
    if (dados["urlImagem"] != null) {
      setState(() {
        _imagemRecuperada = dados["urlImagem"];
      });
    }
//    auth.signOut();
  }

  @override
  @override
  void initState() {
    _recuperarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: _subindoImagem
                      ? CircularProgressIndicator()
                      : Container(),
                ),
                CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    backgroundImage: _imagemRecuperada != null
                        ? NetworkImage(_imagemRecuperada)
                        : null),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () {
                          _recuperarImagem(false);
                        },
                        child: Text("Camera")),
                    FlatButton(
                        onPressed: () {
                          _recuperarImagem(true);
                        },
                        child: Text("Galeria")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    controller: _controllerNome,
                    keyboardType: TextInputType.text,
                    onChanged: (texto) {
                      _atualizarNomeFiresStore(false, texto: texto);
                    },
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {
                      _atualizarNomeFiresStore(true);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    "",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
