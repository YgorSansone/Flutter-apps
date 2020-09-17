import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/Rotas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
class PainelPassageiro extends StatefulWidget {
  @override
  _PainelPassageiroState createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {
  List<String> itensMenu = ["Deslogar"];
  Completer<GoogleMapController> _controller = Completer();
  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Rotas.ROTA, (_) => false);
  }
  _escolharMenuItem(String escolha) {
    switch(escolha){
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }
  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel passageiro"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolharMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(-23.563999, -46.653256),
              zoom: 16
            ),
          onMapCreated:_onMapCreated,
        ),
      ),
    );
  }
}
