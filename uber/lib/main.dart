import 'package:flutter/material.dart';
import 'package:uber/Rotas.dart';
import 'package:uber/telas/Home.dart';
final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
  accentColor: Color(0xff546e7a),
);
void main() {
  runApp(MaterialApp(
    title: "Uber",
    home: Home(),
    theme: temaPadrao,
    // theme: ThemeData.dark(),
    initialRoute: Rotas.ROTA,
    onGenerateRoute: Rotas.gerarRotas,
    debugShowCheckedModeBanner: false,
  ));
}
