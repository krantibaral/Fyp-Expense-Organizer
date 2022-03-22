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
        title: Text('Statistics',
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
            icon: Icon(Icons.calendar_today),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      minimumSize: Size(140, 40),
                      //elevation: 5,
                      primary: (Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Income",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto Condensed",
                            fontWeight: FontWeight.w100,
                            color: Colors.black)),
                  ),
                  SizedBox(width: 35),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: getColor(Colors.white, Colors.teal)
                    )
                    //style: ElevatedButton.styleFrom(
                    //  splashFactory: NoSplash.splashFactory,
                    //  minimumSize: Size(140, 40),
                //
                    //  // elevation: 5,
                    //  
//
                    //  primary: (Colors.white),
                    //  shape: RoundedRectangleBorder(
                    //    borderRadius: BorderRadius.circular(10),
                    //  ),
                    //),
                    child: Text("Expense",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Roboto Condensed",
                            color: Colors.black)),
                  ),
                ],
              ))
        ]),
      ),
    );
    MaterialStateProperty<Color> getColor(Color color, Color colorPressed);
    return MaterialStateProperty.resolveWith(getColor);
  }
}
