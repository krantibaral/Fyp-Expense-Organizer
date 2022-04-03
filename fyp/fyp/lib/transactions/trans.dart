import 'package:flutter/material.dart';
import 'package:fyp/transactions/controller_income.dart';

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
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt),
            color: Colors.white,
          )
        ],
      ),
      body: FutureBuilder<List>(
          future: transactionsController.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map data = snapshot.data![index];
                   print(data['Type']);
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      title: Text(
                        "Rs.${data['Amount']}",
                       
                        style: TextStyle(
                            color: data['Type']=="Expense"? Colors.red:Colors.green,
                            fontFamily: 'Eczar',
                            fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "${data['Category']}  (${data['Date']})  ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Roboto Condensed',
                            fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
              //child: Text(snapshot.data.toString()),

            } else if (snapshot.hasError) {
              //print("Hello");
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return Center(
                  child: Text(
                "Feteching your data.....",
                style: TextStyle(fontSize: 18, fontFamily: "Roboto Condensed"),
              ));
            }
          }),
    );
  }
}
