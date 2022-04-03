import 'dart:convert';

import 'package:dio/dio.dart';

class TransactionsController1{
  
String base_url = "http://10.20.22.168/myfolder/transactions/transaction_expense.php";
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
}