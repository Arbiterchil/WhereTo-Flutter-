import 'dart:async';

class Validators{

final validateEmail = 
  StreamTransformer<String,String>.fromHandlers(handleData: (email,sink){
    Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if(regExp.hasMatch(email)){
      sink.add(email);
    }else{
      sink.addError('Please Enter a Valid Email');
  }});

final validatePassword =
  StreamTransformer<String,String>.fromHandlers(handleData: (password,sink){
    if(password.length > 7){
    sink.add(password);
    }else{
    sink.addError('Invalid Password Enter More Than 7 Characters');
    }
  });

  final validateConPassword =
  StreamTransformer<String,String>.fromHandlers(handleData: (password,sink){
    if(password.length > 7){
    sink.add(password);
    }else{
    sink.addError('Invalid Password Enter More Than 7 Characters');
    }
  });
final validTextinput = 
  StreamTransformer<String,String>.fromHandlers(handleData: (input,sink){
    if(input.length > 3){
      sink.add(input);
    }else{
      sink.addError('Please Enter More than 3 Characters');
      }
  });

final validatePhoneNumberuser = 
  StreamTransformer<String,String>.fromHandlers(handleData: (number,sink){
    String pattern  = r'^\+?09[0-9]{9}$';
     RegExp regExp = new RegExp(pattern);
    // RegExp regExp = new RegExp(r'^(?:[+0]9)?[0-9]{11,11}$');
    // RegExp regExp = new RegExp(r'^(?:[+0]9)?[0-10]{11}$');
    if(regExp.hasMatch(number)){
      sink.add(number);
    }else if(number.runes.length > 10){
      sink.addError('Mobile Number Consist of 11 Digits');
    }else if(number.runes.length < 10){
      sink.addError('Maximum is only 11');
    }else{
      sink.addError("it Start in 09 and have 11 Digits");
    }
  });

  bool validateFormText(String txt){
    if(txt.isEmpty){
      return true;
    } else{
      return false;
    }
  }

  bool isValidEmail(String emailInput){
    
    final RegExp regExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regExp.hasMatch(emailInput);
    
  }

  bool isValidPhoneNumber(String inputNumber){
    final RegExp regExp = new RegExp(r'^\+?09([+0]9)?[0-9]{10,11}$');
    return regExp.hasMatch(inputNumber);
    }

  

}

final validatorBlockingDicks = Validators();