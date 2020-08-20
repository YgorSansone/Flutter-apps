import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "audios/");
  bool primeiraExecucao = true;
  _executar() async{
//    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3";
//    int resultado = await audioPlayer.play(url);
//    if(resultado==1){
//      print("Sucesso");
//    }else{
//      print("erro");
//    }
  if(primeiraExecucao){
    audioPlayer = await audioCache.play("musica.mp3");
    primeiraExecucao = false;
  }else{
     audioPlayer.resume();
  }

  }
  _parar() async{
    int resultado = await audioPlayer.pause();
  }
  _pausar()async{
    int resultado = await audioPlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
//    _executar();
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/executar.png"),
                  onTap: (){
                    _executar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/pausar.png"),
                  onTap: (){
                    _pausar();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/parar.png"),
                  onTap: (){
                    _parar();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


