import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/controllers/user_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:http/http.dart' as http;
import 'models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final Transaction transaction;
  const EditTransaction({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  late final Transaction _transactionToEdit = widget.transaction;

  @override
  void initState() {
    super.initState();
    updateValues();
  }

  void updateValues() {
    amountController.text = _transactionToEdit.amount.toString();
    categoryController.text = _transactionToEdit.category.toString();
    dateinput.text = DateFormat('yyyy-MM-dd').format(_transactionToEdit.date);
    descriptionController.text = _transactionToEdit.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, userController, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: Text(
              'Edit ' +
                  (widget.transaction.type == 'income' ? "Income" : "Expense"),
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
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Transaction ?", style: TextStyle(fontFamily: "Roboto Condensed")),
                        content: Text(
                            "This transaction will be deleted. You cant undo this."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel", style: TextStyle( fontFamily: "Roboto Condensed", fontSize: 18, color: Colors.green))),
                          TextButton(
                              onPressed: () async {
                                try {
                                  var resp = await http.post(
                                    Uri.parse(kBackendURL +
                                        "/transactions/delete.php"),
                                    headers: {
                                      'Content-Type': "applications/json",
                                    },
                                    body: jsonEncode(
                                      {
                                        "id": widget.transaction.id,
                                      },
                                    ),
                                  );
                                  if (resp.statusCode != 200) {
                                    throw Exception("Response Status: " +
                                        resp.statusCode.toString());
                                  }
                                  var body = jsonDecode(resp.body);
                                  if (body['status'] != 'success') {
                                    throw Exception(
                                        body['error'] ?? "Server Error");
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Deleted")));
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop("deleted");
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Error: " + e.toString())));
                                }
                              },
                              child: Text("Yes, Delete",style: TextStyle( fontFamily: "Roboto Condensed", fontSize: 18, color: Colors.green))),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete),
            ),
          ],
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
                                RegExp(r'^[0-9\.]*$'), 'Accept only numbers'),
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
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _transactionToEdit.date,
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
                                        'id': widget.transaction.id,
                                      };

                                      try {
                                        var resp = await http.post(
                                          Uri.parse(kBackendURL +
                                              "/transactions/edit.php"),
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
                                                  content: Text(
                                                      widget.transaction.type +
                                                          " edited !!")));
                                          Navigator.of(context).pop("edited");
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
