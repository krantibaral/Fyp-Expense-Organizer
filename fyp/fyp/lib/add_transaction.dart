import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/controllers/user_controller.dart';
import 'package:fyp/home.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:http/http.dart' as http;

class AddTransaction extends StatefulWidget {
  final String type;
  const AddTransaction({
    Key? key,
    required this.type,
  }) : super(key: key);
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();

  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  // Future addIncome() async {

  //   String amount = amountController.text;
  //   String category = categoryController.text;
  //   String description = descriptionController.text;
  //   String date = dateinput.text;

  //   var data = {
  //     'amount': amount,
  //     'category': category,
  //     'description': description,
  //     'date': date,
  //   };
  //   print(data);

  //   var response = await http.post(
  //       Uri.parse("$kBackendURL/addIncome/addIncome.php"),
  //       body: json.encode(data),
  //       headers: {"Content-Type": "application/json"});
  //   var message = jsonDecode(response.body);
  //   print(message);

  //   if (response.statusCode == 200) {

  //   }
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(message),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //toolbarHeight: 65,
          elevation: 5,

          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: Text('Add ' + (widget.type == 'income' ? "Income" : "Expense"),
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
                                RegExp(r'^[0-9]*$'), 'Accept only numbers'),
                          ]),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
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
                            Validators.minLength(
                                1, 'Category cannot be less than 1 characters'),
                          ]),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
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
                              prefixIcon: Icon(Icons.category,
                                  color: Color(0xff5ac18e)),
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
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
                              true,
                           //set it true, so that user will not able to edit text
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Map toSend = {
                                        'amount': amountController.text,
                                        'category': categoryController.text,
                                        'description':
                                            descriptionController.text,
                                        "date": dateinput.text,
                                        'type': widget.type,
                                        'userid': userController.user!.id,
                                      };

                                      try {
                                        var resp = await http.post(
                                          Uri.parse(kBackendURL +
                                              "/transactions/add.php"),
                                          headers: {
                                            'content-type': 'application/json'
                                          },
                                          body: jsonEncode(toSend),
                                        );
                                        if (resp.statusCode != 200) {
                                          throw Exception(
                                              "Server Error. Status Code: " +
                                                  resp.statusCode.toString());
                                        }
                                        print(resp.body);
                                        var body = jsonDecode(resp.body);
                                        if (body['status'] != 'success') {
                                          throw Exception("Failed: " +
                                              (body['error'] ??
                                                  "Server Error"));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(widget.type +
                                                      " added !!")));
                                          Navigator.of(context).pop("added");
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(e.toString())));
                                      }
                                    }
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
    });
  }
}
