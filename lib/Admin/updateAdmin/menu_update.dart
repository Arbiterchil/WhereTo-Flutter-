import 'dart:convert';
import 'dart:io';

import 'package:WhereTo/Admin/Restaurant.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_MenuStream.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_menuResponse.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_menus.dart';
import 'package:WhereTo/Admin/updateAdmin/text_editor.dart';
import 'package:WhereTo/api/api.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../styletext.dart';
class MenuUpdateNewTwo extends StatefulWidget {
   final int menuId;
   final int restaurantId;

  const MenuUpdateNewTwo({Key key, @required this.menuId, @required this.restaurantId}) : super(key: key);


  
  @override
  _MenuUpdateNewTwoState createState() => _MenuUpdateNewTwoState(menuId,restaurantId);
}

class _MenuUpdateNewTwoState extends State<MenuUpdateNewTwo> {

  final int menuId;
  final int restaurantId;
  _MenuUpdateNewTwoState(this.menuId,this.restaurantId);

  @override
  void initState() {
    print(widget.menuId);
    print(widget.restaurantId);
    callCategory();
    super.initState();
    getMenubyIds..getMenubyId(menuId);
  }
  List dataCategory = List();
  bool loading = false;  
  bool loading1 = false;
  String toChoose;
   callCategory() async{

    var respon = await ApiCall().getCategory('/getCategories');
    var bararang = json.decode(respon.body);
  
    setState(() {
      dataCategory = bararang;
    });
    print(bararang);
  }


  var formkey = GlobalKey<FormState>(); 
  final pick = ImagePicker();
   File _idPickerImage;
   String stringPath;
   var thimagelink;
  String slectCateg;

  TextEditingController menuName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController markup = TextEditingController();
  TextEditingController categoryId = TextEditingController();

  String src;

    Widget _getImage(){

    if(_idPickerImage != null){

      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10),
          ),
          ),
          child: Image.file(
              _idPickerImage,
              fit: BoxFit.cover,
          ),
        ),
      );
    }else if(src != null){
       return Container(
          width: 200,
        height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: pureblue,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(src))
          ),

        );

      }else{
        return Container(
          width: 80,
        height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pureblue
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
    }

  }
     getYourIdImage( ImageSource source) async{

    var imageIdValid = await pick.getImage(source: source); 
       File crop = await ImageCropper.cropImage(
      sourcePath: imageIdValid.path ,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Where To Id Cropper',
          toolbarColor: pureblue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ) );
    setState(() {
      _idPickerImage = crop;
      
      // print(imageIdValid.path);
    });
    

  }


  @override
  void dispose() {

    super.dispose();
    getMenubyIds..drainStream();
  }


  delteMenu() async{
    await ApiCall().makeMenuFeatured('/deleteMenu/${widget.menuId}');
    print("delete Success");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: pureblue,
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => delteMenu(),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: pureblue,
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),  
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<MenuGetResponse>(
                        stream: getMenubyIds.subject.stream,
                        builder: (context, AsyncSnapshot<MenuGetResponse> snaphot){
                           if(snaphot.hasData){
              if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                  return _error(snaphot.data.error);
              }
                return _views(snaphot.data);
          }else if(snaphot.hasError){
                return _error(snaphot.error);
          }else{
                return _load();
        }


                        },),
                    ),
                     SizedBox(height: 20,),
                     Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: makeitFeatured,
                                      child: Container(
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: pureblue
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                Icon(
                                                Icons.featured_play_list,
                                                color: pureblue,
                                                size: 20,
                                              ),
                                              Text( loading ? "...":"Make It Featured",
                                              style: TextStyle(
                                                color: pureblue,
                                                fontFamily: 'Gilroy-light',
                                                fontSize: 12
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),  
                        ),

                         Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: updateMenu,
                                      child: Container(
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: pureblue
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                                Icon(
                                                Icons.update,
                                                color: pureblue,
                                                size: 20,
                                              ),
                                              Text(loading1 ? "...":"Update Menu",
                                              style: TextStyle(
                                                color: pureblue,
                                                fontFamily: 'Gilroy-light',
                                                fontSize: 12
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),  
                        ),
                        
                        
                      ],
                    ),
                  ),
                   SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      onWillPop: () async => false),
      
    );
  }


     Widget _load(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }
    Widget _error(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Error :  $error")
              ],
            ),
          );
}

  Widget _views(MenuGetResponse menuGetResponse){
  MenuGet mems = menuGetResponse.menuget;
     if(mems == 0 ){
          return Container(
            child: Text('Food Detail NONE.',
            style: TextStyle(
              color:pureblue,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{
          if(mems == null){
                      menuName.clear(); 
                    description.clear();
                     price.clear();
                   categoryId.clear();
                  } else{
                    // menuName.text = mems.menuName;
                    // description.text = mems.description;
                    // price.text = mems.price.toString();
                    categoryId.text = mems.categoryId.toString();
                      // src = mems.imagePath;
                  
                  }   
          return Form(
            key: formkey,
            child: Container(
              
              child: Column(
                      children: <Widget>[
                         Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10,),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 120,
                                        child: RaisedButton(
                                          child: Center(
                                            child: Text("Show Data.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light',

                                            ),
                                            ),
                                          ),
                                          color: pureblue,
                                          splashColor: Colors.amberAccent,
                                          onPressed: (){
                                            setState(() {
                                                  menuName.text = mems.menuName;
                    description.text = mems.description;
                    price.text = mems.price.toString();
                    categoryId.text = mems.categoryId.toString();
                    // markup.text = mems.markUpPercentage.toString();
                      src = mems.imagePath;

                                            });
                                          }),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 120,
                                        child: RaisedButton(
                                          child: Center(
                                            child: Text("Clear Data.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light',
                                              
                                            ),
                                            ),
                                          ),
                                          color: pureblue,
                                          splashColor: Colors.amberAccent,
                                          onPressed: (){
                                            setState(() {
                                                 menuName.clear();
                    description.clear();
                    price.clear();
                    // markup.clear();
                                            });
                                          }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          _getImage(),
                    SizedBox(height: 20,),
                     GestureDetector(
                                onTap: (){
                                  getYourIdImage(ImageSource.gallery);

                                }, 
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: pureblue,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                   child: Icon(Icons.picture_in_picture,
                                   size: 20,
                                   color: Colors.white
                                   ),
                                  ),
                                ),
                              ),
                    SizedBox(height: 30,),
                        TextEditGetter(
                          iconic: Icons.menu,
                          validate: (val) => val.isEmpty ? ' Please Put The Menu Name' : null,
                          control: menuName,
                          hint: "Menu Name",
                        ),
                        SizedBox(height: 15,),
                         TextEditGetter(
                          iconic: Icons.menu,
                          validate: (val) => val.isEmpty ? ' Please Put The Description' : null,
                          control: description,
                          hint: "Description",
                        ),
                        SizedBox(height: 15,),
                         TextEditGetter(
                          iconic: Icons.menu,
                          validate: (val) => val.isEmpty ? ' Please Put The Price' : null,
                          control: price,
                          hint: "Price",
                          // subs: (){
                          //   double x = 0.10;
                          //      double m = double.parse(price.text);
                          //       double xx = m*x;
                          //       print(xx/100);
                          //       setState(() {
                          //         markup.text = xx.toString();
                          //       });
                          // },
                        ),
                        SizedBox(height: 15,),
                        //  TextEditGetter(
                        //   iconic: Icons.menu,
                        //   validate: (val) => val.isEmpty ? ' Please Put The Price' : null,
                        //   control: markup,
                          
                        //   hint: "MarkUp",
                        // ),
                        SizedBox(height: 15,),
                         Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                      child:
            Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.menu,color: pureblue,)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child:
                             DropdownButton(
                                  isExpanded: true ,
                                  hint: Text( "Select Category",
                                  style: TextStyle(
                                      color:pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),),
                                  dropdownColor: Colors.white,
                                  icon: Icon(Icons.arrow_drop_down,color: pureblue,),
                                  value: toChoose == null ? categoryId.text : toChoose,
                                  items: dataCategory.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item['categoryName'],
                                    style: TextStyle(
                                      
                                      color: pureblue,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                  onChanged: (item){
                                    setState(() {
                                       toChoose = item;
                                      print(item);
                                    });
                                  }
                                  ),
                          ),
                        ],
                      ),
                    ),
                  
              )
            ),


                      ],
                    )
            ));

        }
  }

  void makeitFeatured() async{
    setState(() {
      loading  = true;
    });
    var feature = await ApiCall().makeMenuFeatured('/makeMenuFeatured/${widget.menuId}');
    print(feature.body);
     _showDial("The Menu is Featured Now.");
    setState(() {
      loading = false;
    });
      
  }

  void updateMenu() async{

    setState(() {
      loading1 = true;
    });

      if(formkey.currentState.validate()){
        formkey.currentState.save();

            if(_idPickerImage != null){
               var viewthis = path.basename(_idPickerImage.path);
         CloudinaryClient client = new CloudinaryClient(
                              "822285642732717",
                              "6k0dMMg3As30mPmjeWLeFL5-qQ4",
                              "amadpogi");
                            await client.uploadImage( _idPickerImage.path ,filename: "Menu/$viewthis") .then((result){
                                stringPath = result.secure_url;
                                  print(stringPath);
                                  thimagelink = stringPath;
                              })
                              .catchError((error) => print("ERROR_CLOUDINARY::  $error"));
            }else{
                  thimagelink = null;
            }

        var data = {
          

            'menuId': widget.menuId.toString(),
            'restaurantId': widget.restaurantId.toString(),
            'menuName': menuName.text,
            'description' : description.text,
            'price' :price.text,
            'imagePath': thimagelink != null ?  thimagelink : src.toString(),
            'categoryId': toChoose != null ?  toChoose: categoryId.text 
        };
        var updatemenu = await ApiCall().updateMenu(data, '/updateMenu');
        print(updatemenu.body);
         _showDial("Menu Successfully Updated");
        print(data);
      }else{
         _showDial("Something Went Wrong it Did not Save.");
      }

    setState(() {
      loading1 = false;
    });

  }  

  void _showDial( String message){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(message,
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    fontFamily: 'OpenSans'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      ),
    ); 
    },);
}

}