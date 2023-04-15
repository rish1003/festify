import 'package:collegify/Home%20Page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _phoneNumber="";
  String _verificationId="";
  String _smsCode="";

  Future<void> verifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        print('Verified');
      });
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception) {
      setState(() {
        print('${exception.message}');
      });
    };

    final PhoneCodeSent codeSent = (String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
      setState(() {
        print('Code sent to $_phoneNumber');
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        print('Time out');
      });
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );
    final User? user = (await _auth.signInWithCredential(credential)).user;
    final User currentUser = await _auth.currentUser!;
    assert(user!.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        print('Successfully signed in, uid: ' + user.uid);
      } else {
        print('Sign in failed');
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F0F),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF751877),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              width: 40.0,
              height: 40.0,
              child: Image.asset('lib/assets/logo.png'),
            ),
          ],
          title: const Text(
            'COLLEGIFY',
            style: TextStyle(
                fontFamily: 'Istok Web',
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                fillColor: Colors.grey,
                                filled: true
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onChanged: (value) => _phoneNumber = value,
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'OTP',
                                fillColor: Colors.grey,
                                filled: true
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the OTP';
                              }
                              return null;
                            },
                            onSaved: (value) => _smsCode = value!,
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              verifyPhoneNumber();},
                            child: const Text('Send Otp'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signInWithPhoneNumber();},
                            child: const Text('Login'),

                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()),);
                            },
                            child: const Text('Skip'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}