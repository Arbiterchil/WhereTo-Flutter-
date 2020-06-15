import 'package:flutter/material.dart';

class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}



class _SearchDepoState extends State<SearchDepo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
                backButt(),
                Container(
                  padding: const EdgeInsets.only(top: 250.0,),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                    ),
                  ),
                  // child: listData(),
                ),
            ],
          ),
        ),
    );

   


  }

    Widget backButt(){
        return new Container(
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0,top: 5.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(top:14.0,),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search",
                        ),
                      ),
                ),
              
              ),
            ),
          ),
        );
    }
    Widget listData(){
        return new ListView.builder(
          itemBuilder: null
          

          
          );
    }
}