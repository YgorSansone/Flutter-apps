import 'package:flutter/material.dart';
import 'package:whatsapp/model/Usuario.dart';
class Mensagens extends StatefulWidget {
  Usuario contato;
  Mensagens(this.contato);
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Row(
          children: [
            CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.contato.url),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(widget.contato.nome),
          ],
        ),

      ),
      body: Container(),
    );
  }
}
