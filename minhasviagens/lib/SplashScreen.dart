import 'dart:async';

import 'package:flutter/material.dart';

import 'Home.dart';
class SlpashScreen extends StatefulWidget {
  @override
  _SlpashScreenState createState() => _SlpashScreenState();
}

class _SlpashScreenState extends State<SlpashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_)=> Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff0066cc),
        padding: EdgeInsets.all(60),
        child: Center(
          child: Image.asset("imagens/logo.png"),
        ),
      ),
    );
  }
}
