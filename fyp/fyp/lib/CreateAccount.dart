import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/home.dart';
import 'package:fyp/login_page.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

void main() {
  runApp(CreateAccount());
}

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _isHiddenPassword = true;
  bool visible = false;
  late String _userName;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    setState(() {
      visible = true;
    });

    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    //var url =
    //  'http://192.168.0.108/myfolder/Registration/user_registration.php';
    var data = {'name': name, 'email': email, 'password': password};

    print(data);

    var response = await http.post(
        Uri.parse("http://192.168.100.129/myfolder/Registration/user_registration.php"),
        body: json.encode(data),
        headers: {"Content-Type": "application/json"});
    var message = jsonDecode(response.body);
    print(message);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));

    // Showing Alert Dialog with Response JSON Message.
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

  Widget buildUsername() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Text(
          //  'Username',
          //  style: TextStyle(
          //      color: Colors.white,fontFamily: 'Roboto Condensed', fontSize: 18, fontWeight: FontWeight.w300),
          //),
          SizedBox(height: 10),
          Container(
            child: TextFormField(
              controller: nameController,
              validator: Validators.compose([
                Validators.required('Name is required'),
                Validators.minLength(
                    5, 'Name cannot be less than 5 characters'),
                Validators.maxLength(
                    15, 'Name cannot be greater than 15 characters'),
              ]),
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
          )
        ]);
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text(
        //  'Password',
        //  style: TextStyle(
        //      color: Colors.white, fontFamily: 'Roboto Condensed', fontSize: 18, fontWeight: FontWeight.w300),
        //),
        SizedBox(height: 10),
        Container(
          child: TextFormField(
            controller: emailController,
            validator: Validators.compose([
              Validators.required('Email is required'),
              Validators.patternString(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                  'Valid email is required'),
            ]),
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
                prefixIcon: Icon(Icons.email, color: Color(0xff5ac18e)),
                hintText: "Enter your email",
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

  Widget buildPassword1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text(
        //  'Password',
        //  style: TextStyle(
        //      color: Colors.white, fontFamily: 'Roboto Condensed', fontSize: 18, fontWeight: FontWeight.w300),
        //),
        SizedBox(height: 10),
        Container(
          child: TextFormField(
            controller: passwordController,
            validator: Validators.compose([
              Validators.required('Password is required'),
              Validators.patternString(
                  r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  'Password must have 8 characters\nMinimum 1 Upper_case\nMinimum 1 Lower_case\nMinimum 1 Numeric_Number\nMinimum 1 Special Character'),
            ]),
            obscureText: _isHiddenPassword,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.circular(10),
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
                prefixIcon: Icon(Icons.lock, color: Color(0xff5ac18e)),
                suffixIcon: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                      _isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xff5ac18e)),
                ),
                hintText: "Enter your password",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'Roboto Condensed',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
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
                userRegistration();

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
            'Signup',
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

  Widget buildLoginUpBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Already have an Account ?  ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ));
  }

  Widget build(BuildContext Context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(children: [
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Image.asset(
                        "asset/Logo.png",
                        height: 200,
                      )),
                      SizedBox(height: 20),
                      buildUsername(),
                      SizedBox(height: 15),
                      buildPassword(),
                      //SizedBox(height: 15),
                      SizedBox(height: 15),
                      buildPassword1(),
                      buildButton(),
                      Visibility(
                          visible: visible,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: CircularProgressIndicator(),
                          )),
                      buildLoginUpBtn(),
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}
