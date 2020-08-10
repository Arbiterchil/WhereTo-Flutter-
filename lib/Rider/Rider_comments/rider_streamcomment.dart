
import 'package:WhereTo/Rider/Rider_comments/comment_response.dart';
import 'package:WhereTo/Rider/Rider_comments/rider_comment.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_api.dart';
import 'package:rxdart/rxdart.dart';

class CommentStream{


  final RiderApi riderApi = RiderApi();
  final BehaviorSubject<CommentResponse> subjects = BehaviorSubject<CommentResponse>();


  getCommentView() async{
    CommentResponse commentResponse = await  riderApi.getCommentary();
    subjects.sink.add(commentResponse);
  }

  BehaviorSubject<CommentResponse> get subject => subjects;

}

final commentStream = CommentStream();