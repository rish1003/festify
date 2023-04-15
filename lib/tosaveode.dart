import 'dart:collection';
import 'package:collegify/Map_view.dart';
import 'package:collegify/Search.dart';
import 'package:collegify/login2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
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
                    color: Colors.black,
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
       SizedBox(
                      height:40,
                      width: 40,
                      child:
                      ElevatedButton(
                        child: Center(
                            child: Icon(Icons.home)
                        ),
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(left:0),
                          backgroundColor: Color.fromRGBO(80, 127, 127, 1), // background (button) color
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                      )
                    ),
                    SizedBox(
                        height:40,
                        width: 80,
                        child:
                        ElevatedButton(
                          child: Center(
                              child: Text("Events",textAlign: TextAlign.left, style:
                              TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                  height: 1),)
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> MyHomePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left:0),
                            backgroundColor: Color.fromRGBO(80, 127, 127, 1), // background (button) color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                        height:40,
                        width: 80,
                        child:
                        ElevatedButton(
                          child: Center(
                              child: Text("Register",textAlign: TextAlign.left, style:
                              TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                  height: 1),)
                          ),
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left:0),
                            backgroundColor: Color.fromRGBO(28, 59, 59, 1), // background (button) color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                        height:40,
                        width: 80,
                        child:
                        ElevatedButton(
                          child: Center(
                              child: Text("Team",textAlign: TextAlign.left, style:
                              TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                  height: 1),)
                          ),
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left:0),
                            backgroundColor: Color.fromRGBO(13, 44, 44, 1), // background (button) color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                        height:40,
                        width: 80,
                        child:
                        ElevatedButton(
                          child: Center(
                              child: Text("Contact",textAlign: TextAlign.left, style:
                              TextStyle(
                                  fontFamily: 'League Spartan',
                                  fontSize: 15,
                                  height: 1),)
                          ),
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left:0),
                            backgroundColor: Color.fromRGBO(1, 32, 32, 1),// background (button) color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                          ),
                        )
                    )
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  const HomePage({Key? key}) : super(key: key);

}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
    if (_selectedIndex==1){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
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
                Navigator.pop(context);
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
                icon: Icon(Icons.list_outlined),
                label: 'List View',
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
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 0 ),
      body: Container(
        color: const Color(0xFF0F0F0F),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: const Text(
                'Choose your city',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button2',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
body: Column(
children: [
Container(
color: Colors.black,
padding: EdgeInsets.all(16.0),
child: ListView(
children: [
Text(
"Results for '${widget.searchKeyword}'",
style: TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.bold,
),
),
ElevatedButton(
onPressed: () {},
child: Text(
widget.searchKeyword,
style: TextStyle(
fontSize: 20.0,
),
),
),
],
)

),
]),
*/