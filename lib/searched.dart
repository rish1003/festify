import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/ep.dart';
import 'package:collegify/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchKeyword;
  const SearchResultsPage({Key? key, required this.searchKeyword}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results",
        style: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontFamily: 'League',
        ),
        ),
        backgroundColor: Color.fromRGBO(21, 59, 59, 1),
        foregroundColor: Colors.white,

      ),
      body: Container(
        color: Colors.black,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top:1),
                width: 300,
                height: 50,
                child: Center(
                  child: Text("Results for '${widget.searchKeyword}'",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'League',
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:20,left:50, right:50),
                width: 360,
                height: 120,
                  child:
                  ElevatedButton(
                    child: Text(widget.searchKeyword),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EventsPage(sKeyword: widget.searchKeyword.toLowerCase())));
                    }
                  )
              ),
            ],
      )
      ),
    );
  }
}
