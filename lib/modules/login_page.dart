

 import 'package:WhereTo/A1_NewSingleBottomNav/Single_customfield/single.customField.dart';
import 'package:WhereTo/ATrial/animation_trial.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../styletext.dart';
import 'LoginBloc/loginBloc.dart';

class LoginPage extends StatefulWidget{
  @override
    _LoginPageState createState() => _LoginPageState();

  }


class _LoginPageState extends State<LoginPage> {
 

  FocusNode contactNumber;
  FocusNode password;
  bool show = true;
  bool loadingShow = false;

  @override
  void initState() {
     configSignal();
    super.initState();
    contactNumber = FocusNode();
    password = FocusNode();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
    
  }

   void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
}

Widget spinKitDots(){
  return Container(
    height: 40,
    width: 60,
    child: SpinKitThreeBounce(
      color: pureblue,
      size: 30,
    ),
  );
}

  Widget _phone(LoginBloc loginBloc){
    return CustomTextFieldFixStyle(
      stream: loginBloc.numberPhone,
      obsecure: false,
      onchangeTxt: loginBloc.changeNumber,
      iconText: Icons.person,
      type: TextInputType.number,
      hintTxt: "09XXXXXXXXX",
      labelText: "Contact Number",
      nodes: contactNumber,
      actions: TextInputAction.next,
      submit: (_) => FocusScope.of(context).requestFocus(password),
    );
  }
   Widget _password(LoginBloc loginBloc){
    return Stack(
      children: [
        CustomTextFieldFixStyle(
      stream: loginBloc.passwordUser,
      obsecure: show,
      onchangeTxt: loginBloc.changPassword,
      iconText: Icons.lock,
      hintTxt: "Password",
      nodes: password,
      labelText: "Password",
      actions: TextInputAction.done,
      submit: (_) => FocusScope.of(context).requestFocus(FocusNode()),
    ),
         Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25,top: 15),
                      child: GestureDetector(
                        onTap: () => setState(() => show = !show),
                        child: Icon(
                          show ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: Color(0xFF0F75BB),
                        ),
                      ),
                      ),
                  ),

      ],
    );
  }
   Widget _bottonLog(LoginBloc loginBloc){
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: StreamBuilder<bool>(
            stream: loginBloc.submitDatauser,
            builder: (context,snaps){
              return Container(
                width: 100,
                height: 50,
                child: RaisedButton(
                  color: pureblue,
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Center(
                            child: Text("Login > ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gilroy-ExtraBold'
                            ),
                            ), 
                        ),
                        onPressed: snaps.hasData
                        ? () => navigatepage(loginBloc)
                        : null,
                ),

              );
            },
          ),
        ),
      ],
    );
  }

   void navigatepage(LoginBloc loginBloc) async{
    setState(() {
      loadingShow = true;
    });
    await loginBloc.loginUser(context);
    await loginBloc.dispose();
    setState(() {
      loadingShow = false;
      
    });
  }
 Widget _botDownSignUp(){
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return SignupPage();
        }));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t Have an Account Yet? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy-light'
              ),
            ),
            TextSpan(
              text: 'Sign Up Now.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy-ExtraBold'
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              children: [
                  SizedBox(height: 90,),
                   Text(
                              'Sign In',
                              style: TextStyle(
                                color: pureblue,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  SizedBox(height: 30,),
                  _phone(loginBloc),
                  SizedBox(height: 25,),
                  _password(loginBloc),
                  SizedBox(height: 45,),
                 loadingShow ? 
                 spinKitDots() 
                 :_bottonLog(loginBloc),
                  SizedBox(height: 15,),
              ],
            ),
          ),
        )),
        bottomNavigationBar: BottomAppBar(
         color: Colors.transparent,
          elevation: 0,
           child:    Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                      Align(
                        alignment: Alignment.center,
                        child: AnimationWaveTrial(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: _botDownSignUp(),
                        ),
                      )
                    ],
                  ),
                ),
        ),
    );
    

  }


 

}

//   class LoginPage extends StatefulWidget{
//   @override
//     _LoginPageState createState() => _LoginPageState();

//   }


// class _LoginPageState extends State<LoginPage> {
//   var userData;
//   bool isLoading = false;
//     final key = GlobalKey<FormState>();
//      TextEditingController contactNumber =  TextEditingController();
//       TextEditingController passwordController =  TextEditingController();

//       phoneValidate(String val){

//           Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
//           RegExp regExp = new RegExp(pattern);
//           if (val.length == 0 ){
//             return 'Please enter your number';
//           }
//           else if(!regExp.hasMatch(val)){
//             return 'Enter A Valid Contact Number';
//           }
//           else{
//             return null;
//           }

//     }
//     Widget _formGet(BuildContext context){
//       return Form(
//         key: key,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           textDirection: TextDirection.ltr,
//           children: <Widget>[
//           //  Text('Contact Number',
           
//           //   style: eLabelStyle,
//           //   ),
//           //  SizedBox(height: 20.0,),
//              Container(
//               width: MediaQuery.of(context).size.width,
//               alignment: Alignment.centerLeft,
//               decoration: eBoxDecorationStyle,
//               height: 50.0,
//               child: TextFormField(
//                 controller: contactNumber,
//                 validator: (val){
//                   return phoneValidate(contactNumber.text = val);
//                 },
//                 keyboardType: TextInputType.number,
//                 cursorColor: pureblue,
//                 style: TextStyle(
//                   color: pureblue,
//                   fontFamily: 'Gilroy-light',
//                 ),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.only(top:14.0),
//                   prefixIcon: Icon(
//                     Icons.phone_android,
//                     color: pureblue,
//                   ),
//                   hintText: 'Contact Number',
//                   hintStyle: eHintStyle,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.0,),
//             //  Text('Password',
//             // style: eLabelStyle,
//             // ),
//             // SizedBox(height: 20.0,),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               alignment: Alignment.centerLeft,
//               decoration: eBoxDecorationStyle,
//               height: 50.0,
//               child: TextFormField(
//                 cursorColor: pureblue,
//                 controller: passwordController,
//                 validator: (val) => val.isEmpty ? ' Please Put Your Password' : null,
//                 obscureText: true,
//                 style: TextStyle(
//                   color: pureblue,
//                   fontFamily: 'Gilroy-light',
//                 ),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.only(top:14.0),
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: pureblue,
//                   ),
//                   hintText: 'Password',
//                   hintStyle: eHintStyle,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.0,),
//             // Container(
//             //   width: MediaQuery.of(context).size.width,
//             //   alignment: Alignment.centerLeft,
//             //   child: FlatButton(
//             //     onPressed: (){},
//             //     padding: EdgeInsets.only(right: 0.0),
//             //      child: Text('Forget Password',
//             //      style: eLabelStyle,
//             //      ),
//             //      ),
//             // ),
//           ],
//         ),
//         ),
//       );
//   }

//      Widget _buildSocialBtn(Function onTap, String text) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60.0,
//         width: 60.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: pureblue,
          
//         ),
//         child: Center(
//           child: Text(text,
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Gilroy-ExtraBold',
//             fontSize: 40,
//           ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildSocialBtnRow() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _buildSocialBtn(
//             () => print('Login with Facebook'),
//             "F"
//           ),
//           _buildSocialBtn(
//             () => print('Login with Google'),
//            "G"
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _botDownSignUp(){
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//         return SignupPage();
//         }));
//       },
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: 'Don\'t Have an Account Yet? ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Gilroy-light'
//               ),
//             ),
//             TextSpan(
//               text: 'Sign Up Now.',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Gilroy-ExtraBold'
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//      configSignal();
//     super.initState();
//   }
//    void configSignal() async {
//      await OneSignal.shared.setLocationShared(true);
//     await OneSignal.shared.promptLocationPermission();
//     await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
//     await OneSignal.shared.getPermissionSubscriptionState();
//     await OneSignal.shared.setSubscription(true);
//     await OneSignal.shared.getTags();
//    await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
// }

//   @override
//   void dispose() {
//     super.dispose();
//     // AnimationWaveTrial();
//   }

//   @override
//   Widget build(BuildContext context) {

//     // return Scaffold(

//     //   body: SafeArea(
//     //     child: SingleChildScrollView(
//     //       physics: AlwaysScrollableScrollPhysics(),
//     //       child: Column(
//     //         children: <Widget>[
//     //           Container(
//     //             width: MediaQuery.of(context).size.width,
//     //             height: MediaQuery.of(context).size.height,
//     //             child: Stack(
//     //               children: <Widget>[
//     //                  Align(
//     //                     alignment: Alignment.topRight,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(right: 30,top: 10),
//     //                       child: Container(
//     //                         height: 60,
//     //                         width:  60,
//     //                         child: Image.asset('asset/img/logo.png'),
//     //                       ),),
//     //                   ),
//     //                 Align(
//     //                   alignment: Alignment.topCenter,
//     //                   child: Padding(padding: const EdgeInsets.only(top: 90),
//     //                   child: Column(
//     //                     children: <Widget>[
//     //                       SizedBox(height: 20,),
//     //                         Text(
//     //                                     'Sign In',
//     //                                     style: TextStyle(
//     //                                       color: pureblue,
//     //                                       fontFamily: 'Gilroy-ExtraBold',
//     //                                       fontSize: 45.0,
//     //                                       fontWeight: FontWeight.bold,
//     //                                     ),
//     //                                   ),
//     //                         SizedBox(height: 20,),
//     //                         Padding(
//     //                           padding: const EdgeInsets.only(left: 40,right: 40),
//     //                           child: _formGet(context),
//     //                         ),
//     //                          SizedBox(height: 40,),
//     //                         Container(
//     //               width: MediaQuery.of(context).size.width,
//     //               child: Stack(
//     //                 children: <Widget>
//     //                 [
//     //                   Align(
//     //                     alignment: Alignment.topRight,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(right: 30),
//     //                       child: GestureDetector(
//     //                         onTap: _login,
//     //                         child: Container(
//     //                           height: 50,
//     //                           width: 110,
//     //                           decoration: BoxDecoration(
//     //                             color: pureblue,
//     //                             borderRadius: BorderRadius.all(Radius.circular(100)),
//     //                           ),
//     //                           child: Center(
//     //                             child: Text( isLoading ? '....' : 'Login >',
//     //                             style: TextStyle(
//     //                               fontFamily: 'Gilroy-ExtraBold',
//     //                               fontSize: 18,
//     //                               color: Colors.white
//     //                             ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       ),
//     //                   )
//     //                 ],
//     //               ),
//     //             ),
//     //                     ],
//     //                   )
//     //                   ),
//     //                 ),
//     //                  Align(
//     //                     alignment: Alignment.center,
//     //                     child: AnimationWaveTrial(),
//     //                   ),
//     //                   Align(
//     //                     alignment: Alignment.bottomCenter,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(bottom: 40),
//     //                       child: _botDownSignUp(),
//     //                     ),
//     //                   )
//     //               ],
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ),

//     // );

//       return Scaffold(

//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: AlwaysScrollableScrollPhysics(),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 100,
//                   child: Stack(
//                     children: <Widget>
//                     [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 30),
//                           child: Container(
//                             height: 60,
//                             width:  60,
//                             child: Image.asset('asset/img/logo.png'),
//                           ),),
//                       ),
                      
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                  Text(
//                             'Sign In',
//                             style: TextStyle(
//                               color: pureblue,
//                               fontFamily: 'Gilroy-ExtraBold',
//                               fontSize: 45.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40,right: 40),
//                   child: _formGet(context),
//                 ),
//                 SizedBox(height: 20,),
//                 isLoading ? spinDot() : Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Stack(
//                     children: <Widget>
//                     [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 30),
//                           child: GestureDetector(
//                             onTap: _login,
//                             child: Container(
//                               height: 50,
//                               width: 110,
//                               decoration: BoxDecoration(
//                                 color: pureblue,
//                                 borderRadius: BorderRadius.all(Radius.circular(100)),
//                               ),
//                               child: Center(
//                                 child: Text( isLoading ? '....' : 'Login >',
//                                 style: TextStyle(
//                                   fontFamily: 'Gilroy-ExtraBold',
//                                   fontSize: 18,
//                                   color: Colors.white
//                                 ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ),
//                       )
//                     ],
//                   ),
//                 ),
//                           // SizedBox(height: 10.0),
//                           // Text(
//                           //   'Sign in with',
//                           //   style: eLabelStyle,
//                           // ),
//                           // _buildSocialBtnRow(),
             

//               ],
//             ),
//           )),
//         bottomNavigationBar: BottomAppBar(         
//           color: Colors.transparent,
//           elevation: 0,
//           child:    Container(
//                   height: 190,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: Stack(
//                     children: <Widget>
//                     [
//                       Align(
//                         alignment: Alignment.center,
//                         child: AnimationWaveTrial(),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 40),
//                           child: _botDownSignUp(),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//         ),
//       );
//   }


//   Widget spinDot(){
//     return Container(
//       height: 40,
//       width: MediaQuery.of(context).size.width,
//       child: Center(
//         child: SpinKitThreeBounce(
//           color: pureblue,
//           size: 20.0,
//         ),
//       ),
//     );
//   }


// void _login() async{
//  String hens ;
//  bool value = true;
// var coordinates =await ID().getPosition();
//  setState(() {
//       isLoading = true;
//     });

//     if(key.currentState.validate()){
//       key.currentState.save();
//        var data = {
//         'contactNumber' : contactNumber.text, 
//         'password' : passwordController.text
//         ,};
//     var res = await ApiCall().postData(data,'/login');
  
//     var body = json.decode(res.body);
//     if(body['success'] == true){
//       var bods = await ApiCall().logVerify('/isAccountSuspended/${body['user']['id']}');
//       if(bods.body == "true"){
//         print('can\'t login');
//          _showDial("This Account is Suspended Due to Violating our Rules.");
//       }else{
//         print('can go in');
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setBool('check', value);
//       localStorage.setString('token', body['token']);
//       localStorage.setString('user', json.encode(body['user']));
//       localStorage.setString('trial','trialShow');
//       localStorage.setString("address", body['user']['address']);
//       localStorage.setString("userTYPO", body['userType'].toString());
//       localStorage.setDouble("latitude", double.parse(body['user']['latitude']));
//       localStorage.setDouble("longitude", double.parse(body['user']['longitude']));
//       print(body);
//           if(body['user']['userType'] == 0){
//         print('Customer');

//         Navigator.pushReplacement(
//         context,
//         new MaterialPageRoute(
//             builder: (context) => HomePage()));
//       }else if(body['user']['userType'] == 2){
//         print('Welcome Admin');
//         Navigator.pushReplacement(
//         context,
//         new MaterialPageRoute(
//             builder: (context) => AdminHomeDash()));
//       }else if(body['user']['userType'] == 1){

//            var respo = await ApiCall().addRemittanceRecord('/addRemittanceRecord/${body['user']['id']}');
//           print(respo.body);
//           print('Rider');
//           Navigator.pushReplacement(
//           context,
//           new MaterialPageRoute(
//               builder: (context) => RiderProfile()));
//               print("Nice");
//       }else{
//         _showDial("User Does not Exist.");
//       }
//       }
//     }else if(body['suspended'] == true){
//          print("Nigga Thats Hurt");
//                _showDial("You've Been Suspended Go To the Office Immediately.");
//     }else if(body['remitPending'] == true){
//             print("Bearly Good");

//              print(body['user']['id']);
//              _showRemit("You still have A Pending Remit",body['user']['id']);
            
            
//     }else{

//       _showDial("Password or Contact Number is Wrong.");

//     }
//     // }else{

//     //      if(body['suspended'] == true){
//     //           print("Nigga Thats Hurt");
//     //            _showDial("You've Been Suspended go ot the Office Now.");
//     //       }else if(body['remitPending'] == true){
//     //         print("Bearly Good");
//     //          _showDial("You still have A Pending Remit");

//     //       }else{
//     //         print('Nice');
//     //          var respo = await ApiCall().addRemittanceRecord('/addRemittanceRecord/${body['user']['id']}');
//     //       print(respo.body);
//     //       print('Rider');

//     //       Navigator.pushReplacement(
//     //       context,
//     //       new MaterialPageRoute(
//     //           builder: (context) => RiderProfile()));
//     //           print("Nice");
//     //       }
     

//     //         _showDial("Password or Contact Number is Wrong.");
          

     
//     // }
   
   
   
//     }


//    setState(() {
//      isLoading =false;
//    });

   

  


//   }

// void _showDial(String message){
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context){
//       return Dialog(
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         height: 300.0,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//         color: Colors.white),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//               children: <Widget>[
//                 Stack(
//                   children: <Widget>[
//                     Container(
//                       height: 150.0,
//                     ),
//                     Container(
//                       height: 100.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
//                          gradient: LinearGradient(
//                               stops: [0.2,4],
//                               colors: 
//                               [
//                                 Color(0xFF0C375B),
//                                 Color(0xFF176DB5)
//                               ],
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomLeft),),

//                     ),
//                     Positioned(
//                       top: 50.0,
//                       left: 94.0,
//                       child: Container(
//                         height: 90,
//                         width: 90,
//                         padding: EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(45),
//                           image: DecorationImage(
//                             image: AssetImage("asset/img/logo.png"),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(message,
//                   style: TextStyle(
//                     color: Color(0xFF0C375B),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14.0,
//                     fontFamily: 'OpenSans'
//                   ),
                  
//                   ),),
//                   SizedBox(height: 25.0,),
//                   Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[         
//                 RaisedButton(
//                   color:Color(0xFF0C375B),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   onPressed: () {
//                       Navigator.of(context).pop();
//                       },   
                      
//                   child: Text ( "Ok", style :TextStyle(
//                   color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12.0,
//                               fontFamily: 'OpenSans'
//                 ),),),
//                   ],
//                 ), 
//               ],
//           ),
//         ),
//       ),
//     ); 
//     },);
// }
// void _showRemit(String message, int id){
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context){
//       return Dialog(
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         height: 300.0,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//         color: Colors.white),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Column(
//               children: <Widget>[
//                 Stack(
//                   children: <Widget>[
//                     Container(
//                       height: 150.0,
//                     ),
//                     Container(
//                       height: 100.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
//                          gradient: LinearGradient(
//                               stops: [0.2,4],
//                               colors: 
//                               [
//                                 Color(0xFF0C375B),
//                                 Color(0xFF176DB5)
//                               ],
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomLeft),),

//                     ),
//                     Positioned(
//                       top: 50.0,
//                       left: 94.0,
//                       child: Container(
//                         height: 90,
//                         width: 90,
//                         padding: EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(45),
//                           image: DecorationImage(
//                             image: AssetImage("asset/img/logo.png"),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(message,
//                   style: TextStyle(
//                     color: Color(0xFF0C375B),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14.0,
//                     fontFamily: 'OpenSans'
//                   ),
                  
//                   ),),
//                   SizedBox(height: 25.0,),
//                   Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[         
//                 RaisedButton(
//                   color:Color(0xFF0C375B),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   onPressed: () => Navigator.push(context,
//                 new MaterialPageRoute(builder: (context) => RemitPendingUser(id :id))),   
                      
//                   child: Text ( "Ok", style :TextStyle(
//                   color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12.0,
//                               fontFamily: 'OpenSans'
//                 ),),),
//                   ],
//                 ), 
//               ],
//           ),
//         ),
//       ),
//     ); 
//     },);
// }

// }
