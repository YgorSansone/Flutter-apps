import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Combustivel extends StatefulWidget {
  @override
  _CombustivelState createState() => _CombustivelState();
}

class _CombustivelState extends State<Combustivel> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String _Resultado = "";
  void _calcular(){
    double precoAlcool = double.tryParse(_controllerAlcool.text);
    double precoGasolina = double.tryParse(_controllerGasolina.text);
    if(precoAlcool == null || precoAlcool == null){
      setState(() {
        _Resultado = "Preco invalido, digite numeros maiores que 0 e utilizando (.)";
      });
    }else{
      setState(() {
      if(precoAlcool/precoGasolina >= 0.7){
        _Resultado = "Melhor abastecer com gasolina";
      }else{
        _Resultado = "Melhor abastecer com Alcool";
      }
      });
    }

  }

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

          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //img
              //text
              //textfile
              //textfile
              //calcular
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset("imagens/logo.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child:Text("Saiba qual a melhor opcao para abastecimento do seu carro",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Praco Alcool, ex: 1.59"
                  ),
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  controller: _controllerAlcool,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Preco Gasolina, ex: 3.59"
                  ),
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  controller: _controllerGasolina,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text("Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: _calcular,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _Resultado,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
