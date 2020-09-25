import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/model/Usuario.dart';
import 'package:uber/util/StatusRequisicao.dart';
import 'package:uber/util/UsuarioFirebase.dart';
import '../Rotas.dart';

class Corrida extends StatefulWidget {
  String idRequisicao;
  Corrida(this.idRequisicao);
  @override
  _CorridaState createState() => _CorridaState();
}

class _CorridaState extends State<Corrida> {
  List<String> itensMenu = [
    "Deslogar"
  ];
  bool _exibirCaixaEnderecoDestino = true;
  Map<String, dynamic> _dadosRequisicao;
  String _textoBotao = "Aceitar corrida";
  Color _corBotao = Color(0xff1ebbd8);
  Function _funcaoBotao;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-23.563999, -46.653256)
  );
  Set<Marker> _marcadores = {};
  Position _localMotorista;

  _alterarBotaoPrincipal(String texto, Color cor, Function funcao){
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }
  _deslogarUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(context, Rotas.ROTA);

  }

  _escolhaMenuItem( String escolha ){
    switch( escolha ){
      case "Deslogar" :
        _deslogarUsuario();
        break;
    }
  }
  _statusAguardando(){

    _alterarBotaoPrincipal(
        "Aceitar corrida",
        Color(0xff1ebbd8), (){
          _aceitarCorrida();
        });
  }
  _statusAcaminho(){
    _alterarBotaoPrincipal(
        "A caminho do passageiro",
        Colors.grey,
    null);
  }
  _aceitarCorrida()async{
    Usuario motorista = await UsuarioFirebase.getDadosUsuarioLogado();
    motorista.latitude = _localMotorista.latitude;
    motorista.longitude = _localMotorista.longitude;
    Firestore db = Firestore.instance;
    String idRequisicao = _dadosRequisicao["id"];
    db.collection("requisicoes")
    .document(idRequisicao).updateData({
      "motorista" : motorista.toMap(),
      "status" : StatusRequisicao.A_CAMINHO,
    }).then((_) {
      //atualizar requisicao
      //salvar requisicao
      String idPassageiro = _dadosRequisicao["passageiro"]["idUsuario"];
      db.collection("requisicao_ativa")
      .document(idPassageiro).updateData({
        "status" : StatusRequisicao.A_CAMINHO,
      });
      String idMotorista = motorista.idUsuario;
      db.collection("requisicao_ativa_motorista")
          .document(idMotorista).setData({
        "id_requisicao" : idRequisicao,
        "id_usuario" : idMotorista,
        "status" : StatusRequisicao.A_CAMINHO,
      });
    });
  }

  _onMapCreated( GoogleMapController controller ){
    _controller.complete( controller );
  }

  _adicionarListenerLocalizacao(){
    try {
      var geolocator = Geolocator();
      var locationOptions = LocationOptions(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10
      );

      geolocator.getPositionStream(locationOptions).listen((Position position) {
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 19
        );
        setState(() {
          _exivirMarcadorPassageiro(position);
          _movimentarCamera(_posicaoCamera);
          _localMotorista = position;
        });
      });
    }catch (e) {
      print("erro " + e);
    }
  }
  _movimentarCamera( CameraPosition cameraPosition ) async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            cameraPosition
        )
    );

  }
  _exivirMarcadorPassageiro(Position local) async{
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio),
        "imagens/motorista.png"
    ).then((BitmapDescriptor icone){
      Marker marcadorPassageiro = Marker(
          markerId: MarkerId("marcador-motorista"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(
              title: "Meu local"
          ),
          icon: icone
      );
      setState(() {
        _marcadores.add(marcadorPassageiro);
      });
    });

  }
  _recuperarRequisicao()async{
    String idRequisicao = widget.idRequisicao;
    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db
    .collection("requisicoes")
    .document(idRequisicao)
    .get();
    _dadosRequisicao = documentSnapshot.data;
    _adicionarListenerRequisicao();
  }
  _adicionarListenerRequisicao()async{
    Firestore db = Firestore.instance;
    String idRequisicao = _dadosRequisicao["id"];
    await db.collection("requisicoes")
    .document(idRequisicao).snapshots().listen((snapshot) {
      if(snapshot.data != null){
        Map<String,dynamic> dados = snapshot.data;
        String status = dados["status"];
        switch(status){
          case StatusRequisicao.AGUARDANDO:
            _statusAguardando();
            break;
          case StatusRequisicao.A_CAMINHO:
            _statusAcaminho();
            break;
          case StatusRequisicao.VIAGEM:
            break;
          case StatusRequisicao.FINALIZADA:
            break;
          case StatusRequisicao.CANCELADA:
            break;
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _adicionarListenerLocalizacao();
    // _adicionarListenerRequisicaoAtiva();
    //recuperar requisicao e
    //adicionar listener para mudanca de status
    _recuperarRequisicao();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel corrida"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){

              return itensMenu.map((String item){

                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );

              }).toList();

            },
          )
        ],
      ),
      body: Container(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _posicaoCamera,
                onMapCreated: _onMapCreated,
                // myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers:_marcadores ,
                //-23,559200, -46,658878
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: Platform.isIOS ? EdgeInsets.fromLTRB(20, 10, 20, 25):EdgeInsets.all(10) ,
                  child: RaisedButton(
                    child: Text(
                      _textoBotao,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: _corBotao,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: _funcaoBotao,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
