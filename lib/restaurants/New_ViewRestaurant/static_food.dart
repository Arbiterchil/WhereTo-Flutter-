import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class StaticFoodDisplay extends StatefulWidget {
  final Function onTap;
  final String foodname;
  final String description;
  final String restaurantname; 
  final String image;

  const StaticFoodDisplay({Key key, this.onTap, this.foodname, this.description, this.restaurantname, this.image}) : super(key: key);

  
  @override
  _StaticFoodDisplayState createState() => _StaticFoodDisplayState();
}

class _StaticFoodDisplayState extends State<StaticFoodDisplay> {
  @override
  Widget build(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 215,
          width: 235,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover
              ),
              boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                           ],
         
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10 ,top: 10),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("asset/img/heartIcon.jpg")
                      ),
                    ),
                  ),
                  ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),),
                    color: pureblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.foodname,
                        style: TextStyle(
                            color:Colors.white,
                                fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    fontFamily: 'Gilroy-ExtraBold' 
                        ),),
                        SizedBox(height: 5.0,),
                        Text(widget.description,
                        style: TextStyle(
                            color:Colors.white,
                                fontWeight: FontWeight.normal,
                                    fontSize: 8.0,
                                    fontFamily: 'Gilroy-light' 
                        ),),
                         SizedBox(height: 5.0,),
                        Text(widget.restaurantname,
                        style: TextStyle(
                            color:Colors.white,
                                fontWeight: FontWeight.normal,
                                    fontSize: 10.0,
                                    fontFamily: 'Gilroy-light' 
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}