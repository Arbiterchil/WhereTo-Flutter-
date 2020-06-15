import 'package:flutter/material.dart';

enum DialogAction {ok}

class Dialog {
  static Future<DialogAction> okBud(BuildContext context,String title,String body) async{


    final action   =  await showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Contant Number Already Exist."),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            RaisedButton(onPressed: () => Navigator.of(context).pop(DialogAction.ok),
            child: const Text("OK"),),
          ],
        );
      },);
      return (action != null ) ? action : DialogAction.ok;

  }
}