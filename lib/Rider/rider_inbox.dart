import 'package:WhereTo/Rider/Rider_comments/comment_response.dart';
import 'package:WhereTo/Rider/Rider_comments/rider_com.dart';
import 'package:WhereTo/Rider/Rider_comments/rider_comment.dart';
import 'package:WhereTo/Rider/Rider_comments/rider_streamcomment.dart';
import 'package:flutter/material.dart';

class InboxRider extends StatefulWidget {
  @override
  _InboxRiderState createState() => _InboxRiderState();
}

class _InboxRiderState extends State<InboxRider> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentStream..getCommentView();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   height: 500,
                //   width: 500,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("asset/img/notifempty.png") 
                //     )
                //   ),
                // )
                getCommentary(),
              ],
             ),
           ),
        ),),
    );
  }


  Widget getCommentary(){
    return StreamBuilder<CommentResponse>(
      stream: commentStream.subject.stream,
      builder: (context , AsyncSnapshot<CommentResponse> snaphot){
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
      },
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
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


   Widget _views(CommentResponse commentResponse){
        List<RiderComments> rs = commentResponse.riderview;
        if(rs.length == 0 ){
          
           return Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("asset/img/notifempty.png") 
                    )
                  ),
                );

          // return Container(
          //   child: Text('Ok.',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontFamily: 'OpenSans',
          //     fontSize:  16.0,
          //     fontWeight: FontWeight.normal
          //   ),),
          // );
        }else{
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: rs.length,
                itemBuilder: (context,index){
                   return Padding(
                     padding: const EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
                     child: Column(
                       children: <Widget>[
                         
                      RiderCommentBox(
                        commentbox: rs[index].comment,
                      )
                        

                       ],
                     ),
                   );
                },
                ),
            ),
          );
        }
    }

}