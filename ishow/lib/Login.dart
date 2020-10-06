import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ishow/BotaoAnimado.dart';
import 'package:ishow/InputCustomizado.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animacaoBluer;
  Animation<double> _animacaoFade;
  Animation<double> _animacaoSize;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animacaoBluer = Tween<double>(begin: 5, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _animacaoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));

    _animacaoSize = Tween<double>(begin: 0, end: 500).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 20;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animacaoBluer,
                builder: (context, widget) {
                  return Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("imagens/fundo.png"),
                              fit: BoxFit.fill)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _animacaoBluer.value,
                            sigmaY: _animacaoBluer.value),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                                child: Image.asset("imagens/detalhe1.png"),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: FadeTransition(
                                opacity: _animacaoFade,
                                child: Image.asset("imagens/detalhe2.png"),
                              ),
                            )
                          ],
                        ),
                      ));
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _animacaoSize,
                      builder: (context, widget) {
                        return Container(
                          width: _animacaoSize.value,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 15,
                                    spreadRadius: 4)
                              ]),
                          child: Column(
                            children: [
                              InputCustomizado(
                                hint: "Email",
                                obscure: false,
                                icon: Icon(Icons.person),
                              ),
                              InputCustomizado(
                                hint: "Senha",
                                obscure: true,
                                icon: Icon(Icons.lock),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BotaoAnimado(
                      controller: _controller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeTransition(
                      opacity: _animacaoFade,
                      child: Text(
                        "Esqueci a minha senha",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 100, 127, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
