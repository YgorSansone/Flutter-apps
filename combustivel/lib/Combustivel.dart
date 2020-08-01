import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Combustivel extends StatefulWidget {
  @override
  _CombustivelState createState() => _CombustivelState();
}

class _CombustivelState extends State<Combustivel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alcool ou gasolina",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        )
        ),
        backgroundColor: Colors.blue,
      ),
      body:Container(
          child: Column(
          //img
          //text
          //textfile
          //textfile
          //calcular
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32),
              child: Image.asset(""),
            ),
            Text("Saiba qual a melhor opcao para abastecimento do seu carro",
              style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 25,
                fontStyle: FontStyle.normal,
            ),
            ),
            TextField(

            ),
            TextField(

            ),
            RaisedButton(
              child: Text("Calcular",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
