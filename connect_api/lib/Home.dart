import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "";
  _recuperarcep() async {
    String cep = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String rua = retorno["logradouro"];
    String bairro = retorno["bairro"];
    var _list = retorno.values.toList();
    print(_list[5]);
    print("Resposta: " +bairro);
    setState(() {
      _resultado = "${rua},${bairro}";
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de servicos web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              maxLength: 8,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "digite o cep: ex:00000000"
              ),
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
                onPressed: _recuperarcep,
            ),
            Text("${_resultado}"),
          ],
        ),
      ),
    );
  }
}
