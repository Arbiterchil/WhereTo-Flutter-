import 'package:flutter/material.dart';


Color mC =Colors.grey.shade100;
Color mCL =Colors.white;
Color mCD =Colors.black.withOpacity(0.075);
Color mCC =Colors.green.withOpacity(0.65);
Color fCD =Colors.grey.shade700;
Color fCL =Colors.grey;
Color blueMCL =Color(0xFF398AE5);


BoxDecoration morph =BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: blueMCL,
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10
    ),
    BoxShadow(
      color: mCD,
      offset: Offset(-10, -10),
      blurRadius: 10
    ),

  ],
);

BoxDecoration morphInvert =BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.grey[300],
  boxShadow: [
    BoxShadow(
      color: blueMCL,
      offset: Offset(4, 4),
      blurRadius: 5,
      spreadRadius: -6
    ),

  ],
);
BoxDecoration morphInvertActive=morphInvert.copyWith(color: mCC);

BoxDecoration btn =BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.grey[300],
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(2, 2),
      blurRadius: 2,

    ),
  ],
);