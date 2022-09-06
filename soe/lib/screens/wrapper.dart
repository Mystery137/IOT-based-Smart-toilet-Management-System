import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soe/models/currentUser.dart';
import 'package:soe/screens/home2.dart';
import 'package:soe/screens/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    if (user == null) {
      return LoginScreen();
    } else {
      return Home2();
    }
  }
}
