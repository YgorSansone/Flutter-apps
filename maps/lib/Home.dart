import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas"),),
      body: Container(
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 16
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
