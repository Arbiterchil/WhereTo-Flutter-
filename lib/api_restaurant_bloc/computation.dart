import 'package:WhereTo/Transaction/orders.dart';
import 'package:flutter/foundation.dart';


enum EventType{add,delete,deleteAll}

class Computation {
TransactionOrders transactionOrders;
int index;
EventType eventType;
List<TransactionOrders> order;

Computation();

Computation.add(TransactionOrders transactionOrders){
  this.eventType =EventType.add;
  this.transactionOrders =transactionOrders;
}

Computation.delete(int index){
  this.eventType =EventType.delete;
  this.index =index;
}
Computation.deleteAll(){
  this.eventType =EventType.deleteAll;
}

}

class TransactionOrders{
  String name;
  String description;
  int price;
  int quantity;
  

  TransactionOrders({this.name, this.description, this.price, this.quantity});

}