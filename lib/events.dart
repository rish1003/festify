import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Home%20Page.dart';
import 'package:collegify/Splash%20Screen.dart';
import 'package:collegify/Third.dart';
import 'package:collegify/second.dart';
import 'package:collegify/first.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'ep.dart';


class EventsPage extends StatefulWidget {
  final String sKeyword;
  const EventsPage({Key? key, required this.sKeyword}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late DocumentSnapshot snapshot;
  dynamic d1;
  void getData() async{
    final data = await FirebaseFirestore.instance.collection("fests").doc(widget.sKeyword).get();
    snapshot = data;
    setState(() {
      d1 = snapshot?.data() as dynamic;
    });
  }
  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var a="";
    var i=0;
    if (d1==null){
      i=1;
    }
    else{
      i=0;
      a = d1['Name'];
    }
    return Scaffold(
      appBar:  AppBar(
        title: Text(a, textAlign: TextAlign.left, style:
        TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'League Spartan',
            fontSize: 40,
            height: 1),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(31, 66, 66, 1),Color.fromRGBO(63, 9, 64, 1)]
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body:
          i==0?
      PageView(
        controller: _pageController,
        children: <Widget>[
          FirstPage(sKeyword: widget.sKeyword),
          SecondPage(),
          ThirdPage(),
        ],
      )
          :
          Container(
            child: Center(child: CircularProgressIndicator(color: Colors.purple, backgroundColor: Colors.black))
          ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Events',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined),
              label: 'Register',
            ),
          ],
          onTap: (int index) {
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease,);
            },
        ),
    );
  }
}


