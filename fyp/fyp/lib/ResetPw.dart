import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/home.dart';

void main() {
  runApp(ResetPw());
}

class ResetPw extends StatefulWidget {
  const ResetPw({Key? key}) : super(key: key);

  @override
  _ResetPwState createState() => _ResetPwState();
}

class _ResetPwState extends State<ResetPw> {
  bool _isHiddenPassword = true;
  Widget buildNewPw() {
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
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 50,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xff5ac18e)),
                suffixIcon: InkWell(
                  child: Icon(
                      _isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xff5ac18e)),
                ),
                hintText: "Enter your new password",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'Roboto Condensed',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          ),
        )
      ],
    );
  }

  Widget buildConfirmPw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Text(
        //  'Confirm Password',
        //  style: TextStyle(
        //      color: Colors.white,
        //      fontSize: 18,
        //      fontFamily: 'Roboto Condensed',
        //      fontWeight: FontWeight.w300),
        //),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 50,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xff5ac18e)),
                suffixIcon: InkWell(
                  child: Icon(
                    _isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xff5ac18e),
                  ),
                ),
                hintText: "Enter your confirmed password",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'Roboto Condensed',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          ),
        )
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
            'Reset Password',
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
              Container(
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
                        buildNewPw(),
                        SizedBox(height: 20),
                        buildConfirmPw(),
                        SizedBox(height: 15),
                        buildButton(),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
