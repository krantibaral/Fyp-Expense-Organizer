import 'package:flutter/material.dart';
import 'package:fyp/transactions/controller.dart';

import '../home.dart';




void main() {
  runApp(allTransaction());
}

class allTransaction extends StatefulWidget {
  const allTransaction({Key? key}) : super(key: key);

  @override
  _allTransactionState createState() => _allTransactionState();
}

class _allTransactionState extends State<allTransaction> {
  TransactionsController transactionsController = TransactionsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // toolbarHeight: 65,
          elevation: 5,

          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage())));
          
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: Text('All Transactions',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto Condensed',
                  fontWeight: FontWeight.w400,
                  fontSize: 24)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    // begin: Alignment.topCenter,
                    // end: Alignment.bottomCenter,
                    colors: [
                  //Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ])),
          ),
        ),
        body: FutureBuilder<List>(
          future: transactionsController.getData(),
          
          builder: (context, snapshot) {
          
          if(snapshot.hasData){
            return Container(
              child: Text(snapshot.data.toString()),
            );
          

          }else if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),
            );

          }else{
            return Center(child: Text("Feteching your data.....", style:TextStyle(fontSize:18, fontFamily: "Roboto Condensed"),
             ) );
          }
        }

    )
    );

  }
}