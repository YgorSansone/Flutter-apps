import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Completer<GoogleMapController> _controller = Completer();
  Firestore _db = Firestore.instance;
  Set<Marker> _marcadores = {};
  CameraPosition _posicaoCamera =
      CameraPosition(target: LatLng(-23.562436, -46.6555005), zoom: 18);
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  _addMarcador(LatLng latLng) async{
    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if(listaEnderecos != null && listaEnderecos.length >0){
      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;
      print("Local clicado: " + latLng.toString());
      Marker marcador = Marker(
          markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(title: rua));
      setState(() {
        _marcadores.add(marcador);
        //salvar no firebase
        Map<String,dynamic> viagem = Map();
        viagem["titulo"] = rua;
        viagem["latitute"] = latLng.latitude;
        viagem["longitude"] = latLng.longitude;
        _db.collection("viagens")
        .add(viagem);
      });
    }

  }

  _adicionarListenerLocalizacao() async {
    var geolocation = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);
    geolocation.getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 18);
        _movimentarCamera();
      });
    });
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_posicaoCamera));
  }

  @override
  void initState(){
    super.initState();
    _adicionarListenerLocalizacao();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: _posicaoCamera,
          mapType: MapType.normal,
          markers: _marcadores,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          onLongPress: _addMarcador,
        ),
      ),
    );
  }
}
