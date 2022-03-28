import 'package:dio/dio.dart';

class TransactionsController{
  
String base_url = "http://192.168.100.129/myfolder/transactions/transactions.php";
Dio dio = Dio();

Future<List> getData() async{
  try{
 var response = await dio.get(base_url);

 print(response.data);
 return response.data['data'];
 
  } on DioError catch (e){
    print(e);
    return Future.error("Error Fetching your data");

  }
}
}