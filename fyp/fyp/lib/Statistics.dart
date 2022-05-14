import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/controllers/user_controller.dart';
import 'package:fyp/models/transaction.dart';
import 'package:fyp/models/report_filter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class allReport extends StatefulWidget {
  const allReport({Key? key}) : super(key: key);
  @override
  _allReportState createState() => _allReportState();
}

class _allReportState extends State<allReport> {
  ReportFilter filter = ReportFilter();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      if (!userController.isLoggedIn) return Text("Login first");

      return FutureBuilder(
          future: Transaction.getAllFromServer(userController.user!.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StatefulBuilder(builder: (context, setState) {
                List<Transaction> allTransactions =
                    (snapshot.data as List<Transaction>)
                        .where((element) => element.passes(filter))
                        .toList();
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 5,
                    title: Text('Statistics',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w400,
                            fontSize: 24)),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color(0x995ac18e),
                        Color(0xcc5ac18e),
                        Color(0xff5ac18e),
                      ])),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // DropdownButton<String>(
                              //   value: filter.type,
                              //   elevation: 16,
                              //   underline: Container(
                              //     height: 2,
                              //     color: Colors.grey,
                              //   ),
                              //   onChanged: (String? newValue) {
                              //     if (newValue != null) {
                              //       setState(() {
                              //         filter.type = newValue.toLowerCase();
                              //       });
                              //     }
                              //   },
                              //   items: <String>[
                              //     'Income',
                              //     'Expense'
                              //   ].map<DropdownMenuItem<String>>((String value) {
                              //     return DropdownMenuItem<String>(
                              //       value: value.toLowerCase(),
                              //       child: Text(value),
                              //     );
                              //   }).toList(),
                              // ),
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("From "),
                                      Text(filter.from != null
                                          ? DateFormat(
                                                  DateFormat.YEAR_MONTH_DAY)
                                              .format(filter.from!)
                                          : "Any Time"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: filter.from ??
                                                DateTime.now().subtract(
                                                    Duration(days: 30)),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            filter.from = pickedDate;
                                            setState(() {});
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        icon: Icon(
                                          Icons.date_range,
                                          size: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            filter.from = null;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("To "),
                                      Text(filter.to != null
                                          ? DateFormat(
                                                  DateFormat.YEAR_MONTH_DAY)
                                              .format(filter.to!)
                                          : "Any Time"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                filter.to ?? DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            filter.to = pickedDate;
                                            setState(() {});
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        icon: Icon(
                                          Icons.date_range,
                                          size: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            filter.to = null;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                            text: 'Report by Category',
                            textStyle: TextStyle(
                                fontSize: 18, fontFamily: "Roboto Condensed"),
                          ),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<ChartData, String>>[
                            LineSeries<ChartData, String>(
                              dataSource: categorize(allTransactions, "income"),
                              xValueMapper: (ChartData data, _) =>
                                  data.categoryName,
                              yValueMapper: (ChartData data, _) => data.money,
                              name: 'Income',
                              color: Colors.green,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            ),
                            LineSeries<ChartData, String>(
                              dataSource:
                                  categorize(allTransactions, "expense"),
                              xValueMapper: (ChartData data, _) =>
                                  data.categoryName,
                              yValueMapper: (ChartData data, _) => data.money,
                              name: 'Expense',
                              color: Colors.red,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            ),
                          ]),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 340,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Date',
                                     style: TextStyle(fontFamily: "Roboto Condensed"),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Amount',
                                    style: TextStyle(fontFamily: "Roboto Condensed"),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Category',
                                    style: TextStyle(fontFamily: "Roboto Condensed"),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Description',
                                    style: TextStyle(fontFamily: "Roboto Condensed"),
                                  ),
                                ),
                              ],
                              rows: allTransactions
                                  .map(
                                    (e) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            DateFormat(
                                                    DateFormat.YEAR_MONTH_DAY)
                                                .format(e.date),
                                          ),
                                        ),
                                        DataCell(Text(
                                          e.amount.toString(),
                                          style: TextStyle(
                                            color: e.type == 'income'
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        )),
                                        DataCell(
                                          Text(e.category),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 150,
                                            child: Text(e.description ?? ""),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CupertinoActivityIndicator();
          });
    });
  }

  List<ChartData> categorize(List<Transaction> transactions, String by) {
    List<ChartData> toReturn = [];
    transactions
        .where((element) => element.type == by)
        .toList()
        .forEach((transaction) {
      int addToIndex = -1;
      for (var i = 0; i < toReturn.length; i++) {
        if (toReturn[i].categoryName.toLowerCase() ==
            transaction.category.toLowerCase()) {
          addToIndex = i;
          break;
        }
      }
      if (addToIndex != -1) {
        toReturn[addToIndex].money += transaction.amount;
      } else {
        toReturn.add(ChartData(transaction.category, transaction.amount));
      }
    });
    return toReturn;
  }
}

class ChartData {
  String categoryName;
  double money;
  ChartData(this.categoryName, this.money);
}
