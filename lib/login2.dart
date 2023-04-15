import 'package:collegify/main.dart';
import 'package:collegify/Home Page.dart';
import 'package:collegify/Signupcontrol.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
class otppage extends StatefulWidget{
  const otppage({Key ? key} ):  super (key :key);
  State<otppage>createState() => otpState();

}
class otpState extends State<otppage> {

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final phController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blueGrey),
      borderRadius: BorderRadius.circular(20),
    ),

  );
  String ph = "+91";



  @override
  Widget build(BuildContext context) {
    var signupconrol = Get.put(signupcontrol());
    var otp;

    return Scaffold(
        backgroundColor: Colors.black38,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                height: 275,
              ),
              TextField(
                controller: phController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),
                  ),
                  labelText: 'Ph.no : +91',

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,

                  controller: _pinPutController,

                  pinAnimationType: PinAnimationType.fade,
                  onSubmitted: (pin) async{
                    otp = pin;
                  },
                ),
              ),

              OutlinedButton(onPressed: () async {

                ph = "+91"+phController.text.trim();
                signupcontrol.instance.verifyPhone(ph);
              },
                child: Text(
                    'Get OTP.'
                ),
              ),
              ElevatedButton(onPressed: () async{
                signupcontrol.instance.verifyOTP(_pinPutController.text,ph);
              }, child:
              Text( "Sign In"),
              ),
            ],
          ),
        )
    );
  }
}