import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/Rotas.dart';
import 'package:uber/model/Destino.dart';
import 'package:uber/model/Requisicao.dart';
import 'package:uber/model/Usuario.dart';
import 'package:uber/util/StatusRequisicao.dart';
import 'package:uber/util/UsuarioFirebase.dart';

class PainelPassageiro extends StatefulWidget {
  @override
  _PainelPassageiroState createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {
  TextEditingController _controllerDestino = TextEditingController(text: "av. paulista, 807");
  List<String> itensMenu = [
   "Deslogar"
  ];
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-23.563999, -46.653256)
  );
  Set<Marker> _marcadores = {};
  String _idRequisicao;
  bool _exibirCaixaEnderecoDestino = true;
  String _textoBotao = "Chamar Uber";
  Color _corBotao = Color(0xff1ebbd8);
  Function _funcaoBotao;
  _alterarBotaoPrincipal(String texto, Color cor, Function funcao){
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }
  _statusUberNaoChamado(){
    _exibirCaixaEnderecoDestino = true;
    _alterarBotaoPrincipal(
        "Chamar Uber",
        Color(0xff1ebbd8),
        (){
          _chamaruber();
        });
  }
  _statusAguardando(){
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
        "Cancelar",
        Colors.red,
            (){
              _cancelarUber();
        });
  }
  _statusAcaminho(){
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
        "Motorista a caminho",
        Colors.grey,
            (){
        });
  }
  _cancelarUber() async{
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();
    Firestore db = Firestore.instance;
    db.collection("requisicoes")
    .document( _idRequisicao).updateData({
      "status": StatusRequisicao.CANCELADA
    }).then((_){
      db.collection("requisicao_ativa")
          .document(firebaseUser.uid)
          .delete();
    });

  }
  _adicionarListenerRequisicaoAtiva() async{
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();
    Firestore db = Firestore.instance;
    await db.collection("requisicao_ativa")
    .document(firebaseUser.uid)
    .snapshots()
    .listen((snapshot) {
      if(snapshot.data != null){
        Map<String, dynamic> dados = snapshot.data;
        String status = dados["status"];
        setState(() {
          _idRequisicao = dados["id_requisicao"];
        });
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

      }else{
        _statusUberNaoChamado();
      }
    });
  }
  _salvarRequisicao(Destino destino) async{
    Usuario passageiro = await UsuarioFirebase.getDadosUsuarioLogado();
    Requisicao requisicao = Requisicao();
    requisicao.destino = destino;
    requisicao.passageiro = passageiro;
    requisicao.status = StatusRequisicao.AGUARDANDO;

    Firestore db = Firestore.instance;
    db.collection("requisicoes")
    .document(requisicao.id)
    .setData(requisicao.toMap());

    Map<String, dynamic> dadosRequisicaoAtiva = {};
    dadosRequisicaoAtiva["id_requisicao"] = requisicao.id;
    dadosRequisicaoAtiva["id_usuario"] = passageiro.idUsuario;
    dadosRequisicaoAtiva["status"] = StatusRequisicao.AGUARDANDO;
    db.collection("requisicao_ativa")
    .document(passageiro.idUsuario)
    .setData(dadosRequisicaoAtiva);
  }
  _chamaruber()async{
    String enderecoDestino = _controllerDestino.text;
    if(enderecoDestino.isNotEmpty){
      List<Placemark> listaEnderecos = await Geolocator().placemarkFromAddress(enderecoDestino);
      Placemark endereco = listaEnderecos[0];
      Destino destino = Destino();
      destino.cidade = endereco.administrativeArea;
      destino.cep = endereco.postalCode;
      destino.bairro = endereco.subLocality;
      destino.rua = endereco.thoroughfare;
      destino.numero = endereco.subThoroughfare;

      destino.latitude = endereco.position.latitude;
      destino.longitude = endereco.position.longitude;
      String enderecoConfirmacao;
      enderecoConfirmacao = "\n Cidade: " +destino.cidade;
      enderecoConfirmacao += "\n Rua: " +destino.rua + ", " +destino.numero;
      enderecoConfirmacao += "\n Bairro: " +destino.bairro;
      enderecoConfirmacao += "\n Cep: " +destino.cep;
      showDialog(
          context: context,
        builder: (context){
            return AlertDialog(
              title: Text("Confirmacao do endereco"),
              content: Text(enderecoConfirmacao),
              contentPadding: EdgeInsets.all(16),
              actions: [
                FlatButton(
                  child: Text("Cancelar", style: TextStyle(color: Colors.red),),
                  onPressed: () =>Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Confirmar", style: TextStyle(color: Colors.green),),
                  onPressed: () {
                    //salvar_requisicao
                    _salvarRequisicao(destino);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
        }
      );
    }
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
        });
      });
    }catch (e) {
    print("erro " + e);
    }
  }

  _recuperaUltimaLocalizacaoConhecida() async {

    Position position = await Geolocator()
        .getLastKnownPosition( desiredAccuracy: LocationAccuracy.high );

    setState(() {
      if( position != null ){
        _exivirMarcadorPassageiro(position);
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 10
        );

        _movimentarCamera( _posicaoCamera );

      }
    });

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
        "imagens/passageiro.png"
    ).then((BitmapDescriptor icone){
      Marker marcadorPassageiro = Marker(
          markerId: MarkerId("marcador-passageiro"),
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

  @override
  void initState() {
    super.initState();
    // _recuperaUltimaLocalizacaoConhecida();
    _adicionarListenerLocalizacao();
    _adicionarListenerRequisicaoAtiva();
    // _statusUberNaoChamado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel passageiro"),
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
              markers:_marcadores ,
              //-23,559200, -46,658878
            ),

          Visibility(
            visible: _exibirCaixaEnderecoDestino,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.black54
                      ),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20),
                              width: 10,
                              height: 25,
                              child: Icon(Icons.location_on, color:  Colors.white,),
                            ),
                            hintText: "Meu local",
                            border: InputBorder.none,

                            contentPadding: EdgeInsets.only(left: 10,top: 0)
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.black54
                      ),
                      child: TextField(
                        controller:  _controllerDestino,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 10,
                            height: 25,
                            child: Icon(Icons.local_taxi, color:  Colors.white,),
                          ),
                          hintText: "Digite o destino",
                          border: InputBorder.none,
                          hoverColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 10,top: 0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
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