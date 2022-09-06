import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:soe/services/auth.dart';
import 'package:soe/shared/loading.dart';

import '../components.dart';
import '../shared/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  String email;
  String password;
  bool showSpin = false;
  bool loading = false;
  // final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: showSpin,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        color: kBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 48.0,
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: kLoginTextFeildDecoration.copyWith(
                              hintText: 'Enter your email',
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kLoginTextFeildDecoration.copyWith(
                              hintText: 'Enter your password',
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          RoundedButton(
                            buttonColor: kBlueColor,
                            buttonTitle: 'Log In',
                            onPressed: () async {
                              if (password != null && email != null) {
                                setState(
                                  () => loading = true,
                                );
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(
                                    () => loading = false,
                                  );
                                  showAlertDialog(context);
                                } else {
                                  print("Signed In Successfuly");
                                  print(result.uid);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      textAlign: TextAlign.center,
      style: TextStyle(color: kBlue),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "\nIncorrect password/email",
      style: TextStyle(color: kBlue),
      textAlign: TextAlign.center,
    ),
    content: Text(
      "Re-enter password/email.",
      style: TextStyle(color: kBlue),
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
    elevation: 24.0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
