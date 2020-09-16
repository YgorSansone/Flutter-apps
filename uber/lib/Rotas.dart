import 'package:flutter/material.dart';
import 'package:uber/telas/Cadastro.dart';
import 'package:uber/telas/Home.dart';

class Rotas {

  static const String ROTA = "/";
  static const String ROTA_LOGIN = "/login";
  static const String ROTA_CADASTRO = "/cadastro";
  static Route<dynamic> gerarRotas(RouteSettings settings){

    switch( settings.name ){
      case ROTA:
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case ROTA_CADASTRO:
        return MaterialPageRoute(builder: (_) => Cadastro());
        break;
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(title: Text("Tela não encontrada!"),),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
          );
        }
    );

  }

}