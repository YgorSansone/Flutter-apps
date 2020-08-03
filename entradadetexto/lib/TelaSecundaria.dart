import 'package:flutter/material.dart';

import 'TelaTerciaria.dart';
class TelaSecundaria extends StatefulWidget {
  String nome;
  TelaSecundaria({this.nome});
  @override
  _TelaSecundariaState createState() => _TelaSecundariaState();
}

class _TelaSecundariaState extends State<TelaSecundaria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Secundaria ${widget.nome}"),
        backgroundColor: Colors.deepOrange,
      ),
      body:Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Ir para a tela principal"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.popAndPushNamed(context, "/");
                }
            ),
            RaisedButton(
                child: Text("Ir para a terceira tela"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaTerciaria(),
                      )
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
