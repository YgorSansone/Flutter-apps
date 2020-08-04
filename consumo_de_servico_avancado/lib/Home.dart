import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'Post.dart';
import 'photos.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    String _urlBase ="https://jsonplaceholder.typicode.com/";

   Future<List<Post>> _recuperarPostagens() async{
     http.Response response = await http.get(_urlBase + "posts");
     var dadosJson = jsonDecode(response.body);
     List<Post> postagens = List();
     for(var post in dadosJson){
       Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
       postagens.add(p);
     }
     return postagens;
    }
    Future<List<Photos>> _recuperarImagens() async{
      http.Response response = await http.get(_urlBase + "photos");
      var dadosJson = jsonDecode(response.body);
      List<Photos> postagensfotos = List();
      for(var photos in dadosJson){
        Photos p = Photos(photos["albumId"], photos["id"], photos["title"], photos["url"], photos["thumbnailUrl"]);
        postagensfotos.add(p);
      }
      return postagensfotos;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de servico avancado"),
      ),
      body: FutureBuilder<List<Photos>>(
        future: _recuperarImagens(),
        builder: (context, snapshot){
          switch( snapshot.connectionState ){
            case ConnectionState.none :
              print("None");
              break;
            case ConnectionState.waiting :
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              print("done");
              if(snapshot.hasError){
                print("erro");
              }else{
                print("lista");
                return ListView.builder(
                  itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                    List<Photos> lista = snapshot.data;
                    Photos post = lista[index];
                    return Column(
                      children: <Widget>[
                      ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.id.toString()),
                      ),
                        Image.network(post.url),
                        Image.network(post.thumbnailUrl),
                      ],
                    );
                    }
                );
              }
              break;
          }
          return Center(
            child: Text(" "),
          );
        },
      ),
    );
  }
}
