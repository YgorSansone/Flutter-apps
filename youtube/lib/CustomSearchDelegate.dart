import 'package:flutter/material.dart';
class CustomSearchDelegate extends SearchDelegate<String>{

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
        icon: Icon(Icons.mic),
        onPressed: (){

        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return  IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//    List<String> lista = List();
//    if(query.isNotEmpty){
//      lista = [
//        "Android", "teste", "Jogos"].where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();
//      return ListView.builder(
//        itemCount: lista.length,
//          itemBuilder: (context, index){
//            return ListTile(
//              title: Text(lista[index]),
//              onTap: (){
//                close(context, index.toString());
//              },
//            );
//          });
//    }else{
//      return Center(
//        child: Text("Nenhum resultado para a pesquisa"),
//      );
//    }
  return Container();
  }

}