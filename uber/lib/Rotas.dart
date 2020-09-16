import 'package:flutter/material.dart';
import 'package:uber/telas/Cadastro.dart';
import 'package:uber/telas/Home.dart';
import 'package:uber/telas/PainelMotorista.dart';
import 'package:uber/telas/PainelPassageiro.dart';

class Rotas {

  static const String ROTA = "/";
  static const String ROTA_CADASTRO = "/cadastro";
  static const String ROTA_P_MOTORISTA = "/p_motorista";
  static const String ROTA_P_PASSAGEIRO = "/p_passageiro";
  static Route<dynamic> gerarRotas(RouteSettings settings){

    switch( settings.name ){
      case ROTA:
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case ROTA_CADASTRO:
        return MaterialPageRoute(builder: (_) => Cadastro());
        break;
      case ROTA_P_MOTORISTA:
        return MaterialPageRoute(builder: (_) => PainelMotorista());
        break;
      case ROTA_P_PASSAGEIRO:
        return MaterialPageRoute(builder: (_) => PainelPassageiro());
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