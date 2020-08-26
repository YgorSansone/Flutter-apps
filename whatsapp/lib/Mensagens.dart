import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Usuario.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;
  Mensagens(this.contato);
  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  TextEditingController _controllerMensagem = TextEditingController();
  String _mensagemerro = "";

  _enviarMensagem() {}
  _enviarFoto() {}
  var caixaMensagem = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              radius: 22,
              backgroundImage: NetworkImage(widget.contato.url),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(widget.contato.nome),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Imagens/bg.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text("listview"),
              Container(
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
                                borderRadius: BorderRadius.circular(32)
                            ),
                          prefixIcon: IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: _enviarFoto)
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Color(0xff075E54),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      mini: true,
                      // onPressed: _enviarMensagem,
                    ),
                  ],
                ),
              ),

              //LISTVIEW
              //CAIXA DE MENSAGEM
            ],
          ),
        )),
      ),
    );
  }
}
