import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesPage extends StatefulWidget{
  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  dynamic d1;

  void checkfav() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? b = prefs.getString("Phone");
    String? c = prefs.getString("uid");
    late DocumentSnapshot snapshot;

    final data = await FirebaseFirestore.instance.collection("users").doc(c).get();
    snapshot = data;
    setState(() {
      d1 = snapshot.data() as dynamic;
    });

  }
  @override
  void initState() {
    super.initState();
    checkfav();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: Text("Favourites", textAlign: TextAlign.left, style:
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
        body:d1!=null?
        Container(
          color: Colors.purple,
          width: 360,
          height: 790,
          child:
          Container(
            child: d1['Favs'].isEmpty==false?
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EventsPage(sKeyword: d1['Favs'].toString().toLowerCase() )));
                      },
                      child: Text( d1['Favs'].toString().toUpperCase()),
                    )
                  ],
                ):

            Center(
              child: Text( 'No Favourites'),
              ),

            )
          ):
        Container(
            child: CircularProgressIndicator()
        )
        );
  }
}