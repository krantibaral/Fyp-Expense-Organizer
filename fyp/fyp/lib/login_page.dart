import 'dart:convert';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/ResetPw0.dart';
import 'package:fyp/home.dart';
import 'CreateAccount.dart';
//import 'ResetPw.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late String _userName;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isRememberMe = false;
  bool _isHiddenPassword = true;
  bool visible = false;

  Future<void> userLogin() async {
    setState(() {
      visible = true;
    });

    String name = nameController.text;

    String password = passwordController.text;
    var data = {'name': name, 'password': password};

    var response = await http.post(
        Uri.parse("http://10.20.22.168/myfolder/login/login_user.php"),
        body: json.encode(data));
    var message = jsonDecode(response.body);

    if (message == 'Login Matched') {
      setState(() {
        visible = true;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        visible = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: [
                ElevatedButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          child: TextFormField(
            controller: nameController,
            validator: Validators.compose([
              Validators.required('Name is required'),
              Validators.minLength(5, 'Name cannot be less than 5 characters'),
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
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text(
        //  'Password',
        //  style: TextStyle(
        //      color: Colors.white,
        //      fontSize: 18,
        //      fontFamily: 'Roboto Condensed',
        //      fontWeight: FontWeight.w300),
        //),
        SizedBox(height: 10),
        Container(
          child: TextFormField(
            controller: passwordController,
            validator: Validators.compose([
              Validators.required('Password is required'),
              Validators.patternRegExp(
                  RegExp(
                      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8}$'),
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

  Widget buildForgotPassword() {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ResetPw0()));
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto Condensed',
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            )));
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text("Remember me",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ))
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await userLogin();
              // Navigator.push(context,
              //  MaterialPageRoute(builder: (context) => const HomePage()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
            setState(() {});

            //Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => const HomePage()));
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
            'Login',
            style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 20,
              fontFamily: 'Roboto Condensed',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateAccount()));
        },
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Don\'t have an Account ?  ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Center(
                                child: Image.asset(
                              "asset/Logo.png",
                              //height: 200,
                            )),
                          ),
                          SizedBox(height: 15),
                          buildUsername(),
                          SizedBox(height: 10),
                          buildPassword(),
                          // SizedBox(height: 20),
                          buildForgotPassword(),
                          // SizedBox(height: 20),
                          buildRememberMe(),
                          //SizedBox(height: 20),
                          buildLoginBtn(),
                          //SizedBox(height: 20),
                          buildSignUpBtn(),
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
}
