import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
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
    return ListView.builder(
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
