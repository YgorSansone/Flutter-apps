import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Status{
  String _id;
  String _mensagem;
  String _url;
  String _data;

  Status();
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.id,
      "mensagem": this.mensagem,
      "url": this.url,
      "data": this.data,
    };
    return map;
  }

  salvar() async {
    Firestore db = Firestore.instance;
    await db
        .collection("status")
        .document(this.mensagem)
        .setData(this.toMap());
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get url => _url;

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  set url(String value) {
    _url = value;
  }
}