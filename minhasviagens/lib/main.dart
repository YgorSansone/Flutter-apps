import 'package:flutter/material.dart';
import 'package:minhasviagens/Home.dart';
import 'package:minhasviagens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: SlpashScreen(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

