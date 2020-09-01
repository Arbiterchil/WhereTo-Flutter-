import 'package:WhereTo/Admin/Get_Sales/get_SaleResponses.dart';
import 'package:WhereTo/Admin/Get_Sales/get_salesApi.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GetSalesStream {

 final GetSaleApi _getSaleApi = GetSaleApi();
  final BehaviorSubject<GetSaleResponse> _subject = BehaviorSubject<GetSaleResponse>();

  getSalesReport(String date_From, String date_To, int ids) async{
    GetSaleResponse getSaleResponse =
     await _getSaleApi.getRestaurantSalesReport(date_To, date_From, ids);
    _subject.sink.add(getSaleResponse);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<GetSaleResponse> get subject => _subject;

}

final getSaleStream  = GetSalesStream();