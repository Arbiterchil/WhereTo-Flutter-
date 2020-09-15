
import 'package:WhereTo/Rider/Rider_comments/rider_comment.dart';

class CommentResponse {



  final List<RiderComments> riderview;
  final String error;

  CommentResponse(this.riderview, this.error);

 CommentResponse.fromJson(List<RiderComments> json)
  : riderview = json,error = "" ;
    

  CommentResponse.withError(String errorvalue)
  : riderview = List<dynamic>(),
  error = errorvalue; 



}