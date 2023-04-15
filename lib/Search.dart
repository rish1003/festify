import 'package:flutter/material.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator SearchPage - FRAME

    return Scaffold(
        body: Container(
            width: 360,
            height: 790,
            decoration: BoxDecoration(
              color : Color.fromRGBO(0, 0, 0, 1),
            ),
            child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 150,
                      left: 25,
                      child: Container(
                          width: 310,
                          height: 28,
                          decoration: BoxDecoration(
                            color : Color.fromRGBO(21, 59, 59, 1),
                            border : Border.all(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              width: 2,
                            ),
                          )
                      )
                  ),Positioned(
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
                ]
            )
        )
    );
  }
}
