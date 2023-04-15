import 'package:collegify/Home%20Page.dart';
import 'package:collegify/login2.dart';
import 'package:collegify/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:collegify/Login Page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => navigate()
    );
  }

  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('Phone');
    print(phone);
    if (phone != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
    else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => otppage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Container(
            width: 360,
            height: 800,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 1.0),
            ),
            child: Column(
                children: <Widget>[
                  Container(
                    width: 360,
                    height: 230,
                  ),
                  Container(
                      width: 228,
                      height: 228,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(3, 3, 3, 1.0),
                        border: Border.all(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          width: 0,),
                        borderRadius: BorderRadius.all(
                            Radius.elliptical(228, 228)),
                      ),
                      child: Image(image: AssetImage('assets/logo.gif') )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                    child: Center(
                      child: Image(image: AssetImage('assets/festfl.png'),width: 240 ),
            )

        )
                ]
            )
        )
    );
  }
}