import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  List<Conversa> _listaConversas = List();
  @override
  void initState() {
    Conversa conversa = Conversa();
    conversa.nome = "Vera";
    conversa.mensagem = "ola";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=81ed04c2-e1b4-4e1d-8094-d53ba0238789";
    _listaConversas.add(conversa);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listaConversas.length,
        itemBuilder: (context, indice){
        Conversa conversa = _listaConversas[indice];
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
          subtitle: Text(
            conversa.mensagem,
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
