import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCampo = TextEditingController();
  String textosalvo = "Nada salvo!";
  _salvar() async{
    textosalvo = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Nome", textosalvo);
    print(textosalvo);
  }
  _ler() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       textosalvo =  prefs.getString("Nome")?? "Nada salvo!";
    });
    
  }
  _remover() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("Nome");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulacao de dados"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Text(textosalvo,style: TextStyle(
                fontSize: 22,
              ),),
              TextField(
                controller: _controllerCampo,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Digite algo"
                ),
              ),
              Row(
                children: [
                  RaisedButton(onPressed: _salvar,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text("Salvar",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                    color: Colors.blue,),
                  RaisedButton(onPressed: _ler,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text("Ler",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    color: Colors.blue,),
                  RaisedButton(onPressed: _remover,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text("Remover",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    color: Colors.blue,),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
