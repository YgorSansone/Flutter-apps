import 'package:flutter/material.dart';
class CriandoAnimacoesBasicas extends StatefulWidget {
  @override
  _CriandoAnimacoesBasicasState createState() => _CriandoAnimacoesBasicasState();
}

class _CriandoAnimacoesBasicasState extends State<CriandoAnimacoesBasicas> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("meu app"),
      ),

      // body: AnimatedContainer(
      //     duration: Duration(seconds: 1),
      //   color: Colors.green,
      //   padding: EdgeInsets.all(10),
      //   height: _status?0 : 100,
      // ),

      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.green,
        padding: EdgeInsets.only(bottom: 100, top: 20),

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 6,
        child: Icon(Icons.add_box),
        onPressed: (){
          setState(() {
            _status = !_status;
          });
        },
      ),
    );
  }
}
