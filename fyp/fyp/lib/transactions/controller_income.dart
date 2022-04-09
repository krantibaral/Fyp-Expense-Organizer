import 'dart:convert';

import 'package:dio/dio.dart';

class TransactionsController{
  
String base_url = "http://192.168.100.129/myfolder/transactions/transaction_income.php";

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

updateIncome(String id, String amount, String category, String date, String description) async {
  try{
    await dio.put("http://192.168.100.129/myfolder/transactions/update_transactions.php",
    data: jsonEncode(
      {
        "id" : id,
        "amount" :amount,
        "category": category,
        "date": date,
        "description": description,
      },
    ),
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    
    
  }on DioError catch(e){
    print(e);
    return Future.error("Error Updating your data");
  }
}

deletetransactions(String id)async{
    try{
    await dio.delete("http://192.168.100.129/myfolder/transactions/delete_transactions.php",
    data: jsonEncode(
      {
        "id" : id,
      
      },
    ),
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    
    
  }on DioError catch(e){
    print(e);
    return Future.error("Error deleting your data");
  }

  
}

}