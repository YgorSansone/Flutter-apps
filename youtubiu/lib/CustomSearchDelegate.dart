import 'package:flutter/material.dart';
  class CustomSearchDelegate extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
  return [
  IconButton(
  icon: Icon(Icons.clear),
  onPressed: (){
  query = "";
  },
  ),
    IconButton(
      icon: Icon(Icons.keyboard_voice),
      onPressed: (){
      },
    ),
  ];
  }

  @override
  Widget buildLeading(BuildContext context) {
  return IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: (){
    close(context, "");
    },
  );
  }

  @override
  Widget buildResults(BuildContext context) {
  //print("resultado: pesquisa realizada");
  close(context, query );
  return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  //print("resultado: digitado " + query );

//  return Container();

    List<String> lista = List();

    if( query.isNotEmpty ){

      lista = [
        "Android", "Android navegação", "ios", "jogos","iphone","leon","nilce","playstion","GAGA"
      ].where(
          (texto) => texto.toLowerCase().startsWith( query.toLowerCase() )
      ).toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index){

            return ListTile(
              onTap: (){
                close(context, lista[index] );
              },
              title: Text( lista[index] ),
            );

          }
      );

    }else{
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }




  }



  }