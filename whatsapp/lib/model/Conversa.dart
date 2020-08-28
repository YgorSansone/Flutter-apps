import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Conversa{
  String _nome;
  String _mensagem;
  String _caminhoFoto;
  String _idRemetente;
  String _idDestinatario;
  String _tipoMensagem; //texto ou imagem
  String get nome => _nome;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idRemetente"     : this.idRemetente,
      "idDestinatario"  : this.idDestinatario,
      "nome"            : this.nome,
      "mensagem"        : this.mensagem,
      "caminhoFoto"     : this.caminhoFoto,
      "tipoMensagem"    : this.tipoMensagem,
    };
    return map;
  }

  Conversa();
  salvar()async{
    Firestore db = Firestore.instance;
    await db.collection("conversas")
    .document(this.idRemetente)
    .collection("ultima_conversa")
    .document(this.idDestinatario)
    .setData(this.toMap());
  }


  String get idRemetente => _idRemetente;

  set idRemetente(String value) {
    _idRemetente = value;
  }

  set nome(String value) {
    _nome = value;
  }

  String get mensagem => _mensagem;

  String get caminhoFoto => _caminhoFoto;

  set caminhoFoto(String value) {
    _caminhoFoto = value;
  }

  set mensagem(String value) {
    _mensagem = value;
  }

  String get idDestinatario => _idDestinatario;

  set idDestinatario(String value) {
    _idDestinatario = value;
  }

  String get tipoMensagem => _tipoMensagem;

  set tipoMensagem(String value) {
    _tipoMensagem = value;
  }
}