import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Home%20Page.dart';
import 'package:collegify/Splash%20Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:like_button/like_button.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  final String sKeyword;
  const FirstPage({Key? key, required this.sKeyword}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late DocumentSnapshot snapshot;
  dynamic d1;
  void getData() async{
    final data = await FirebaseFirestore.instance.collection("fests").doc(widget.sKeyword).get();
    snapshot = data;
    setState(() {
      d1 = snapshot.data() as dynamic;
    });
  }
  void addtofav(bool a) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? b = prefs.getString("Phone");
    FirebaseFirestore.instance.collection("users").where("UID",isEqualTo: b).get().then((value)=>value.docs.forEach((element) {
      prefs.setString('uid', element.id);
      if (a == true) {
        FirebaseFirestore.instance.collection("users").doc(element.id).update(
            {'Favs': widget.sKeyword});
        prefs.setString('liked', 'yes');
      }
      else {
        FirebaseFirestore.instance.collection("users").doc(element.id).update(
            {'Favs':[] });
        prefs.setString('liked', 'no');
      }
    }
    ));

  }


  @override
  void initState() {
    super.initState();
    getData();
  }
  int _current = 0;
  int _indexpage = 0;
  List<String> imageUrls = [
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://wallpaperaccess.com/full/1096890.png",
    "https://wallpaperaccess.com/full/793.png"
  ];
  List<Color> dotColors = [  Color.fromRGBO(214, 159, 215, 1.0) ,  Color.fromRGBO(206, 125, 208, 1),  Color.fromRGBO(138, 62, 140, 1.0)];
  bool  isFavorite = false;
  //String _placeholdertext = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";


  @override
  Widget build(BuildContext context) {
    int a=0;
    return Scaffold(
        body: d1!=null?
        SingleChildScrollView(
            child: Container(
                color: Colors.black,
                height:1120,
                child: Column (
                  children: [
                    Container(
                        height: 220,
                        child:
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 16/9,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: imageUrls.map((url) {
                                return Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(url, fit: BoxFit.cover,),
                                  ),
                                );
                              }).toList(),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imageUrls.map((url) {
                                  int index = imageUrls.indexOf(url);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index ? Color.fromRGBO(117, 23, 119, 1) : dotColors[index] ,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                        height:80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: Color.fromRGBO(117, 23, 119, 1) ,
                                padding: EdgeInsets.only(left:10,top:10,bottom:10),
                                child: Row(
                                  children: [
                                    FavoriteButton(
                                      valueChanged: (_isFavorite) {
                                        addtofav(_isFavorite);
                                        },
                                      iconSize: 40,
                                      iconDisabledColor: Colors.grey,
                                      iconColor: Colors.purpleAccent,
                                    ),
                                    Text("  Add to Favourites",style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'League Spartan',
                                      fontSize: 15,
                                    ))
                                  ],
                                )
                            )
                          ],
                        )

                    ),
                    Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom:15),
                                  child: Text('About', textAlign: TextAlign.left, style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'League Spartan',
                                    fontSize: 35,
                                  ),)
                                )
                              ],
                            ),
                            Container(
                                color: Color.fromRGBO(63, 63, 63, 1),
                                width: 360,
                                height: 150,
                                padding: EdgeInsets.all(9),
                                child:
                                Text(d1['About Us'].toString(), textAlign: TextAlign.left, style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                ),
                                )
                            )

                          ],
                        )
                    ),
                    Container(
                        height: 50,
                        child:
                        Row(
                          children: [
                            Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(166, 116, 167, 1),
                                  border : Border.all(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Text('Venue:\n'+d1['College'], textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                ),
                                )
                            ),
                            Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(147, 65, 148, 1.0),
                                  border : Border.all(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Text('Age Limit', textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                ),
                                )
                            ),
                            Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(51, 2, 54, 1.0),
                                  border : Border.all(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Text('Time:', textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                ),
                                )
                            )
                          ],
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top:40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Latest Updates', textAlign: TextAlign.left, style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'League Spartan',
                            fontSize: 35,
                          ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 220,
                        child:
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 16/9,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: imageUrls.map((url) {
                                return Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(url, fit: BoxFit.cover,),
                                  ),
                                );
                              }).toList(),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imageUrls.map((url) {
                                  int index = imageUrls.indexOf(url);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index ? Color.fromRGBO(117, 23, 119, 1) : dotColors[index] ,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top:40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Contact Us', textAlign: TextAlign.left, style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'League Spartan',
                            fontSize: 35,
                          ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.purple,),
                              Text("  +919988776654",style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.camera_alt, color: Colors.purple,),
                              Text("  @instagramid",style: TextStyle(color: Colors.white))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.email, color: Colors.purple,),
                              Text("  emailtest@gmail.com",style: TextStyle(color: Colors.white))
                            ],
                          )

                        ],
                      )
                    )
                  ],

                )
            )
        ):
            Container(
              child: CircularProgressIndicator()
            )

    );
  }
}