import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<Computation, List<TransactionOrders>>{
  @override
  
  List<TransactionOrders> get initialState => List<TransactionOrders>();

  @override
  Stream<List<TransactionOrders>> mapEventToState(Computation event) async* {
   switch(event.eventType){
     
     case EventType.add:
      List<TransactionOrders> order =List.from(state);
      if(event.transactionOrders !=null){
        order.add(event.transactionOrders);
      }
       yield order;
       break;
     case EventType.deleteAll:
      List<TransactionOrders> order =List.from(state);
      order.clear();
      yield order;
      break;
      case EventType.delete:
      List<TransactionOrders> order =List.from(state);
      order.removeAt(event.index);
      yield order;
      break;
      default:
      throw Exception('Event not found $event');
   }
    
  }

}