import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
class Numeros extends StatefulWidget {
  @override
  _NumerosState createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  AudioCache _audioCachenumeros = AudioCache(prefix: "audios/");
  _executar(String nomeAudio) async {
    await _audioCachenumeros.play( nomeAudio + ".mp3");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioCachenumeros.loadAll([
      "1.mp3","2.mp3","3.mp3","4.mp3","5.mp3","6.mp3",
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
//      scrollDirection: Axis.horizontal,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio* 2,
        children: [
          GestureDetector(
            onTap: (){
              _executar("1");
            },
            child: Image.asset("assets/imagens/1.png"),
          ),
          GestureDetector(
            onTap: (){
              _executar("2");
            },
            child: Image.asset("assets/imagens/2.png"),
          ),
          GestureDetector(
            onTap: (){
              _executar("3");
            },
            child: Image.asset("assets/imagens/3.png"),
          ),
          GestureDetector(
            onTap: (){
              _executar("4");
            },
            child: Image.asset("assets/imagens/4.png"),
          ),
          GestureDetector(
            onTap: (){
              _executar("5");
            },
            child: Image.asset("assets/imagens/5.png"),
          ),
          GestureDetector(
            onTap: (){
              _executar("6");
            },
            child: Image.asset("assets/imagens/6.png"),
          ),
        ],
      ),
    );
  }
}
