import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-23.565160, -46.651797),
      zoom: 19
  );
  Set<Marker> _marcadores = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};
  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      _posicaoCamera
    ));
  }

  _carregarMarcadores() {
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
    Set<Polyline> listaPolylines = {};
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
      onTap: () {
        print("aqui !");
      },
    );
    listaPolylines.add(polyline1);
    setState(() {
      _polylines = listaPolylines;
    });
  }

  _recuperarLocalizacaoAtual()  async{

    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    print("localizacao atual: " + position.toString() );
    setState(() {
      _posicaoCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17
      );
      _movimentarCamera();
    });
    _adicionarListenerLocalizacao();
  }
  _adicionarListenerLocalizacao(){
    print("entrou");
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10
    );
    geolocator.getPositionStream( locationOptions )
        .listen((Position position){

      print("localizacao atual: " + position.toString() );

      Marker marcadorUsuario = Marker(
          markerId: MarkerId("marcador-usuario"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
              title: "Meu local"
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta
          ),
          onTap: (){
            print("Meu local clicado!!");
          }
        //rotation: 45
      );

      setState(() {
        //-23.566989, -46.649598
        //-23.568395, -46.648353
        _marcadores.add( marcadorUsuario );
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17
        );
        print("localizacao atual: " + position.toString() );
        _movimentarCamera();

      });

    });
  }
  _recuperarLocalParaEndereco() async{
    List<Placemark> listaEndereco = await Geolocator().
    placemarkFromAddress("Av paulista, 1700");
    print("total: " + listaEndereco.length.toString());
    if(listaEndereco != null && listaEndereco.length >0){
      Placemark endereco = listaEndereco[0];
      String resultado = "\n  administrativeArea: "+ endereco.administrativeArea;
      resultado += "\n  subAdministrativeArea: "+ endereco.subAdministrativeArea;
      resultado += "\n  subAdministrativeArea: "+ endereco.locality;
      resultado += "\n  subAdministrativeArea: "+ endereco.subLocality;
      resultado += "\n  subAdministrativeArea: "+ endereco.thoroughfare;
      resultado += "\n  subAdministrativeArea: "+ endereco.subThoroughfare;
      resultado += "\n  subAdministrativeArea: "+ endereco.postalCode;
      resultado += "\n  subAdministrativeArea: "+ endereco.country;
      resultado += "\n  subAdministrativeArea: "+ endereco.isoCountryCode;
      resultado += "\n  subAdministrativeArea: "+ endereco.position.toString();
      print(resultado);

    }
  }
  _recuperarLocalParalatlong() async{
    List<Placemark> listaEndereco = await Geolocator().
    placemarkFromCoordinates(-23.560859, -46.6570211);
    print("total: " + listaEndereco.length.toString());
    if(listaEndereco != null && listaEndereco.length >0){
      Placemark endereco = listaEndereco[0];
      String resultado = "\n  administrativeArea: "+ endereco.administrativeArea;
      resultado += "\n  subAdministrativeArea: "+ endereco.subAdministrativeArea;
      resultado += "\n  subAdministrativeArea: "+ endereco.locality;
      resultado += "\n  subAdministrativeArea: "+ endereco.subLocality;
      resultado += "\n  subAdministrativeArea: "+ endereco.thoroughfare;
      resultado += "\n  subAdministrativeArea: "+ endereco.subThoroughfare;
      resultado += "\n  subAdministrativeArea: "+ endereco.postalCode;
      resultado += "\n  subAdministrativeArea: "+ endereco.country;
      resultado += "\n  subAdministrativeArea: "+ endereco.isoCountryCode;
      resultado += "\n  subAdministrativeArea: "+ endereco.position.toString();
      print(resultado);

    }
  }
  @override
  void initState() {
    // _recuperarLocalizacaoAtual();
    _recuperarLocalParaEndereco();
    // _recuperarLocalParalatlong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _movimentarCamera,
        child: Icon(Icons.done),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
