import 'package:flutter/material.dart';

class CustomTextFieldFixStyle extends StatelessWidget {

  final Stream stream;
  final bool obsecure;
  final TextInputType type;
  final ValueChanged<String> onchangeTxt;
  final IconData iconText;
  final String hintTxt;
  final String labelText;
  final Function submit;
  final FocusNode nodes;
  final TextInputAction actions;
  final bool activeChange;
  final bool enable;

  const CustomTextFieldFixStyle({Key key, this.stream, this.obsecure, this.type, this.onchangeTxt, this.iconText, this.hintTxt, this.labelText, this.submit, this.nodes, this.actions, this.activeChange, this.enable}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context,snaps){
        return Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration:BoxDecoration(
                color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(width: 1, color: Color(0xFF0F75BB) ),
              ),
              height: 50.0,
              child: TextField(
                enabled: enable,
                onSubmitted: submit,
                focusNode: nodes,
                textInputAction: actions,
                keyboardType: type,
                cursorColor: Color(0xFF0F75BB),
                obscureText: obsecure,
                onChanged: onchangeTxt,
                style: TextStyle(
                  
                  color: Color(0xFF0F75BB),
                  fontFamily: 'Gilroy-light',
                  
                ),
                decoration: InputDecoration(
                  
                  errorText: snaps.error,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    iconText,
                    color: Color(0xFF0F75BB),
                  ),
                  hintText: hintTxt,
                  hintStyle: TextStyle(
                  color: Color(0xFF0F75BB),
                  fontFamily: 'Gilroy-light',
                  ),
                
                ),
              ),
            );
      },
    );
  }
}