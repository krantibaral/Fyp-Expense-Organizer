import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp/add_transaction.dart';
import 'package:fyp/Statistics.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/controllers/user_controller.dart';
import 'package:fyp/login_page.dart';
import 'package:fyp/models/transaction.dart';
import 'package:fyp/trans.dart';
import 'package:fyp/widgets/Calculator.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  TextEditingController dateinput = TextEditingController();

  List<Color> colorList = [
    const Color(0xfffa4a42),
    const Color(0xff3ee094),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      if (!userController.isLoggedIn) return Text("Login First");
      return FutureBuilder<Map<String, double>>(
          future: http
              .post(Uri.parse(kBackendURL + "/transactions/thisMonthStat.php"),
                  headers: {"Content-Type": "application/json"},
                  body: jsonEncode({
                    "userid": userController.user!.id,
                  }))
              .then((response) {
            if (response.statusCode != 200) {
              throw Exception(
                  "Response status: " + response.statusCode.toString());
            }
            var body = jsonDecode(response.body);
            if (body['status'] != 'success') {
              throw Exception(body['error'] ?? "Server Error");
            }
            var transactions = (body['transactions'] as List)
                .map((e) => Transaction.fromPayload(e))
                .toList();
            Map<String, double> result = {
              'expense': 0.0,
              'income': 0.0,
              'total': 0.0,
            };
            for (var element in transactions) {
              if (element.type == 'expense') {
                result['expense'] = result['expense']! + element.amount;
              } else {
                result['income'] = result['income']! + element.amount;
              }
              result['total'] = result['income']! - result['expense']!;
            }
            return result;
          }),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 5,
                title: Text('Expense Organizer',
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
              drawer: Drawer(
                  elevation: 8,
                  child: ListView(children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              // begin: Alignment.topCenter,
                              // end: Alignment.bottomCenter,
                              colors: [
                            Color(0x665ac18e),
                            Color(0x995ac18e),
                            Color(0xcc5ac18e),
                            Color(0xff5ac18e),
                          ])),
                      child: Stack(children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Text(userController.user!.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Cookie",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30))),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(userController.user!.email,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Cookie",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25))),
                      ]),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTransaction(
                                      type: 'income',
                                    )));
                      },
                      leading: Icon(Icons.money_outlined),
                      title: Text('Add Income',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto Condensed',
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTransaction(
                                      type: 'expense',
                                    )));
                      },
                      leading: Icon(Icons.money_off),
                      title: Text('Add Expense',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "'Roboto Condensed'",
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => allTransaction()));
                      },
                      leading: Icon(Icons.swap_horiz),
                      title: Text('View Transactions',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "'Roboto Condensed'",
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => allReport()));
                      },
                      leading: Icon(Icons.auto_graph),
                      title: Text('View Statistics',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "'Roboto Condensed'",
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => allTransaction()));
                      },
                      leading: Icon(Icons.edit),
                      title: Text('Edit Expense',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "'Roboto Condensed'",
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => allTransaction()));
                      },
                      leading: Icon(Icons.edit),
                      title: Text('Edit Income',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "'Roboto Condensed'",
                              fontWeight: FontWeight.w400)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Calculator()),
                        );
                      },
                      leading: Icon(Icons.calculate),
                      title: Text(
                        'Calculator',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "'Roboto Condensed'",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        userController.setUser(null);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                      leading: Icon(Icons.logout),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "'Roboto Condensed'",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ])),
              body: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  height: 340,
                  color: Colors.white,
                  child: snapshot.hasData && snapshot.data!.isNotEmpty
                      ? PieChart(
                          dataMap: {
                            "Expense": snapshot.data!['expense'] ?? 0,
                            "Income": snapshot.data!['income'] ?? 0,
                          },
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          centerText: DateFormat(DateFormat.YEAR_MONTH)
                              .format(DateTime.now()),
                          chartType: ChartType.ring,
                          animationDuration: Duration(seconds: 3),
                          ringStrokeWidth: 40,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesOutside: true,
                            showChartValueBackground: true,
                          ),
                          legendOptions: LegendOptions(
                            showLegends: true,
                            legendShape: BoxShape.rectangle,
                            legendTextStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto Condensed',
                                fontWeight: FontWeight.w500),
                            legendPosition: LegendPosition.bottom,
                            showLegendsInRow: true,
                          ),
                        )
                      : snapshot.hasError
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                snapshot.error.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ))
                          : Center(child: Text("Loading...")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Container(
                    height: 45,
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
                    child: Center(
                        child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Total Amount:  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Roboto Condensed',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: snapshot.hasData
                              ? "Rs. " + (snapshot.data!['total'].toString())
                              : snapshot.hasError
                                  ? "Rs. 0"
                                  : "Loading...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Eczar',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                    )),
                  ),
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: 750,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x665ac18e),
                              Color(0x995ac18e),
                              Color(0xcc5ac18e),
                              Color(0xff5ac18e),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTransaction(
                                                type: 'income',
                                              )));
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  width: 370,
                                  decoration: BoxDecoration(
                                      color: Colors.lime[100],
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ]),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.money,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Add Income",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily:
                                                      'Roboto Condensed')),
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddTransaction(
                                                type: 'expense',
                                              )));
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  width: 370,
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ]),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.money_off,
                                          size: 40,
                                          color: Colors.green,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Add Expense",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily:
                                                      "Roboto Condensed")),
                                        )
                                      ]),
                                ),
                              ),
                            ]),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              splashColor: Colors.green,
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            allTransaction()));
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 370,
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.swap_horiz,
                                        size: 40,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Transactions",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily:
                                                    'Roboto Condensed')),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                if (!userController.user!.subscribed) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Add Subscription",
                                              style: TextStyle(
                                                fontFamily: "Roboto Condensed",
                                                fontWeight: FontWeight.w600,
                                              )),
                                          content: Text(
                                              "If you want to see your Statistics report then do pay through Khalti or Try Free trial for 1 month??",
                                              style: TextStyle(
                                                  fontFamily:
                                                      "Roboto Condensed",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          actions: <Widget>[
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  child: Text("Free Trial",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Roboto Condensed",
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    // minimumSize: Size(200, 50),
                                                    //elevation: 5,
                                                    primary:
                                                        (Color(0xff5ac18e)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                allReport()));
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                ElevatedButton(
                                                  child: Text("Khalti Payment",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Roboto Condensed",
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    //minimumSize: Size(200, 50),
                                                    // elevation: 5,
                                                    primary:
                                                        (Color(0xff5ac18e)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    KhaltiScope.of(context).pay(
                                                        config: PaymentConfig(
                                                            amount: 200,
                                                            productIdentity:
                                                                Random()
                                                                    .nextInt(
                                                                        999999)
                                                                    .toString(),
                                                            productName:
                                                                "Expense Organizer Subscription"),
                                                        onSuccess:
                                                            (model) async {
                                                          print(
                                                              model.toString());

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "Khalti Payment Succeeded"),
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "Please wait..."),
                                                            ),
                                                          );

                                                          try {
                                                            var resp = await http.post(
                                                                Uri.parse(
                                                                    kBackendURL +
                                                                        "/subscribe_to_khalti.php"),
                                                                headers: {
                                                                  "Content-Type":
                                                                      "application/json"
                                                                },
                                                                body:
                                                                    jsonEncode({
                                                                  "userid":
                                                                      userController
                                                                          .user!
                                                                          .id,
                                                                }));
                                                            var jresp =
                                                                jsonDecode(
                                                                    resp.body);
                                                            if (jresp[
                                                                    'status'] !=
                                                                'success') {
                                                              throw Exception(
                                                                  "Could not save in database.");
                                                            }
                                                            userController.user!
                                                                    .subscribed =
                                                                true;
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    "Subscription Added successfully"),
                                                              ),
                                                            );
                                                          } catch (e) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    "Error: " +
                                                                        e.toString()),
                                                              ),
                                                            );
                                                          }

                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          allReport()));
                                                        },
                                                        onFailure: (model) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "Khalti Payment Failed"),
                                                            ),
                                                          );
                                                          Navigator.of(context)
                                                              .pop();
                                                          print(
                                                              model.toString());
                                                        });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => allReport()));
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 370,
                                decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.auto_graph,
                                        size: 40,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Statistics",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily:
                                                    'Roboto Condensed')),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                )
              ])),
            );
          });
    });
  }
}
