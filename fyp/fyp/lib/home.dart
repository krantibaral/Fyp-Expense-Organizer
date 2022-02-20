import 'package:flutter/material.dart';
import 'package:fyp/AddIncome.dart';
import 'package:fyp/addExpense.dart';


void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 65,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: Icon(Icons.calendar_today),
            color: Colors.white,
          ),
        ],
      
        title: Text('Add Income',
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
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/profile (2).png"),
                    radius: 60.0,
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text("Kranti Baral",
                        style: TextStyle(
                          color: Colors.white,
                            fontFamily: "Cookie",
                            fontWeight: FontWeight.w500,
                            fontSize: 30))),
               
              ]),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto Condensed',
                    fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: Text('Add Income',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Roboto Condensed',
                      fontWeight: FontWeight.w400)),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Add Expense',
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
          height: 400,
          color: Colors.white,
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height:400,
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
                Row(
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
                          height: 115,
                          width: 170,
                          decoration: BoxDecoration(
                              color: Colors.purple[100],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => addExpense()
                          ));
                        },
                        child: Container(
                          height: 115,
                          width: 170,
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.money_off_csred,
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
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 115,
                      width: 170,
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_copy_sharp,
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
                    Container(
                      height: 115,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
