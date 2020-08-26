import 'package:flutter/material.dart';

class LocationSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: builddo(context),
    );
  }

  builddo(BuildContext context) => Container(
        height: 297,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.2, 4],
                colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'asset/img/logo.png',
                    height: 100,
                    width: 100,
                  ),
                )),
            SizedBox(
              height: 24.0,
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () async {},
              child: Text(
                "You have a pending transaction on this Restaurant",
                style: TextStyle(
                    color: Color(0xFF398AE5),
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                    fontFamily: 'OpenSans'),
              ),
            ),
          ],
        ),
      );
}
