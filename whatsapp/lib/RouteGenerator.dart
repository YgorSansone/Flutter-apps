import 'package:flutter/material.dart';
import 'package:whatsapp/Cadastro.dart';
import 'package:whatsapp/Login.dart';
import 'package:whatsapp/telas/AbaContatos.dart';

import 'Home.dart';
class RouteGenerator{
  static const String ROTA_HOME = "/home";
  static const String ROTA_LOGIN = "/login";
  static const String ROTA_CADASTRO = "/cadastro";
  static const String ROTA_CONTATO = "/contato";
  static const String ROTA = "/";
  static Route<dynamic>generateRoute(RouteSettings settings){
    switch(settings.name){
      case ROTA:
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case ROTA_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case ROTA_CADASTRO:
        return MaterialPageRoute(builder: (_) => Cadastro());
      break;
      case ROTA_HOME:
        return MaterialPageRoute(builder: (_) => Home());
      break;
      case ROTA_CONTATO:
        return MaterialPageRoute(builder: (_) => AbaContatos());
      break;
      default:
        _erroRota();
    }
  }
  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text("Tela nao encontrada"),),
          body: Center(
            child:Text("Tela nao encontrada"),
          ),
        );
      }
    );
  }
}