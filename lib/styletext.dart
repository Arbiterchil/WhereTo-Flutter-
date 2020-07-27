import 'package:flutter/material.dart';

Color b0 =  Color(0xFF73AEF5);
Color b1 = Color(0xFF398AE5);
Color b2 = Color(0xFF478DE0);
Color b3 = Color(0xFF61A4F1);
Color b1s = Color(0xFF398AE5).withOpacity(0.075);
Color b2s = Color(0xFF478DE0).withOpacity(0.65);
Color b2s1 = Color(0xFF478DE0).withOpacity(.45);
Color sb3 = Colors.blue.shade700;
Color sb4 = Colors.blueAccent;
Color white = Colors.white70.withOpacity(0.050);




BoxDecoration eBox1 = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: Colors.grey[300],
  boxShadow: [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(4.0, 4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
     color: Colors.white,
      offset: Offset(-4.0, -4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    ),
  ],
);

BoxDecoration eBox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: b1,
  boxShadow: [
    BoxShadow(
      color: sb3,
      offset: Offset(10, 10),
      blurRadius: 10
    ),
    BoxShadow(
      color: Colors.blue[500],
      offset: Offset(-10, -10),
      blurRadius: 10
    )
  ],
);
BoxDecoration eInvertBox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.blue[500],
  boxShadow: [
  
    BoxShadow(
      color: white,
      offset: Offset(3, 3),
      blurRadius: 3,
      spreadRadius: -3
    ),
    
  ],
);
BoxDecoration eCBox = BoxDecoration(
  borderRadius: BorderRadius.circular(110),
  color: b1,
  boxShadow: [
    BoxShadow(
      color: sb3,
      offset: Offset(10, 10),
      blurRadius: 10
    ),
    BoxShadow(
      color: white,
      offset: Offset(-10, -10),
      blurRadius: 10
    )
  ],
);

BoxDecoration menuBox = BoxDecoration(
  color: b1,
  boxShadow: [
    BoxShadow(
      color: sb3,
      offset: Offset(10, 10),
      blurRadius: 10
    ),
    BoxShadow(
      color: white,
      offset: Offset(-10, -10),
      blurRadius: 10
    )
  ],
);

BoxDecoration transacBox = BoxDecoration(
  color: b1,
  boxShadow: [
    BoxShadow(
      color: sb3,
      offset: Offset(6, 6),
      blurRadius: 6
    ),
    BoxShadow(
      color: white,
      offset: Offset(-6, -6),
      blurRadius: 6
    )
  ],
);



BoxDecoration eMBox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: b1,
  boxShadow: [
    BoxShadow(
      color: b2,
      offset: Offset(-10, -10),
      blurRadius: 10,
      spreadRadius: -3,
    )
  ],
);

BoxDecoration eMBoxActive = eMBox.copyWith(color: b2s);

final eHintStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final eLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final eBoxDecorationStyle = BoxDecoration(
  color:  Color(0xFF398AE5),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: sb3,
     offset: Offset(4.0, 4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: white,
     offset: Offset(-4.0, -4.0),
      blurRadius: 15.0,
      spreadRadius: 1.0,
    )
  ],
);

