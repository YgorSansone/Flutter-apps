import 'package:aprenda_ingles/telas/bichos.dart';
import 'package:aprenda_ingles/telas/numeros.dart';
import 'package:aprenda_ingles/telas/vogais.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
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
        title: Center(
          child: Text("Aprenda Ingles",style:TextStyle(
          ),),
        ),
//        toolbarHeight: 500,
        bottom: TabBar(
          indicatorWeight: 4,
          indicatorColor: Colors.white,
//          labelColor: Colors.deepOrangeAccent,
//          unselectedLabelColor: Colors.lightBlue,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
          controller: _tabController,
          tabs: [
            Tab(
              text: "Bichos",
            ),
            Tab(
              text: "Numeros",
            ),
            Tab(
              text: "Vogais",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
            Bichos(),
            Numeros(),
            Vogais(),
          ]
      ),
    );
  }
}
