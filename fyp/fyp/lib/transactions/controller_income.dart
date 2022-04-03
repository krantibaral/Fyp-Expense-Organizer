import 'dart:convert';

import 'package:dio/dio.dart';

class TransactionsController{
  
String base_url = "http://10.20.22.168/myfolder/transactions/transaction_income.php";
//String base_url1 = "http://192.168.100.129/myfolder/transactions/transaction_expense.php";
Dio dio = Dio();

Future <List> getData() async{
  try{
 var response = await dio.get(base_url);

 print(response.data);
// var decode = ;
 return jsonDecode(response.data)['data'];
 
  }  catch (e){
    print(e);
    return Future.error("Error Fetching your data");

  }
}
//Future <List> getData1() async{
//  try{
// var response = await dio.get(base_url1);
//
// print(response.data);
//// var decode = ;
// return jsonDecode(response.data)['data'];
// 
//  }  catch (e){
//    print(e);
//    return Future.error("Error Fetching your data");
//
//  }
//}

}