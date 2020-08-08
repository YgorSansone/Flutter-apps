import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/Video.dart';
const CHAVE_YOUTUBE_API = "AIzaSyCId6ljxdCDfDtRmqRSAtqNZM8Q_h-Zihw";
const CHAVE_CHANNEL_ID = "UCuxfOdbKQy0tgGXcm9sjHiw";
const URL_BASE= "https://www.googleapis.com/youtube/v3/";

class Api{
 Future<List<Video>> pesquisar(String pesquisa) async{
    http.Response response = await http.get(
        URL_BASE + "search"
                "?part=snippet"
                "&type=video"
                "&maxResults=20"
                "&order=date"
                "&key=$CHAVE_YOUTUBE_API"
                "&channelId=$CHAVE_CHANNEL_ID"
                "&q=$pesquisa"
    );
    print(response.statusCode);
    if(response.statusCode == 200){

      Map<String, dynamic> dadosJson = jsonDecode(response.body);
      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();
//      print("Resultado " + dadosJson["items"][19]["snippet"]["title"].toString());
      return videos;


    }else{

    }

  }
}