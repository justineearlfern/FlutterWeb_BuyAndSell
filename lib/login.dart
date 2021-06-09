// Packages
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usdtopeso/dashboard.dart';
import 'package:usdtopeso/widget/login_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogIn> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Map<String, String> _authData = {
    '_email': '',
    '_password': '',
  };

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  Future _submit() async {
    if (formkey.currentState.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard()));
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "USD Buy and Sell",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            labelText: 'Username',
                            suffixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            EmailValidator(errorText: "Enter valid email id"),
                          ]),
                          onSaved: (value) {
                            _authData['_username'] = value;
                          },
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            suffixIcon: Icon(
                              Icons.lock_outline,
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "* Required"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password should be atleast 6 characters"),
                            MaxLengthValidator(15,
                                errorText:
                                    "Password should not be greater than 15 characters")
                          ]),
                          onSaved: (value) {
                            _authData['_username'] = value;
                          },
                        ),
                        SizedBox(
                          height: 64,
                        ),
                        Container(
                          child: GestureDetector(
                              onTap: () {
                                _submit();
                              },
                              child: actionButton("Log In")),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
