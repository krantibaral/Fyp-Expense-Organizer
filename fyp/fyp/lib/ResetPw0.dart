import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/ResetPw.dart';

void main() {
  runApp(ResetPw0());
}

class ResetPw0 extends StatefulWidget {
  const ResetPw0({Key? key}) : super(key: key);

  @override
  _ResetPw0State createState() => _ResetPw0State();
}

class _ResetPw0State extends State<ResetPw0> {
  late String _userName;
  final _formKey = GlobalKey<FormState>();

  Widget buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text(
        //  'New Password',
        //  style: TextStyle(
        //      color: Colors.white,
        //      fontSize: 18,
        //      fontFamily: 'Roboto Condensed',
        //      fontWeight: FontWeight.w300),
        //),
        SizedBox(height: 10),
        Container(
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter proper name";
              }
              return null;
            },
            onSaved: (name) {
              _userName = name!;
            },
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(color: Colors.white, width: 0.0),
                ),
                focusedErrorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(color: Colors.white, width: 0.0),
                ),
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.person, color: Color(0xff5ac18e)),
                hintText: "Enter your name",
                hintStyle: TextStyle(
                    color: Colors.black38,
                    fontFamily: 'Roboto Condensed',
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              if (_formKey.currentState!.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ResetPw()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            });
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 50),
            elevation: 5,
            primary: (Color(0xffffffff)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              color: Color(0xff5ac18e),
              fontFamily: 'Roboto Condensed',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Form(
                 key: _formKey,
                child: Container(
                    height: double.infinity,
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
                        ])),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 120,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Center(
                                child: Image.asset(
                              "asset/Logo.png",
                            )),
                          ),
                          SizedBox(height: 20),
                          buildUserName(),
                          buildButton()
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
