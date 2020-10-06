import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ishow/InputCustomizado.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _animacaoBluer;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );
    _animacaoBluer = Tween<double>(
      begin: 5,
      end: 0
    ).animate(CurvedAnimation(
        parent: _controller,
    curve: Curves.ease));
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animacaoBluer ,
                builder: (context, widget){
                  return Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("imagens/fundo.png"),
                              fit: BoxFit.fill)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _animacaoBluer.value,
                            sigmaY: _animacaoBluer.value
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10,
                              child: Image.asset("imagens/detalhe1.png"),
                            ),
                            Positioned(
                              left: 50,
                              child: Image.asset("imagens/detalhe2.png"),
                            )
                          ],
                        ),
                      )
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text("Entrar", style: TextStyle(
                            color: Colors.white,fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 100, 127, 1),
                              Color.fromRGBO(255, 123, 145, 1),
                            ]
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Esqueci a minha senha",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 100, 127, 1),
                          fontWeight: FontWeight.bold),
                    )
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
