import 'package:entradadetexto/TelaSecundaria.dart';
import 'package:entradadetexto/main.dart';
import 'package:flutter/material.dart';
class TelaTerciaria extends StatefulWidget {
  @override
  _TelaTerciariaState createState() => _TelaTerciariaState();
}

class _TelaTerciariaState extends State<TelaTerciaria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela TelaTerciaria"),
        backgroundColor: Colors.blue,
      ),
      body:Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Ir para a segunda tela"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaSecundaria(),
                      )
                  );
                }
            ),
            RaisedButton(
                child: Text("voltar uma"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaPrincipal(),
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
