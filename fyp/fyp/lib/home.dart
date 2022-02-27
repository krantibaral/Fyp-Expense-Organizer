import 'package:flutter/material.dart';
import 'package:fyp/AddIncome.dart';
import 'package:fyp/AllTransactions.dart';
import 'package:fyp/addExpense.dart';
import 'package:fyp/chart.dart';

import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';





void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  TextEditingController dateinput = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //toolbarHeight: 65,
        elevation: 5,
        actions: [
          IconButton(
           // onPressed: () {
              onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
            
            iconSize: 20,
            icon: Icon(Icons.calendar_today),
            color: Colors.white,
          ),
        ],
      
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
                    child: Text("Kranti Baral",
                        style: TextStyle(
                          color: Colors.white,
                            fontFamily: "Cookie",
                            fontWeight: FontWeight.w500,
                            fontSize: 30))),
                            SizedBox(height:10),
                            Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("baralkranti4@gmail.com",
                        style: TextStyle(
                          color: Colors.white,
                            fontFamily: "Cookie",
                            fontWeight: FontWeight.w500,
                            fontSize: 25))),
               
              ]),
            ),
            
            ListTile(
              leading: Icon(Icons.money_outlined),
              title: Text('Add Income',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Roboto Condensed',
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.money_off),
              title: Text('Add Expense',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz),
              title: Text('View Transactions',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.auto_graph),
              title: Text('View Reports',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Expense',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Income',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),

           
          
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "'Roboto Condensed'",
                      fontWeight: FontWeight.w400)),
            ),
          ])),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          height:340,
          color: Colors.white,
          child: PieChart(
            PieChartData(
            //  sections:data,
            )

          ),
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height:750,
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddIncome()));
                        },
                        child: Container(
                          height: 70,
                          width: 380,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.money,
                                  size: 40,
                                  color: Colors.green,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Add Income",
                                      style: TextStyle(fontSize: 18)),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(height:10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const addExpense()));
                        },
                        child: Container(
                          height: 70,
                          width: 380,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.money_off,
                                  size: 40,
                                  color: Colors.green,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Add Expense",
                                      style: TextStyle(fontSize: 18)),
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
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => allTransaction()));
                       },
       
                      child: Container(
                        height: 70,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.swap_horiz,
                                size: 40,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("All transactions",
                                    style: TextStyle(fontSize: 18)),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
                      height: 70,
                      width: 380,
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.auto_graph,
                              size: 40,
                              color: Colors.green,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("All report",
                                  style: TextStyle(fontSize: 18)),
                            )
                          ]),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        )
      ])),
    );
  }
}

