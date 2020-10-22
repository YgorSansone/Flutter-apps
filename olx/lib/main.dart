import 'package:flutter/material.dart';
import 'package:olx/RouteGenerator.dart';
import 'package:olx/view/Anuncios.dart';
import 'package:olx/view/Login.dart';
final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2),
);
void main() {
  runApp(MaterialApp(
    title: "OLX",
    home: Anuncios(),
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}

