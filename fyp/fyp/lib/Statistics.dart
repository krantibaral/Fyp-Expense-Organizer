import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import 'home.dart';

void main() {
  runApp(allReport());
}

class allReport extends StatefulWidget {
  const allReport({Key? key}) : super(key: key);

  @override
  _allReportState createState() => _allReportState();
}

class _allReportState extends State<allReport> {
 //List<_IncomeData> _chartData;

 // @override
 // void initState() {
   // _chartData = getChartData();
    // TODO: implement initState
   // super.initState();
  //}
  
  
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
            icon: Icon(Icons.filter_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.green;
                      return Colors.white;
                    }),
                  ),
                 
                  child: Text("Income",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Roboto Condensed",
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ),
                SizedBox(width: 35),
                ElevatedButton(
                  child: Text("Expense",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto Condensed",
                          color: Colors.black)),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.red;
                      return Colors.white;
                    }),
                  ),
                ),
              ])),
              SizedBox(height:10),
              SfCartesianChart(
                 primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Report by Category', textStyle: TextStyle(fontSize: 18, fontFamily: "Roboto Condensed"), ),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_IncomeData, String>>[
              LineSeries<_IncomeData, String>(
                  dataSource: getChartData(),
                  xValueMapper: (_IncomeData income, _) => income.category,
                  yValueMapper: (_IncomeData income, _) => income.amount,
                  name: 'Income',
                  color: Colors.green,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
               SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height:340,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Date',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Amount',
                          //  style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Category',
                          //   style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Description',
                          //   style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                     
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('12200')),
                          DataCell(Text('Gift')),
                          DataCell(Text('Gift')),
                         
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-12-02')),
                          DataCell(Text('12888')),
                          DataCell(Text('Food')),
                          DataCell(Text('Foods,bddkjfbewjfeiwhfiewfpjfo')),
                         
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('128888')),
                          DataCell(Text('Salary')),
                           DataCell(Text('Salary ksbkjs')),
                       
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('128888')),
                          DataCell(Text('Rent')),
                           DataCell(Text('Rent shabjkebfedf')),
                       
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('128888')),
                          DataCell(Text('Business')),
                           DataCell(Text('Business is love')),
                       
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('128888')),
                          DataCell(Text('Book')),
                          DataCell(Text('Book is hobby')),
                       
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('2022-11-01')),
                          DataCell(Text('128888')),
                          DataCell(Text('Book')),
                          DataCell(Text('Book is hobby')),
                       
                        ],
                      ),
                    
                     
                    
                    ],
                  ),
                ),
              ),
            ),
              
              
            
          

        ]),
      ),
    );
  }
   List<_IncomeData> getChartData(){
   final List<_IncomeData> chartData =[
     _IncomeData("Salary", 3000),
     _IncomeData("Gifts", 6060),
     _IncomeData("Business", 9000),
     _IncomeData("Rent", 8808),
     _IncomeData("Freelancing", 14400),
     _IncomeData("Dancing", 1030),
     _IncomeData("Cooking", 90),
     

   ];
   return chartData;
 }
}
class _IncomeData {
  _IncomeData(this.category, this.amount);

  final String category;
  final int amount;
}
