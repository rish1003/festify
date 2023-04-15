import 'package:collegify/Home%20Page.dart';
import 'package:collegify/login2.dart';
import 'package:collegify/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:collegify/Login Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapView1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapView1();
}
class _MapView1 extends State<MapView1> {
  String? _phoneNumber="";
  String _verificationId="";
  String _smsCode="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF751877),
        title: const Text(
          'COLLEGIFY',
          style: TextStyle(
            fontFamily: 'Istok Web',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
          },
        ),
      ),

    );
  }

}