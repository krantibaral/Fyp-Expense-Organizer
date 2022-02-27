import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

void main() {
  runApp(addExpense());
}

class addExpense extends StatefulWidget {
  const addExpense({Key? key}) : super(key: key);

  @override
  _addExpenseState createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  var _categories = [
    "Foods",
    "Clothes",
    "Fuel",
    "Entertinment",
    "Health",
    "Education",
    "Rent",
    "Loan",
    "Electricity",
    "Gifts",
    "Personal Expenses",
    "Gadgets",
  ];
  var _currentItemSelected = "Foods";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       // toolbarHeight: 65,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {},
            iconSize: 20,
            icon: Icon(Icons.done_outline_outlined),
            color: Colors.white,
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text('Add Expense',
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
      body: Form(
        key: _formKey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Amount',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        controller: amount,
                        validator: Validators.compose([
                          Validators.required('Amount is required'),
                          Validators.min(1, 'Value less than 1 not allowed'),
                        ]),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            focusedErrorBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black26,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            contentPadding: EdgeInsets.only(top: 14),
                            prefixIcon:
                                Icon(Icons.money, color: Color(0xff5ac18e)),
                            //hintText: "Enter Amount",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26),
                        ),
                        height: 50,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 36,
                            items: _categories.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected!;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                        )),
                    SizedBox(height: 20),
                    Text(
                      'Date',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        controller:
                            dateinput, //editing controller of this TextField
                        validator: Validators.compose([
                          Validators.required('Date is required'),
                     
                        ]),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            focusedErrorBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black26,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            contentPadding: EdgeInsets.only(top: 14),
                            prefixIcon: Icon(Icons.calendar_today,
                                color: Color(0xff5ac18e)),
                          //  hintText: "Enter Date",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w400)), //icon of text field
                        // hintText: "Enter Date" //label text of field

                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
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
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Time',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        validator: Validators.compose([
                          Validators.required('Time is required'),
                        
                        ]),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            focusedErrorBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.black26, width: 0.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black26,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            contentPadding: EdgeInsets.only(top: 14),
                            prefixIcon:
                                Icon(Icons.timelapse, color: Color(0xff5ac18e)),
                           // hintText: "Enter Time",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                        controller:
                            timeinput, //editing controller of this TextField

                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeinput.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(
                            "Description",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            child: Center(
                              child: TextFormField(
                                validator: Validators.compose([
                                  Validators.required('Description is required'),
                                 
                                ]),
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black87),
                                maxLines: 8,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: new BorderSide(
                                          color: Colors.black26, width: 0.0),
                                    ),
                                    errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: new BorderSide(
                                          color: Colors.black26, width: 0.0),
                                    ),
                                    focusedErrorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.black26, width: 0.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: new BorderSide(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusColor: Colors.black26,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                    ),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.description,
                                        color: Color(0xff5ac18e)),
                                    hintStyle: TextStyle(
                                        color: Colors.black38,
                                        fontFamily: 'Roboto Condensed',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(10, 50),
                                  elevation: 2,
                                  primary: (Color(0xcc5ac18e)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 20,
                                    fontFamily: 'Roboto Condensed',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])),
                  ])),
        ),
      ),
    );
  }
}