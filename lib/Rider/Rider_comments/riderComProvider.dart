import 'package:WhereTo/Rider/Rider_comments/comment_response.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_api.dart';

class RiderCommProvider{
  RiderApi _riderApi = RiderApi();
  Future<CommentResponse> getCommRider(){
    return _riderApi.getCommentary();
  }
}