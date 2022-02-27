import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(allTransaction());
}

class allTransaction extends StatefulWidget {
  const allTransaction({Key? key}) : super(key: key);

  @override
  _allTransactionState createState() => _allTransactionState();
}

class _allTransactionState extends State<allTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // toolbarHeight: 65,
          elevation: 5,

          leading: IconButton(
            onPressed: () {},
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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Column(children: [
              Container(
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Text("January 2022", style: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.all(15.0),
                              width: 50,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text("2",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Eczar",
                                        fontSize: 18)),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 140.0,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text("Rs.300000",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Eczar',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300)))),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          width: 140.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text("Food",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.red,
                                                )),
                                          )),
                                    ],
                                  ),
                                 Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Row(children: [
                                   
                                        InkWell(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                        )
                                  ]))
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Colors.white,
                ),
                child: Stack(alignment: Alignment.centerLeft, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                        margin: EdgeInsets.all(15.0),
                        width: 50,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("29",
                              style: TextStyle(
                                  fontFamily: "Eczar",
                                  color: Colors.white,
                                  fontSize: 18)),
                        )),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 140.0,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text("Rs.9000",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'Eczar',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: 140.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text("Gifts",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.green,
                                        )),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Row(children: [
                                   
                                        InkWell(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                        )
                                  ])),
                            ],
                          ),
                        ]),
                  ]),
                ]),
              ),
            ])));
  }
}
