import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Login.dart';

import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
      primaryColor: Color(0xff075E54),
      accentColor: Color(0xff25D366)
    ),
    debugShowCheckedModeBanner: false,
  ));
}
