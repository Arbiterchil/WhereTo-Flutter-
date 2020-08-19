import 'dart:convert';

import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_imageda.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../styletext.dart';
class ViewAllImageId extends StatefulWidget {

  @override
  _ViewAllImageIdState createState() => _ViewAllImageIdState();
}

  
  
  

  

class _ViewAllImageIdState extends State<ViewAllImageId> {
  List url = List();
  var getThis;
  var sample;
  var consti = "https://661529868759591:6HJCxVBM8oUap_rIjqc24kKfR5w@api.cloudinary.com/v1_1/ddoiozfmr/resources/image/upload";
  
  Future<List<Resources>>  getPhotos() async {
    return await http.get(consti).then((response) {
      Data an = Data.fromJson(json.decode(response.body.toString()));
      return an.resources;
     
    });

  
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 20,top: 10),
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>
                      [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: GestureDetector(
                              onTap: (){

                                // uploadImagtoCloud();
                                Navigator.pushReplacement(context,
                           new MaterialPageRoute(builder: (context) => AdminDash()));
                              },
                              // _signingIn,
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: pureblue,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Center(
                                  child: Text( 'Back <',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-ExtraBold',
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                  ),
                                ),
                              ),
                            ),
                            ),
                        )
                      ],
                    ),
                ),
                 ),
                SizedBox(height: 20.0,),
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
        builder: ( context,  snapshot) {
          if (snapshot.hasData == null) {
            return Center(child: Text("Getting Images Please Wait.",
            style: TextStyle(
              color: pureblue,
              fontFamily: 'Gilroy-ExtraBold',
              fontSize: 35
            ),),);
          }else if (snapshot.data != null) {
              Map<String ,String > url = {};
              Map<String ,String > ushit = {};
              List<dynamic> dataurls = [];
              List result = [];
              List<Resources>resources = snapshot.data;
            

              resources.forEach((element) { 
                url = {

                  "link": element.secureUrl,
                  "format" : element.publicId+"."+element.format,
                  "name": element.publicId  
                };
                dataurls.add(url);
              });
              for(int i =0 ; i < dataurls.length; i++){
                // result.add();
                if(dataurls[i]['name'].toString().startsWith("image_cropper")){
                    result.add(
                      {
                        'link': dataurls[i]['link'],
                        'name': dataurls[i]['name']
                      }
                    );
                }
              }
            ushit.forEach((key, value) {
                result.add(
                  {
                    'link': value,
                    // 'format': value,
                    'name': value
                  }
                );
            });
            print(result);
              return Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.74,
                  shrinkWrap: false,
                  children: result.map((i) {
                    return GestureDetector(
                      onTap: () {
                        getThis = i['link'];
                        _showDial(i['link']);
                        
                        print(getThis);
                      
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          children: <Widget>[
                            new ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Hero(
                                tag: i['link'],
                                child: Image.network(
                                  i['link'],
                                  width: MediaQuery.of(context).size.width,
                                  height: 208,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } 
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
        future: getPhotos(),
      ), 
                ),
              ],
            ),
          )),
      ),
      
    );
  }

  void _showDial(String resources){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:Container(
        height: 500.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                 child: Container(
                      child: Hero(
                  tag: resources,
                  child: Image.network(
                    resources,
                    fit: BoxFit.fitWidth,
                  ),
              ),
                 ),
               ),
              ],
          ),
        ),
      )
    ); 
    },);
}

}

