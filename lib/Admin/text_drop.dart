// import 'package:WhereTo/styletext.dart';
// import 'package:flutter/material.dart';

// class TextEditDrop extends StatefulWidget {
//   @override
//   _TextEditDropState createState() => _TextEditDropState();
// }

// class _TextEditDropState extends State<TextEditDrop> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               width: MediaQuery.of(context).size.width,
//               alignment: Alignment.centerLeft,
//               decoration: eBoxDecorationStyle,
//               height: 50.0,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: DropdownButtonHideUnderline(
//                       child:
//             Stack(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(Icons.place,color: pureblue,)),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 30),
//                             child:
                            
                            
//                              DropdownButton(
//                                   isExpanded: true ,
//                                   hint: Text( "Select Barangay",
//                                   style: TextStyle(
                                      
//                                       color:pureblue,
//                                       fontFamily: 'Gilroy-light'
//                                     ),),
//                                   dropdownColor: Colors.white,
//                                   icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  
//                                   value: selectPerson,
//                                   items: dataBarangay.map((item) {
//                                   return new DropdownMenuItem(
//                                     child: Text(item['barangayName'],
//                                     style: TextStyle(
                                      
//                                       color: pureblue,
//                                       fontFamily: 'Gilroy-light'
//                                     ),
//                                     ),
//                                     value: item['id'].toString(),
//                                   );
//                                 }).toList(),
//                                   onChanged: (item){
//                                     setState(() {
//                                       selectPerson = item;
//                                       print(item);
//                                     });
//                                   }
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
                  
//               )
//             );
//   }
// }