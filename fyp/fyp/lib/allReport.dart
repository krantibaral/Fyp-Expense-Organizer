import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

void main() {
  runApp(allReport());
}

class allReport extends StatefulWidget {
  const allReport({Key? key}) : super(key: key);

  @override
  _allReportState createState() => _allReportState();
}

class _allReportState extends State<allReport> {
late List<charts.Series<Income, String>> _seriesBarChart;
_generateData(){
  var BarChart=[
     
    new Income("Rs.700", "Sun", Colors.red),
    new Income("Rs.800", "Mon", Colors.green),
    new Income("Rs.1900", "Tue", Colors.blue),
    new Income("Rs.1500", "Wed", Colors.purple),
    new Income("Rs.1700", "Thus", Colors.brown),
    new Income("Rs.700", "Fri", Colors.grey),
    new Income("Rs.700", "Sat", Colors.pink),
  ];

}


  @override
  void initState(){
    super.initState();
  //  _seriesBarChart = List<charts.Series<Income, String>>();
    _generateData(){
  }
  }




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
          title: Text('All Report',
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
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Stack(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                      ),
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                                color: Colors.black12,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, right: 200),
                          child: Column(children: [
                            Text(
                              "Report by Income",
                              style: TextStyle(
                                  fontFamily: "Roboto Condensed",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            Text(
                              "Category Food",
                              style: TextStyle(
                                  fontFamily: "Roboto Condensed",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                            


                          ]),
                        ),
                      )),
                ]),
              ],
            )));
  }
}

class Income{

  final String amount;
  final String day;
  final Color barColor;

  Income(this.amount, this.day, this.barColor);
}

