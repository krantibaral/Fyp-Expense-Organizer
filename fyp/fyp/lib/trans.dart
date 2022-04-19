import 'package:flutter/material.dart';
import 'package:fyp/controllers/user_controller.dart';
import 'package:fyp/edit_transaction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'models/transaction.dart';
import 'models/report_filter.dart';

class allTransaction extends StatefulWidget {
  const allTransaction({Key? key}) : super(key: key);

  @override
  _allTransactionState createState() => _allTransactionState();
}

class _allTransactionState extends State<allTransaction> {
  ReportFilter filter = ReportFilter();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      if (!userController.isLoggedIn) return Text("Login first");
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: Text('All Transactions',
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
        body: FutureBuilder<List<Transaction>>(
            future: userController.isLoggedIn
                ? Transaction.getAllFromServer(userController.user!.id)
                : Future(() => []),
            builder: (context, snapshot) {
              var allTransactions = snapshot.data is List<Transaction>
                  ? (snapshot.data as List<Transaction>)
                      .where((element) => element.passes(filter))
                      .toList()
                  : [];
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      if (allTransactions.isNotEmpty)
                        SingleChildScrollView(
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
                        )
                      else
                        Center(
                          child: Text(
                              "No Transactions Found Yet. Add some from home page."),
                        ),
                      ...allTransactions
                          .map((transaction) => Card(
                                margin: EdgeInsets.all(5.0),
                                elevation: 5.0,
                                child: ListTile(
                                  onTap: () {},
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 15.0,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rs.${transaction.amount}",
                                        style: TextStyle(
                                            color: transaction.type == 'expense'
                                                ? Colors.red
                                                : Colors.green,
                                            fontFamily: 'Eczar',
                                            fontSize: 20),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black.withOpacity(
                                              0.4,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text(
                                          transaction.category.toString(),
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "${transaction.description}\n${DateFormat(DateFormat.YEAR_MONTH_DAY).format(transaction.date)}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTransaction(
                                                      transaction:
                                                          transaction)));
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.edit),
                                    color: Colors.black,
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                );
                // return ListView.builder(
                //   itemCount: snapshot.data!.length,
                //   itemBuilder: (context, index) {
                //     Transaction transaction = snapshot.data![index];

                //   },
                // );

              } else if (snapshot.hasError) {
                //print("Hello");
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else {
                return Center(
                    child: Text(
                  "Feteching your data.....",
                  style:
                      TextStyle(fontSize: 18, fontFamily: "Roboto Condensed"),
                ));
              }
            }),
      );
    });
  }
}
