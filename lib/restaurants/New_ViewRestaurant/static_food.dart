import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StaticFoodDisplay extends StatefulWidget {
  final Function onTap;
  final String foodname;
  final String description;
  final String restaurantname; 
  final String image;
  final String pricetag;

  const StaticFoodDisplay({Key key, this.onTap, this.foodname, this.description, this.restaurantname, this.image, this.pricetag}) : super(key: key);

 
  
  @override
  _StaticFoodDisplayState createState() => _StaticFoodDisplayState();
}

class _StaticFoodDisplayState extends State<StaticFoodDisplay> {
   final PageStorageBucket _bucket = new PageStorageBucket();
   final PageStorageKey key = new PageStorageKey("persistent");
   @override
 
  @override
  Widget build(BuildContext context) {
    setState(() {
        PageStorage.of(context).writeState(context, "Load!",);
    });
      return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: PageStorage(
            bucket: _bucket,
            key: key,
            child: Container(
            height: 215,
            width: 235,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),

                    // gradient: LinearGradient(
                    //   begin: Alignment.bottomCenter,
                    //   colors: [
                    //     Colors.white.withOpacity(.9),
                    //     Colors.grey.withOpacity(.0)
                    //   ]),
                  
              image: DecorationImage(
                image: NetworkImage(widget.image),
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
               
                Container(
                  height: 215,
                width: 235,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      colors: [
                       Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.0),

                      ],
                      stops: [0.3,2.5],
                      )
                      ,
                ),
                ),
                 Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(padding: const EdgeInsets.only(bottom: 10,right: 10),
                  child: Text(widget.pricetag.toString(),
                   style: TextStyle(
                              color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      fontFamily: 'Gilroy-ExtraBold' 
                          ),
                  ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10 ,top: 10),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                        // image: DecorationImage(
                        //   image: AssetImage("asset/img/heartIcon.jpg")
                        // ),
                      ),
                      child: Center(
                        child: SpinKitPumpingHeart(
                          color: Colors.redAccent,
                          size: 25,
                        ),
                      ),
                    ),
                    ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   topRight: Radius.circular(50),
                      //   bottomLeft: Radius.circular(20),
                      //   bottomRight: Radius.circular(20),),
                      // color: pureblue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.foodname,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      fontFamily: 'Gilroy-ExtraBold' 
                          ),),
                          SizedBox(height: 5.0,),
                          Text(widget.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:Colors.white,
                                  fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                      fontFamily: 'Gilroy-ExtraBold' 
                          ),),
                           SizedBox(height: 5.0,),
                          Text(widget.restaurantname,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:Colors.white,
                                  fontWeight: FontWeight.bold,
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
      ),
    );
  }
}