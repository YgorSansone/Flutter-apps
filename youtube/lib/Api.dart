import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';
const CHAVE_YOUTUBE_API = "AIzaSyBYSRl7ifr_cY-S247yi6OT9XGb4s_L3QM";
const CHAVE_CHANNEL_ID = "UCuxfOdbKQy0tgGXcm9sjHiw";
const URL_BASE= "https://www.googleapis.com/youtube/v3/";

class Api{
  pesquisar(String pesquisa) async{
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
    if(response.statusCode == 200){

      Map<String, dynamic> dadosJson = jsonDecode(response.body);
      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();
      for(var video in videos){
        print(video.titulo);
      }

//      print("Resultado " + dadosJson["items"][19]["snippet"]["title"].toString());
    }else{

    }

  }
}