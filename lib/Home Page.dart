import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/events.dart';
import 'package:collegify/Map_view.dart';
import 'package:collegify/Search.dart';
import 'package:collegify/favs.dart';
import 'package:collegify/login2.dart';
import 'package:collegify/searched.dart';
import 'package:collegify/searched2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ep.dart';

import 'dart:collection';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  const HomePage({Key? key}) : super(key: key);

}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _searchController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  void _SubmitSearch(var val) async{
    final databaseReference = FirebaseFirestore.instance;
    final usersCollection = databaseReference.collection('fests');
    int flag=0;
    final usersSnapshot = await usersCollection.get();
    final List<QueryDocumentSnapshot> usersList = usersSnapshot.docs;
    for (QueryDocumentSnapshot user in usersList) {
      if (user.id == val.toLowerCase()){
        flag=1;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchResultsPage(searchKeyword: val)));
        break;
      }
    }
    if (flag==0){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchResultsPage2(searchKeyword: val)));
    }
  }

  void _CheckFest( var val) async{
    final databaseReference = FirebaseFirestore.instance;
    final usersCollection = databaseReference.collection('fests');
    int flag=0;
    final usersSnapshot = await usersCollection.get();
    final List<QueryDocumentSnapshot> usersList = usersSnapshot.docs;
    for (QueryDocumentSnapshot user in usersList) {
      if (user.id == val.toLowerCase()){
        flag=1;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EventsPage(sKeyword: val.toLowerCase())));
        break;
        }
      }
    if (flag==0){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ErrorPage()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
            //_key.currentState!.openDrawer();
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.star,
              ),
              title: const Text('Favourites'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FavouritesPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: const Text('Log Out'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('Phone');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => otppage()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.black12
        ),
        ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.black26,
          onTap: _onItemTapped,
          iconSize: 40,
          elevation: 0 ),
      body: Center(
        child: _selectedIndex == 1
            ?
        //SEARCH PAGE
        Container(
            width: 360,
            height: 790,
            decoration: BoxDecoration(
              color : Color.fromRGBO(0, 0, 0, 1),
            ),
            child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 145,
                      left: 15,
                      child: Container(
                        width: 340,
                        height: 45,
                        padding: EdgeInsets.only(left: 10, top: 2),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(21, 59, 59, 1),
                            border:Border.all(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              width: 2,
                            )
                        ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Where is your next core memory?",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              )
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            onSubmitted: (value) {
                              _SubmitSearch(value);
                            },
                          ),
                      ),
                  ),
                  Positioned(
                      top: 60,
                      left: 100,
                      child: Container(
                          width: 163,
                          height: 55,
                          child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Text('Search', textAlign: TextAlign.left, style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'League',
                                        fontSize: 48,
                                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1
                                    ),)
                                ),
                              ]
                          )
                      )
                  ),Positioned(
                      top: 210,
                      left: 89,
                      child: Container(
                          width: 181,
                          height: 42,
                          decoration: BoxDecoration(
                            image : DecorationImage(
                                image: AssetImage('assets/Image2.png'),
                                fit: BoxFit.fitWidth
                            ),
                          )
                      )
                  ),Positioned(
                      top: 60,
                      left: 31,
                      child: Container(
                        width: 43,
                        height: 49,
                        decoration: BoxDecoration(
                          image : DecorationImage(
                              image: AssetImage('assets/Group81.png'),
                              fit: BoxFit.fitWidth
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      top: 270,
                      left: 10,
                      child: Container(
                          width: 160,
                          height: 100,
                          child: ElevatedButton(
                            child: Text("TechSpark"),
                            onPressed: (){
                              _CheckFest("TechSpark");
                            },
                          )
                      )
                  ),
                  Positioned(
                      top: 270,
                      left: 190,
                      child: Container(
                          width: 160,
                          height: 100,
                          child: ElevatedButton(
                            child: Text("Kshitij"),
                            onPressed: (){
                              _CheckFest('Kshitij');
                            },
                          )
                      )
                  ),
                ]
            )
        )
            :
        Container(
          width: 360,
          height: 790,
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 60,
                left: 100,
                child: Container(
                  width: 175,
                  height: 55,
                  child: Text(
                    'FestFlix',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'League',
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 110,
                child: Container(
                  width: 175,
                  height: 55,
                  child: Text(
                    'Welcome!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'League',
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 55,
                left: 28,
                child: IconButton(
                  icon: Icon(Icons.person),
                  iconSize: 40.0,
                  color: Colors.white,
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                ),
              ),
              Positioned(
                top: 190,
                left: 0,
                child: Image(image: AssetImage('assets/main.png')),
              ),

            ],
          ),
        )


      )

      );
  }
}
