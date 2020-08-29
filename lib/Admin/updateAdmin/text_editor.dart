import 'package:flutter/material.dart';

import '../../styletext.dart';

class TextEditGetter extends StatefulWidget {

  final Function validate;
  final Function saved;
  final TextEditingController control;
  final String hint;
  final IconData iconic;

  const TextEditGetter({Key key, this.validate, this.saved, this.control, this.hint, this.iconic}) : super(key: key);

  
  _TextEditGetterState createState() => _TextEditGetterState();
}

class _TextEditGetterState extends State<TextEditGetter> {
  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: widget.control,
                validator: widget.validate,
                onSaved: widget.saved,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    widget.iconic,
                    color: pureblue,
                  ),
                  hintText: widget.hint,
                  hintStyle: eHintStyle,
                ),
              ),
            );
  }
}