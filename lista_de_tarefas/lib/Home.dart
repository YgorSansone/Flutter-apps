import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Text("a"),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            print("apertou");
          }
      ),
//      bottomNavigationBar: ,
    );
  }
}
