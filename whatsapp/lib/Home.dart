import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController _tabController;
  String _emailUsuario = "";
  Future _recuperarDados()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
//    auth.signOut();
  }
  @override
  void initState() {
    _recuperarDados();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        bottom: TabBar(
          indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "CONVERSAS" ,),
              Tab(text: "STATUS" ,),
              Tab(text: "CHAMADAS" ,),
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Text("CONVERSAS"),
          Text("Status"),
          Text("Contatos"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.message,color: Colors.white,),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}
