import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget{
  
  final IconData iconData;
  final String icontext;
  final Function onTap;
  const MenuItem({Key key, this.iconData, this.icontext,this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0x0000000),
          ),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 25,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      icontext,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: Colors.white),

                    ),            
                ],
              ),
          ),
        ),
      
    );
  }

}