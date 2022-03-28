import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/home.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:http/http.dart' as http;

//import 'login_page.dart';

void main() {
  runApp(AddIncome());
}

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _formKey = GlobalKey<FormState>();
  bool visible = false;
  TextEditingController dateinput = TextEditingController();

  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  Future addIncome() async {
    setState(() {
      visible = true;
    });

    String amount = amountController.text;
    String category = categoryController.text;
    String description = descriptionController.text;

    var data = {'amount' : amount, 'category' : category, 'description': description};
    print(data);

    var response = await http.post(
     Uri.parse("http://192.168.100.129/myfolder/addIncome/addIncome.php"),
     body: json.encode(data),
     headers:{"Content-Type": "application/json"});
    var message = jsonDecode(response.body);
    print(message);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  


  //void initState() {
  //  dateinput.text = ""; //set the initial value of text field
  //  super.initState();
  //}
  //var _categories = [
  //  "Salary",
  //  "Gifts",
  //  "Interest",
  //  "Rent Seeking",
  //  "Bussiness",
  //  "Freelancing"
  //];
  //var _currentItemSelected = "Salary";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //toolbarHeight: 65,
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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
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
                        controller: amountController,
                        validator: Validators.compose([
                          Validators.required('Amount is required'),
                          Validators.patternRegExp(
                  RegExp(
                      r'^[0-9]*$'),
                  'Accept only numbers'),
            ]),
                        keyboardType: TextInputType.number,
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
                      child: TextFormField(
                        controller: categoryController,
                        validator: Validators.compose([
                          Validators.required('Category is required'),
                         Validators.minLength(1, 'Category cannot be less than 1 characters'),
              
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
                                Icon(Icons.category, color: Color(0xff5ac18e)),
                            //hintText: "Enter Amount",
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Roboto Condensed',
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    //child: DropdownButtonHideUnderline(
                    //  child: DropdownButton<String>(
                    //
                    //    isExpanded: true,
                    //    iconSize: 36,
                    //    items: _categories.map((String dropDownStringItem) {
                    //      return DropdownMenuItem<String>(
                    //        value: dropDownStringItem,
                    //        child: Text(
                    //          dropDownStringItem,
                    //          style: TextStyle(fontSize: 18),
                    //        ),
                    //      );
                    //    }).toList(),
                    //    onChanged: (newValueSelected) {
                    //      setState(() {
                    //        this._currentItemSelected = newValueSelected!;
                    //      });
                    //    },
                    //    value: _currentItemSelected,
                    //  ),
                    //)),
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
                //SizedBox(height: 20),
                //Text(
                //  'Time',
                //  style: TextStyle(
                //      color: Colors.black,
                //      fontSize: 18,
                //      fontFamily: 'Rubik',
                //      fontWeight: FontWeight.w400),
                //),
                //SizedBox(height: 10),
                //Container(
                //  child: TextFormField(
                //    validator: Validators.compose([
                //      Validators.required('Time is required'),
                //    ]),
                //    keyboardType: TextInputType.text,
                //    style: TextStyle(color: Colors.black87),
                //    decoration: InputDecoration(
                //        border: new OutlineInputBorder(
                //          borderRadius: BorderRadius.circular(10),
                //          borderSide: new BorderSide(
                //              color: Colors.black26, width: 0.0),
                //        ),
                //        errorBorder: new OutlineInputBorder(
                //          borderRadius: BorderRadius.circular(10),
                //          borderSide: new BorderSide(
                //              color: Colors.black26, width: 0.0),
                //        ),
                //        focusedErrorBorder: new OutlineInputBorder(
                //          borderSide: new BorderSide(
                //              color: Colors.black26, width: 0.0),
                //        ),
                //        enabledBorder: OutlineInputBorder(
                //          borderRadius: BorderRadius.circular(10),
                //          borderSide: new BorderSide(
                //            color: Colors.black26,
                //          ),
                //        ),
                //        filled: true,
                //        fillColor: Colors.white,
                //        focusColor: Colors.black26,
                //        focusedBorder: OutlineInputBorder(
                //          borderRadius: BorderRadius.circular(10),
                //          borderSide: BorderSide(color: Colors.black26),
                //        ),
                //        contentPadding: EdgeInsets.only(top: 14),
                //        prefixIcon:
                //            Icon(Icons.timelapse, color: Color(0xff5ac18e)),
                //        // hintText: "Enter Time",
                //        hintStyle: TextStyle(
                //            color: Colors.black38,
                //            fontFamily: 'Roboto Condensed',
                //            fontSize: 15,
                //            fontWeight: FontWeight.w400)),
                //    controller:
                //        timeinput, //editing controller of this TextField
                //    readOnly:
                //        true, //set it true, so that user will not able to edit text
                //    onTap: () async {
                //      TimeOfDay? pickedTime = await showTimePicker(
                //        initialTime: TimeOfDay.now(),
                //        context: context,
                //      );
                //      if (pickedTime != null) {
                //        print(pickedTime.format(context)); //output 10:51 PM
                //        DateTime parsedTime = DateFormat.jm()
                //            .parse(pickedTime.format(context).toString());
                //        //converting to DateTime so that we can further format on different pattern.
                //        print(parsedTime); //output 1970-01-01 22:53:00.000
                //        String formattedTime =
                //            DateFormat('HH:mm:ss').format(parsedTime);
                //        print(formattedTime); //output 14:59:00
                //        //DateFormat() is from intl package, you can format the time on any pattern you need.
                //        setState(() {
                //          timeinput.text =
                //              formattedTime; //set the value of text field.
                //        });
                //      } else {
                //        print("Time is not selected");
                //      }
                //    },
                //  ),
                //),
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
                                controller: descriptionController,
                                validator: Validators.compose([
                                  Validators.required(
                                      'Description is required'),
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
                                      addIncome();
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
