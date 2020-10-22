import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/view/Anuncios.dart';
import 'package:olx/view/Login.dart';

class RouteGenerator{
  // static const String ROTA_HOME = "/home";
  static const String ROTA_LOGIN = "/login";
  static const String ROTA_MEUS_ANUNCIOS = "/meus_anuncios";
  static const String ROTA = "/";
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case ROTA:
        return MaterialPageRoute(builder: (_) => Anuncios());
        break;
      case ROTA_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
        break;

      default:
        _erroRota();
    }
  }
  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela nao encontrada"),
        ),
        body: Center(
          child: Text("Tela nao encontrada"),
        ),
      );
    });
  }
}