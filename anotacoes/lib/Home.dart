import 'dart:ffi';

import 'package:anotacoes/helper/AnotacoesHelper.dart';
import 'package:anotacoes/model/Anotacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloControler = TextEditingController();
  TextEditingController _descricaoControler = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = List<Anotacao>();
  _exibirTelaCadastro(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Adicionar anotacoes"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tituloControler,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Titulo",
                    hintText: "Digite titulo ..."
                  ),
                ),
                TextField(
                  controller: _descricaoControler,
                  decoration: InputDecoration(
                      labelText: "Descricao",
                      hintText: "Digite Descricao ..."
                  ),
                )
              ],
            ),
          actions: [
            FlatButton(
                onPressed: ()=> Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.close,
                    color: Colors.red,),
                    Text("Cancelar")
                  ],
                )
            ),

            FlatButton(
                onPressed: (){
                  _salavarAnotacao();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                  Icon(Icons.done,
                  color: Colors.purple,),
                    Text("Salvar"),
                  ],
                  )
            ),
          ],
         );
    });
  }
  _recuperarAnotacao() async{
    _anotacoes.clear();
    List anotacoesRecuperadas = await _db.recuperarAnotacao();
    List<Anotacao> listaTemporaria = List<Anotacao>();
    for(var item in anotacoesRecuperadas){
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = null;
  }
  _salavarAnotacao () async{
    String titulo = _tituloControler.text;
    String descricao = _descricaoControler.text;
    Anotacao anotacao = Anotacao(titulo,descricao,DateTime.now().toString());
    int resultado = await _db.salavarAnotacao(anotacao);
    print("salvar :" +resultado.toString());
    _tituloControler.clear();
    _descricaoControler.clear();
    _recuperarAnotacao();
  }
  _formatarData(String data){
    initializeDateFormatting("pt_BR");
//    var formatador = DateFormat("d/M/y");
    var formatador = DateFormat.yMd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }
  @override
  void initState() {
    _recuperarAnotacao();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotacoes"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: _anotacoes.length,
                  itemBuilder: (context, index){
                  final anotacao = _anotacoes[index];
                  return Card(
                    child: ListTile(
                      title: Text(anotacao.titulo),
                      subtitle: Text("${_formatarData(anotacao.data)} - ${anotacao.descricao}"),
                    ),
                  );
                  })
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro();
        },
      ),
    );
  }
}
