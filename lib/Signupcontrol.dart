import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Home%20Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signupcontrol extends GetxController {
  static signupcontrol get instance => Get.find();
  var verificationid = ''.obs;
  Future<void> verifyPhone (ph) async
  {
    print(ph);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: ph,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.offAll(HomePage());
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent:( verificationId,resendtk){
          this.verificationid.value = verificationId;

        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationid.value = verificationId;

        });
  }
  void signin(ph,l1) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Phone', ph);
    prefs.setStringList('Favs', l1);
    Get.offAll(const HomePage());
  }

  void  verifyOTP (otp,ph) async{
    var credential = await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationid.value, smsCode: otp));
    final datab = await FirebaseFirestore.instance.collection('users');
    List<String> l1 = [];
    var data = {'UID': ph,'Name':'Rishika','Favs':l1};
    datab.add(data);
    credential.user != null ? signin(ph,l1):false;
  }
}