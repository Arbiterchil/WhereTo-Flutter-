// import 'dart:async';
// import 'dart:convert';
// import 'package:WhereTo/api/api.dart';

// import '../bloc.Navigation_bloc/navigation_bloc.dart';
// import 'package:WhereTo/modules/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../sidebar/menu_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rxdart/rxdart.dart';


// class SideBarHome extends StatefulWidget{
//   @override
//   _SideBarState createState() => _SideBarState();
//   }


// class _SideBarState extends State<SideBarHome> with SingleTickerProviderStateMixin<SideBarHome>{
//   AnimationController  animationController;
//   StreamController<bool> isSideOpenStreamControl;
//   Stream<bool> isSideOpenStream;
//   StreamSink<bool> isSideOpenSink;
//   final bool isOpen = true;
//   final animate = const Duration(milliseconds: 400);
//   var userdat;
//   @override
//   void initState() {
//      getUser();
//     super.initState();
//     animationController = AnimationController(vsync: this,duration: animate);
//     isSideOpenStreamControl = PublishSubject<bool>();
//     isSideOpenStream =  isSideOpenStreamControl.stream;
//     isSideOpenSink = isSideOpenStreamControl.sink;
    

//   }


 


//   @override
//   void dispose() {
//     animationController.dispose();
//     isSideOpenStreamControl.close();
//     isSideOpenSink.close();
//     super.dispose();

//   }
//  void getUser() async {
//      SharedPreferences localStorage = await SharedPreferences.getInstance();
//      var userj = localStorage.getString('user');
//      var users = json.decode(userj);
//     setState(() {
//       userdat = users;
//     });
//   }
//   void onIconPress(){
//     final animationStatus = animationController.status;
//     final isAnimationComp = animationStatus == AnimationStatus.completed;

//     if(isAnimationComp){
//       isSideOpenSink.add(false);
//       animationController.reverse();
//     }else{
//       isSideOpenSink.add(true);
//       animationController.forward();
//     }

//   }


//   @override
//   Widget build(BuildContext context) {
//     final screenWidth  = MediaQuery.of(context).size.width;
    
//     return StreamBuilder<bool>(
//       initialData: false,
//       stream: isSideOpenStream,
//       builder: (context,isSidebaropenAsync) {
//         return AnimatedPositioned(
//         duration: animate,
//         top: 0,
//         bottom: 0,
//         left: isSidebaropenAsync.data ? 0 : -screenWidth,
//         right: isSidebaropenAsync.data ? 0 : screenWidth -36,
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 height: double.infinity,
//                 color: Color(0xFF3936ea),
//                 // Color(0xFF20cdf5)
//                 // Color(0xFF0084ff)
//                  // Color(0xFF27C9F8)
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 100,
//                         ),
//                       ListTile(
//                         title: Text(userdat!= null ? '${userdat['name']}': '',style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w800,),
//                         ),
//                         subtitle: Text(userdat!= null ? '${userdat['contactNumber']}': '',
//                         style: TextStyle(
//                           color:  Color(0xFF1BB5FD),
//                           fontSize: 20,
//                         ),
//                         ),
//                         leading: CircleAvatar(
//                           child: Icon(
//                             Icons.perm_identity,
//                             color: Colors.white,
//                           ),
//                           radius: 50,
//                         ),
//                       ),
//                       Divider(
//                         height: 64,
//                         thickness: 0.5,
//                         color: Colors.white.withOpacity(0.3),
//                         indent: 32,
//                         endIndent: 32,
//                       ),
//                       MenuItem(
//                         iconData: Icons.home,
//                         icontext: "Home",
//                         onTap: (){
//                           onIconPress();
//                           BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomepageClickEvent);
//                         },
//                       ),
//                       MenuItem(
//                         iconData: Icons.local_activity,
//                         icontext: "Activity",
//                       ),
//                       MenuItem(
//                         iconData: Icons.payment,
//                         icontext: "Payment",
//                       ),
//                       MenuItem(
//                         iconData: Icons.account_circle,
//                         icontext: "Account",
//                          onTap: (){
//                           onIconPress();
//                           BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyProfileClicked);
//                         },
//                       ),
//                        MenuItem(
//                         iconData: Icons.search,
//                         icontext: "Browse",
//                         onTap: (){
//                           onIconPress();
//                           BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyRestaurantBrowse);
//                         },
//                       ),
//                       MenuItem(
//                         iconData: Icons.inbox,
//                         icontext: "Inbox",
//                       ),
//                        Divider(
//                         height: 64,
//                         thickness: 0.5,
//                         color: Colors.white.withOpacity(0.3),
//                         indent: 32,
//                         endIndent: 32,
//                       ),
//                       MenuItem(
//                         iconData: Icons.exit_to_app,
//                         icontext: "Logout",
//                         onTap: () async {
//                           var res = await ApiCall().getData('/logout');
//                           var body = json.decode(res.body);
//                           if(body['success']){
//                              SharedPreferences localStorage = await SharedPreferences.getInstance();
//                              localStorage.remove('user');
//                              localStorage.remove('token');
//                              print(body);
//                               Navigator.pushReplacement(
//                             context,
//                             new MaterialPageRoute(
//                                 builder: (context) => LoginPage()));
//                           }else{
//                             print(body);
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               ),
//               Align(
//                 alignment: Alignment(0,-0.9),
//                 child: GestureDetector(
//                   onTap: (){
//                     onIconPress();
//                   },
//                   child: ClipPath(
//                     clipper: CustomMenuClipper(),
//                     child: Container(
//                       width: 35,
//                       height: 110,

//                       color:Color(0xFF3936ea),
//                       //  Color(0xFF262AAA)
//                       alignment: Alignment.centerLeft,
//                       child: AnimatedIcon(
//                         progress: animationController.view,
//                         icon: AnimatedIcons.menu_close,
//                         color:  Colors.white,
//                         // Color(0xFF1BB5FD)
//                         size: 25,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),);
//       },
      
//     );
//   } 

 
//    void logout() async{
    

//       // var res = await ApiCall().getData('/logout');
//       // var body = json.decode(res.body);
//       // if(body['success']){
//       //    SharedPreferences localStorage = await SharedPreferences.getInstance();
//       //    localStorage.remove('user');
//       //    localStorage.remove('token');
//       //   //   Navigator.push(
//       //   // context,
//       //   // new MaterialPageRoute(
//       //   //     builder: (context) => LoginPage()));
//       // }
//        SharedPreferences localStorage = await SharedPreferences.getInstance();
//          localStorage.remove('user');
//          localStorage.remove('token');
        
//           Navigator.pushReplacement(
//         context,
//         new MaterialPageRoute(
//             builder: (context) => LoginPage()));
//   }


  
// }

// class CustomMenuClipper extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size){
//     Paint paint = Paint();
//     paint.color = Colors.white;
//     final width = size.width;
//     final heigth = size.height;
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.quadraticBezierTo(0, 8, 10, 16);
//     path.quadraticBezierTo(width-1, heigth/2-20, width, heigth/2);
//     path.quadraticBezierTo(width+1, heigth/2+20, 10, heigth-16);
//     path.quadraticBezierTo(0, heigth - 8 , 0, heigth);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }