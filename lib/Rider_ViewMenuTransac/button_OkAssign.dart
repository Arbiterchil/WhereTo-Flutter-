import 'package:flutter/material.dart';

class AssignRider extends StatefulWidget {

  final Color color;
  final double blurlevel;
  final Offset offsetBlue;
final Offset offblackBlue;
final double height;
final double width ; 
final IconData icon;
final double iconSize;
final String label;
final Function onTap;

  const AssignRider({Key key, this.color, this.blurlevel, this.offsetBlue, this.offblackBlue, this.height, this.width, this.icon, this.iconSize, this.label, this.onTap}) : super(key: key);


  @override
  _AssignRiderState createState() => _AssignRiderState();
}



class _AssignRiderState extends State<AssignRider> {

bool isPressDown =false;
     void onPressUpnow(PointerUpEvent event){
       setState(() {
         isPressDown =false;
       });
     }
     void onPressDownnow(PointerDownEvent event){
       setState(() {
         isPressDown = true;
       });
     }


  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPressDownnow,
      onPointerUp: onPressUpnow,
      child: GestureDetector(
        onTap: widget.onTap,
        child: isPressDown? Container(
          height: widget.width,
          width: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: widget.blurlevel,
                offset: Offset(-4, -4),
                color: Colors.blue[700].withOpacity(.7)
              ),
              BoxShadow(
                blurRadius: widget.blurlevel,
                offset: Offset(4, 4),
                color: Colors.blue[700].withOpacity(.15)
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: widget.blurlevel,
                        offset: widget.offsetBlue,
                        color: Colors.grey.shade500
                        // withOpacity(.7)
                      ),
                      BoxShadow(
                        blurRadius: widget.blurlevel,
                        offset: widget.offblackBlue,
                        color: Colors.blue[700].withOpacity(.25)
                      ),
                    ],
                  ),
                  child: Icon(widget.icon,
                  size: widget.iconSize,
                  color: Colors.amber,),
                ),
              ),
            ),
          ),
        ): Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: Color(0xFF398AE5),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color:  Colors.blue[500],
                blurRadius: widget.blurlevel,
                offset: Offset(-6, -6),

              ),
              BoxShadow(
                color:Colors.blue.shade700,
                blurRadius: widget.blurlevel,
                offset: Offset(6, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.icon,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(width: 4.0,),
              Text(widget.label,
              style: TextStyle(
                 color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans'
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

