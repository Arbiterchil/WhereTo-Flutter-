import 'package:WhereTo/Admin/view_saleOurs/remitApi_list.dart';
import 'package:WhereTo/Admin/view_saleOurs/view_reponselist.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RemiitanceStreamListbyDate{

final RemittanceListApi _remittanceListApi = RemittanceListApi();
final BehaviorSubject<RemiitanceListResponse> beSubject = BehaviorSubject<RemiitanceListResponse>();

getremitList(String dateFrom,String dateTo) async{
  RemiitanceListResponse remiitanceListResponse = 
  await _remittanceListApi.getRemittanceList(dateFrom, dateTo);
  beSubject.sink.add(remiitanceListResponse);
}

void drainstream(){beSubject.value = null;}
@mustCallSuper
void dispose() async{
  await beSubject.drain();
  beSubject.close();

}

  BehaviorSubject<RemiitanceListResponse> get subject => beSubject;

}

final remitListFromDate = RemiitanceStreamListbyDate();