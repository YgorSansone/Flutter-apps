import 'package:flutter/material.dart';
class Resultado extends StatefulWidget {
  String valor;
  Resultado(this.valor);
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
//      backgroundColor: Color.fromRGBO(255, 204, 128, 0.9),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("imagens/moeda_${widget.valor}.png"),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset("imagens/botao_voltar.png"),
            ),
          ],

        ),
      ),
    );
  }
}
