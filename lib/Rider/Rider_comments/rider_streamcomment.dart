
import 'package:WhereTo/Rider/Rider_comments/comment_response.dart';
import 'package:WhereTo/Rider/Rider_comments/riderComProvider.dart';
import 'package:WhereTo/Rider/Rider_comments/rider_comment.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_api.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentStream{


  final RiderCommProvider _riderCommProvider = RiderCommProvider();
  final BehaviorSubject<CommentResponse> subjects = BehaviorSubject<CommentResponse>();


  getCommentView() async{
    CommentResponse commentResponse = await  _riderCommProvider.getCommRider();
    subjects.sink.add(commentResponse);
  }

   void drainStream(){subjects.value = null;}
@mustCallSuper
  void dispose() async{
    
    await subjects.drain();
    subjects.close();
  }
  BehaviorSubject<CommentResponse> get subject => subjects;

}

final commentStream = CommentStream();