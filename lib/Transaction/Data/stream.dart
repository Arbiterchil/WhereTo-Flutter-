import 'package:WhereTo/Transaction/Data/repository.dart';
import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:rxdart/rxdart.dart';

class Stream{
  

  final Repository repository = Repository();
  final BehaviorSubject<Response> _subject =BehaviorSubject<Response>();
   final BehaviorSubject<Response> sub =BehaviorSubject<Response>();




  getdata() async{
    Response response =await repository.getData();
    _subject.sink.add(response);
  }


  dispose(){
    _subject.close();
  }
  BehaviorSubject<Response> get subject => _subject;
}
final userStream = Stream();