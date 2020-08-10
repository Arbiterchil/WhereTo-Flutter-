
import 'package:flutter/material.dart';

class RiderCommentBox extends StatefulWidget {


  final String commentbox;

  const RiderCommentBox({Key key, this.commentbox}) : super(key: key);


  @override
  _RiderCommentBoxState createState() => _RiderCommentBoxState();
}

class _RiderCommentBoxState extends State<RiderCommentBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color:  Color(0xFF0C375B),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 20 ,right: 20),
              child: Text("'"+widget.commentbox+"'",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy-light',
                fontSize: 16,
              ),
              ),
              ),
          ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 19),
            child: Text("Anonymous Customer.",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Gilroy-light',
                fontSize: 11,
              ),
              ),
            ),
            
        ),
        ],
      ),
    );
  }
}