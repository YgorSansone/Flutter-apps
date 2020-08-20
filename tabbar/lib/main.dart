import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabbar/paginas/primeira.dart';
import 'package:tabbar/paginas/segunda.dart';
import 'package:tabbar/paginas/terceira.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  )
  );
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this,
      initialIndex: 1,
    );
  }
  @override
  void dispose(){
   super.dispose();
   _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abas"),
        bottom: TabBar(
          controller: _tabController,
            tabs: [
              Tab(
                text: "home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "Email",
                icon: Icon(Icons.email),
              ),
              Tab(
                text: "Conta",
                icon: Icon(Icons.account_circle),
              ),
            ],),
      ),
      body:TabBarView(
        controller: _tabController,
          children: [
            Primeira(),
            Segunda(),
            Terceira(),
          ]
      )
    );
  }
}
