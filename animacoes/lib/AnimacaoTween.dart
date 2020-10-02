import 'package:flutter/material.dart';
class AnimacaoTween extends StatefulWidget {
  @override
  _AnimacaoTweenState createState() => _AnimacaoTweenState();
}

class _AnimacaoTweenState extends State<AnimacaoTween> {
  @override
  Widget build(BuildContext context) {
    return Center(

      child: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        tween: Tween<double>(begin: 0, end: 6.28),
        builder: (BuildContext context, double angulo, Widget widget){
          return Transform.rotate(
            angle: angulo,
            child: Image.asset("imagens/logo.png"),
          );
        },
      ),

    );
  }
}
