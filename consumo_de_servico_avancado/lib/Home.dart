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

    Photos  photo = new  Photos(120, null , "Titulo", "https://s3.amazonaws.com/sample-login/companies/avatars/000/000/837/original/Logo-b2w-600x600.png?1520354461", "https://s3.amazonaws.com/sample-login/companies/avatars/000/000/837/original/Logo-b2w-600x600.png?1520354461");
    var corpo = jsonEncode(
      photo.toJson(),
    );

    List<Photos> postagensfotos = List();
    Future<List<Photos>> _recuperarImagens() async{
      http.Response response = await http.get(_urlBase + "photos");
      var dadosJson = jsonDecode(response.body);
      for(var photos in dadosJson){
        Photos p = Photos(photos["albumId"], photos["id"], photos["title"], photos["url"], photos["thumbnailUrl"]);
        postagensfotos.add(p);
      }
      return postagensfotos;
    }

    void printar(response){
      print("Status: ${response.statusCode}");
      if(response.statusCode >= 200 && response.statusCode < 300){
        print("Deu certo");
        print("Resposta: ${response.body}");
      }else{
        print("Deu errado");
      }
    }

    _post() async{
      http.Response response = await http.post(_urlBase + "posts",
          headers:{"Content-type": "application/json; charset=UTF-8"},
          body: corpo);
     printar(response);
    }

    _put() async{
      http.Response response = await http.put(_urlBase + "posts/2",
          headers:{"Content-type": "application/json; charset=UTF-8"},
          body: corpo);
      printar(response);
    }

    _patch() async{
      http.Response response = await http.patch(_urlBase + "posts/2",
          headers:{"Content-type": "application/json; charset=UTF-8"},
          body: corpo);
      printar(response);
    }

    _delete() async{
      http.Response response = await http.patch(_urlBase +"posts/" +"2");
      printar(response);
    }



    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de servico avancado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("Salvar"),
                  onPressed: _post,
                ),
                RaisedButton(
                  child: Text("Editar"),
//                  onPressed: _patch,
                  onPressed: _put,
                ),
                RaisedButton(
                  child: Text("Remover"),
                  onPressed: _delete,
                ),
              ],
            ),
            Expanded(
                child:             FutureBuilder<List<Photos>>(
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
            ),

          ],
        ),
      ),
    );
  }
}
