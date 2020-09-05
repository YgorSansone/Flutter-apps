import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }
  _movimentarCamera() async{
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-23.563370, -46.652923),
            zoom: 19,
          tilt: 45,
          bearing: 270
        )
      )
    );
  }
  _carregarMarcadores(){
    // Set<Marker> _marcadorLocal = {};
    // Marker marcadorShop = Marker(
    //   markerId: MarkerId("marcador shopping"),
    //   position: LatLng(-23.563370, -46.652923),
    //   infoWindow: InfoWindow(
    //     title: "Shopping"
    //   ),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(
    //     BitmapDescriptor.hueMagenta
    //   ),
    // );
    // Marker marcadorCartorio = Marker(
    //   markerId: MarkerId("marcador cartorio"),
    //   position: LatLng(-23.562868, -46.655874),
    //     infoWindow: InfoWindow(
    //         title: "Cartorio"
    //     ),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(
    //       BitmapDescriptor.hueYellow
    //   ),
    //   // rotation: 45
    //   onTap: (){
    //     print("cartorio");
    //   }
    // );
    // _marcadorLocal.add((marcadorShop));
    // _marcadorLocal.add((marcadorCartorio));
    // setState(() {
    //   _marcadores = _marcadorLocal;
    // });

    //POLYGON
    // Set<Polygon> listaPolygons ={};
    // Polygon polygon1 = Polygon(
    //   polygonId: PolygonId("polygon1"),
    //   fillColor: Colors.transparent,
    //   strokeColor: Colors.green,
    //   strokeWidth: 10,
    //   points: [
    //     LatLng(-23.561816, -46.652044),
    //     LatLng(-23.563625, -46.653642),
    //     LatLng(-23.564786, -46.652226),
    //     LatLng(-23.563085, -46.650531),
    //   ],
    //   consumeTapEvents: true,
    //   onTap: (){
    //     print("aqui !");
    //   },
    // );
    // listaPolygons.add(polygon1);
    // setState(() {
    //   _polygons = listaPolygons;
    // });

    //POLYLINES
    Set<Polyline> listaPolylines ={};
    Polyline polyline1 = Polyline(
      polylineId: PolylineId("polygon1"),
      color: Colors.red,
      width: 15,
      startCap: Cap.roundCap,
      points: [
        LatLng(-23.561816, -46.652044),
        LatLng(-23.563625, -46.653642),
        LatLng(-23.564786, -46.652226),
        LatLng(-23.563085, -46.650531),
      ],
      consumeTapEvents: true,
      onTap: (){
        print("aqui !");
      },
    );
    listaPolylines.add(polyline1);
    setState(() {
      _polylines = listaPolylines;
    });
}
  @override
  void initState() {
    _carregarMarcadores();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _movimentarCamera,
        child: Icon(Icons.done),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436, -46.655005),
            zoom: 16
          ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          polygons: _polygons,
          polylines: _polylines,
        ),
      ),
    );
  }
}
