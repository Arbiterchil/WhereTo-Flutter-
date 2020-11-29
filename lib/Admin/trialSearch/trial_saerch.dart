import 'package:WhereTo/Admin/trialSearch/filteringMenu.dart';
import 'package:WhereTo/Admin/trialSearch/futureApigetter.dart';
import 'package:WhereTo/Admin/updateAdmin/dialog_chooser.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchforAdmin extends StatefulWidget {

  final String fromAdminSearch;

  const SearchforAdmin({Key key, this.fromAdminSearch}) : super(key: key);

  @override
  _SearchforAdminState createState() => _SearchforAdminState(fromAdminSearch);
}

class _SearchforAdminState extends State<SearchforAdmin> {
  
  final String fromAdminSearch;

  _SearchforAdminState(this.fromAdminSearch);
  


  @override
  void initState() {
    super.initState();
    // ok();
    ok();
  } 

  @override
  void dispose() {
    super.dispose();
    
  } 

  ok() async{
    futureTrial..getMenuAll(UserGetPref().idSearch, fromAdminSearch);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Container(
        height: 700.0,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<List<FilteringMenuTrial>>(
          stream: futureTrial.sinkstream,
          builder: (context, snapshot){
              if(snapshot.hasData){
              if(snapshot.data.length >0){
                  return new StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemBuilder: (context,index){
                         if(snapshot.data.length >0){
                            return GestureDetector(
                        onTap: () async{
                          
                          //imung Click Bait
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (contexr){

                              return ChooseEditto
                              (
              menuId: snapshot.data[index].menuId ,
              restaurantId: snapshot.data[index].restaurantId,
                              );

                            }
                             );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data[index].imagePath,
                                    ),
                                    fit: BoxFit.cover)
                                ),
                              ),
                              Container(
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      colors: [
                       Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.0),

                      ],
                      stops: [0.3,2.5],
                      )
                      ,
                ),
                ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  decoration: BoxDecoration(

                                    // color: pureblue
                                  ),
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                            child: Text (snapshot.data[index].restaurantName,
                                                overflow: TextOverflow.ellipsis,
                                                style :TextStyle(

                                                    color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14.0,
                                                        fontFamily: 'Gilroy-ExtraBold'
                                          ),),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Flexible(
                                          child: Container(
                                            child: Text (snapshot.data[index].menuName,
                                            overflow: TextOverflow.ellipsis,
                                                style :TextStyle(
                                                    color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 11.0,
                                                        fontFamily: 'Gilroy-light'
                                          ),),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),  
                        ),
                      );
                        }else{
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(strokeWidth: 5,),
                      ),
                    );
                  }
                      
                    },
                    itemCount: snapshot.data.length,
                    staggeredTileBuilder: (index){
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                },);
              }else{
              return Center(
              child: Image.asset("asset/img/nosearch.png")
              );
              }

            }else{
              return Center(
                child: Container(
                child: CircularProgressIndicator(strokeWidth: 5,),
                ),
              );
            }
            
          }),
      ),
    );
  }
}