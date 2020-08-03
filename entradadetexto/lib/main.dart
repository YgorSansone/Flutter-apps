import 'package:entradadetexto/EntradaRadioButton.dart';
import 'package:entradadetexto/EntradaSlider.dart';
import 'package:entradadetexto/TelaSecundaria.dart';
import 'package:entradadetexto/TelaTerciaria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EntradaCheckbox.dart';
import 'EntradaSwitch.dart';
void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    home: TelaPrincipal(),
    routes: {
      "/secundaria": (context)=> TelaSecundaria(),
    },
  ));
}
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String nome = "ygor";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Principal"),
        backgroundColor: Colors.green,
      ),
      body:Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Ir para a segunda tela"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.pushNamed(context, "/secundaria");
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
